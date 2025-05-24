# 🗄️ SysBak

> **Automated Database Backup Tool**

SysBak is a lightweight CLI utility for generating PostgreSQL database backups with ease and style. Ideal for developers, sysadmins, and hobbyists who want reliable, streamlined backups.

## 🗺️ ASCII Backup Flow Diagram

```
+-------------------+            +--------+            +-------------------+
|  Remote Database  | -- dump -->| SysBak |-- import ->|  Local Database   |
+-------------------+            +--------+            +-------------------+
         |                                                    ^
         | <----------------- backup/restore -----------------|
```

SysBak extracts a copy of your remote database and deposits it into your local database for secure backup and restoration.

---

## 📖 Table of Contents
- 📝 [Overview](#-overview)
- ⚙️ [Requirements](#️-requirements)
- 🚀 [Setup](#-setup)
- 🛠️ [Usage](#-usage)
- 🖼️ [Screenshots](#-screenshots)
- 🤝 [Contributing](#-contributing)
- 📄 [License](#-license)

---

## 📝 Overview
SysBak provides a simple, interactive way to back up your PostgreSQL databases using bash scripting and a modern TUI powered by Gum.

**Features:**
- Interactive database selection 🧑‍💻
- Easy to install & use ⚡
- Minimal dependencies 🔗
- Clean, readable logs 📋

---

## ⚙️ Requirements
| 🧩 Dependency | Version |
|--------------|---------|
| 🐚 Bash       | 5.2.37  |
| 🍬 Gum        | 0.16.0  |
| 🐘 psql       | 17.4    |

---

## 🚀 Setup

```sh
# Clone the repo
git clone https://github.com/alexandermiss/sysbak.git
cd sysbak

# Install dependencies (ensure Gum and psql are in your PATH)
# See https://github.com/charmbracelet/gum for Gum installation

# (Optional) Make executable
chmod +x src/main.sh
```

**Step 1: Configure your local credentials**
Edit the file `constants.sh` to add your local PostgreSQL credentials and backup preferences.

**Step 2: Add your remote database connections**
Create or edit `config.json` to include the connection details for your remote databases you wish to back up. Use `config.json.local` as an example template, copying its structure and replacing the values with your own connection information.

---

## 🛠️ Usage

Generate a backup interactively:

```sh
make backup
```

Or run the backup script directly:

```sh
./src/main.sh
```

**How it works:**
1. Select the database from a TUI menu.
2. SysBak creates a timestamped backup file in your configured directory.
3. Logs are printed for traceability.

---

## 🖼️ Screenshots

```
➜ sysbak make backup
Select a database:
23 May 25 14:23 CST INFO Database selected: linguanski
```

<div style="display: flex; gap: 2rem; align-items: center;">
  <img src="assets/output.gif" alt="SysBak Live Demo" />
</div>

---

## 🤝 Contributing
- Fork this repo
- Create a feature branch
- Commit your changes
- Open a pull request 🚀

All contributions are welcome! Please use clear commit messages and follow the existing style.

---

## 📄 License
This project is licensed under the MIT License.

---

<div align="center" style="margin-top:2em; font-size: 1.1em;">
  Made with ❤️ by <b>@AlexanderMiss</b>
</div>
