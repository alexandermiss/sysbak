#!/bin/sh

. ./src/menu.sh
. ./src/log.sh
. ./src/constants.sh
. ./src/try-catch.sh


backup(){
    logInfo "Generating backup..."

    local DB_HOST=$1
    local DB_USER=$2
    local DB_NAME=$3
    local DB_PASSWORD=$4
    local DML_DATA_BACKUP=$5

    export PGPASSWORD="${DB_PASSWORD}"
    $PGDUMP -h $DB_HOST -U $DB_USER $DB_NAME > $DML_DATA_BACKUP

    logInfo "Backup generated in $DML_DATA_BACKUP"
}

restore(){
    logInfo "Restoring backup..."

    local DB_HOST=$1
    local DB_USER=$2
    local DB_PORT=$3
    local DB_PASSWORD=$4
    local DB_NAME=$5
    local DML_DATA_BACKUP=$6

    export PGPASSWORD="${DB_PASSWORD}"

    $PSQL -h $DB_HOST -p $DB_PORT -U $DB_USER -c "DROP DATABASE IF EXISTS $DB_NAME;"
    $PSQL -h $DB_HOST -p $DB_PORT -U $DB_USER -c "CREATE DATABASE $DB_NAME;"

    $PSQL -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -a -f $DML_DATA_BACKUP

    logInfo "Backup restored"
}


main(){
    PSQL="${CONFIG[PSQL]} -q"
    PGDUMP="${CONFIG[PGDUMP]}"

    local ALL_DATABASES=$(allDatabases)

    echo "Select a database:"
    SELECTED_DATABASE=$(menuDatabases)

    if [[ "${ALL_DATABASES[*]}" =~ "${SELECTED_DATABASE}" ]]; then
        logInfo "Database selected: $SELECTED_DATABASE"

        local MY_DB=$(getConfigDatabase $SELECTED_DATABASE)

        local MY_DB_NO_PASS=$(echo "$MY_DB" | jq 'del(.password)')
        logInfo "Database config: $MY_DB_NO_PASS"

        local CONN_NAME=$(getConfigByAttr $MY_DB "name")
        local CONN_HOST=$(getConfigByAttr $MY_DB "host")
        local CONN_USER=$(getConfigByAttr $MY_DB "user")
        local CONN_DB=$(getConfigByAttr $MY_DB "db")
        local CONN_PASSWORD=$(getConfigByAttr $MY_DB "password")
        local CONN_PORT=$(getConfigByAttr $MY_DB "port")

        local UTC_DATE=$(date -u +'%Y-%m-%dT%H-%M-%SZ')
        local DML_DATA_BACKUP="./sqls/"$CONN_DB"_data_${UTC_DATE}.sql"

        logInfo "Generating file... $DML_DATA_BACKUP"

        try
        (
            backup $CONN_HOST $CONN_USER $CONN_DB $CONN_PASSWORD $DML_DATA_BACKUP
        )
        catch || {
            throw $ex_code
        }

        try
        (
            restore ${LOCAL[host]} ${LOCAL[user]} ${LOCAL[port]} ${LOCAL[password]} ${LOCAL[db]} $DML_DATA_BACKUP
        )
        catch || {
            throw $ex_code
        }

        export PGPASSWORD=""

    else
        logError "Invalid selection. Exiting..."
        exit 1
    fi
}

main
