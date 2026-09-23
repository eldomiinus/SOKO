<div align="center">
    <h1>🛡️ SOKO Security Policy</h1>
    <b>Privacy by design, offline-first architecture, and local data control.</b>
</div>

<div align="center">
    <sub>
        <a href="SECURITY.md">English</a> · <a href="docs/languages/security/SECURITY.es.md">Español</a> · <a href="docs/languages/security/SECURITY.ru.md">Русский</a> · <a href="docs/languages/security/SECURITY.ja.md">日本語</a> · <a href="docs/languages/security/SECURITY.ko.md">한국어</a> · <a href="docs/languages/security/SECURITY.pt.md">Português</a> · <a href="docs/languages/security/SECURITY.fr.md">Français</a> · <a href="docs/languages/security/SECURITY.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![Privacy First - Static](https://img.shields.io/badge/Privacity-Data?style=for-the-badge&logo=GoogleAppsScript&logoColor=65686B&label=Data&labelColor=101418&color=99CCFF)](#)
[![Encryption - Static](https://img.shields.io/badge/AES_256-Encryption?style=for-the-badge&logo=LetsEncrypt&logoColor=65686B&label=Encryption&labelColor=101418&color=BBBBDD)](#)

</div>

> **SOKO** treats user data privacy as an absolute priority. Designed for independent brands and entrepreneurs, our security model ensures that you own your data. We do not track, collect, or remotely store your inventory data without your explicit consent.

<br>

## 🏗️ Security Architecture & Data Privacy

Our security relies on a strict **Offline-First** architecture. The local SQLite database guarantees total control and absolute privacy of your information without depending on internet connections.

### 🔐 Database Encryption (SQLCipher)
To protect your sensitive business data from unauthorized local access, SOKO implements **SQLCipher**. 
* The physical SQLite file (`soko.db`) is protected against intruders via a password or PIN. 
* This encryption layer operates transparently and does not alter the structural rules of the database (such as the `CHECK` constraints designed to prevent negative stock).
* **Zero-Knowledge PIN:** The PIN or master password that unlocks SQLCipher is **never** saved inside the database. If a malicious actor extracts the `.db` file, it remains completely unreadable without your credential.

### 📦 Safe Backups & File System
To prevent data corruption and ensure fast, secure backups, SOKO isolates media from raw data.
* **No BLOBs allowed:** The database engine strictly saves text paths (`image_path: TEXT`) and rejects the direct storage of heavy files (BLOBs) inside the relational tables.
* **Encrypted Exports:** When generating a backup, the system safely unifies the encrypted database file and the local image folder into a portable `.zip` file, making it easy and secure to migrate your showroom data between devices.

<br>
<hr>
<br>

## 📢 Reporting a Vulnerability

If you discover a security vulnerability within SOKO (e.g., an exploit in the Electron window rendering, an issue bypassing the SQLite PIN, or an unexpected data leak), please **DO NOT** open a public issue.

Instead, please report it privately to our team so we can address it responsibly:

1. Email your findings to: **[kyroshop.exe@gmail.com](mailto:kyroshop.exe@gmail.com)**
2. Include a detailed description of the vulnerability.
3. Provide steps to reproduce the issue (logs, OS version, or screenshots are highly appreciated).

We take all security reports seriously and will reply as soon as possible to coordinate a patch before public disclosure.

<br>

### 🗃️ Supported Versions
Currently, as SOKO is in its early development stages, only the `main` branch and the latest pre-release versions receive security updates.

<div align=center>

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | ✅ Active          |
| < 1.0   | ❌ Not Supported   |

</div>
