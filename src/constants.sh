#!/bin/sh

# configuration
declare -A CONFIG=(
    [PSQL]="psql"
    [PGDUMP]="pg_dump"
)

declare -a ACTIONS=(
  "Backup"
  "Restore"
  "Exit"
)

declare -A LOCAL=(
    [host]="127.0.0.1"
    [port]="5432"
    [user]=""
    [password]=""
    [db]=""
)
