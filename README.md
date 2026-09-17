<div align="center">
    <h1>📦 SOKO</h1>
    <b>Smart Multi-Inventory Management for Clothing Brands</b>
</div>

<div align="center">
    <sub>
        <a href="README.md">English</a> · <a href="docs/languages/readme/README.es.md">Español</a> · <a href="docs/languages/readme/README.ru.md">Русский</a> · <a href="docs/languages/readme/README.ja.md">日本語</a> · <a href="docs/languages/readme/README.ko.md">한국어</a> · <a href="docs/languages/readme/README.pt.md">Português</a> · <a href="docs/languages/readme/README.fr.md">Français</a> · <a href="docs/languages/readme/README.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![GitHub last commit - Dynamic](https://img.shields.io/github/last-commit/eldomiinus/soko?style=for-the-badge&logo=Git&logoColor=65686B&label=Last%20Commit&labelColor=101418&color=99CCFF)](https://github.com/eldomiinus/SOKO/activity)
[![GitHub Repo stars - Dynamic](https://img.shields.io/github/stars/eldomiinus/soko?style=for-the-badge&logo=GitHub-Sponsors&logoColor=65686B&label=Stars&labelColor=101418&color=BBBBDD)](https://github.com/eldomiinus/SOKO/stargazers)
[![GitHub repo size - Dynamic](https://img.shields.io/github/repo-size/eldomiinus/soko?style=for-the-badge&logo=GitHub&logoColor=65686B&label=Repo%20Size&labelColor=101418&color=BBBBDD)](https://github.com/eldomiinus/SOKO)
    <br>
[![Framework - Static](https://img.shields.io/badge/Electron-Framework?style=for-the-badge&logo=Electron&logoColor=FFFFFF&label=Framework&labelColor=101418&color=99CCFF)](https://www.electronjs.org/)
[![Database - Static](https://img.shields.io/badge/SQLite-Database?style=for-the-badge&logo=SQLite&logoColor=65686B&label=Database&labelColor=101418&color=99CCFF)](https://www.sqlite.org/index.html)
[![Ecosystem - Static](https://img.shields.io/badge/Kyro-Ecosystem?style=for-the-badge&logo=Moleculer&logoColor=65686B&label=Ecosystem&labelColor=101418&color=BBBBDD)](#)
[![Ko-Fi - Static](https://img.shields.io/badge/Donate-KoFi?style=for-the-badge&logo=Ko-Fi&logoColor=FFFFFF&label=Ko-Fi&labelColor=101418&color=FF5555)](https://ko-fi.com/eldomiinus)

</div>

> **"The chaos of traditional stock management ends here."** SOKO is comprehensive desktop software designed for emerging *alternative* fashion brands, showrooms, and textile entrepreneurs managing limited releases or *drops*. It lets you control the complete lifecycle of every garment through an advanced variant system, managing warehouses, stores, and temporary events in real time without losing a single unit.

<br>

## 📑 Table of Contents
- [🚀 Main Features](#-main-features)
- [🏗️ Architecture and Technologies](#️-architecture-and-technologies)
- [🔗 The Kyro Modular Ecosystem](#-the-kyro-modular-ecosystem)
- [🗺️ Development and Progress](#️-development-and-progress)
- [⚙️ Installation](#️-installation)
- [📈 Statistics](#-statistics)

<br>

## 🚀 Main Features

- **🌐 Dynamic Multi-Inventory:** Create independent stock spaces (Permanent Store, Central Warehouse, Weekend Fairs). Safely transfer garments between locations through relational transactions and, when archiving a temporary event, automatically return leftovers to central stock.
- **🧬 Variant System (Multi-Level):** Configure a "Parent Product" and break down inventory for each *Size* and *Color* combination with precise, individual stock control.
- **🏷️ Label Generator:** Automated SKU assignment per variant and export of PDF templates ready to print physical labels with their corresponding barcodes and prices.
- **⚡ Bulk Catalog Actions:** Select multiple variants simultaneously to apply percentage price increases or change operational statuses (e.g., from *In Production* to *Available*) with a single click.
- **📒 Integrated Supplier Directory:** An internal address book linked to the technical specification sheet for storing the exact contacts of garment-making and screen-printing workshops associated with each batch, essential for streamlining successful repeat production.
- **📉 "Dead Stock" Report:** An intelligent analytics panel that detects garments left immobile in inventory for more than 60 days, providing the essential metric for planning clearances or special promotions.

<br>

## 🏗️ Architecture and Technologies

> [!NOTE]
> SOKO is designed around an **Offline-First** architecture, prioritizing native performance, complete portability (to operate smoothly at fairs without an internet connection), and absolute privacy for local data.

### 💻 Technology Stack

<div align=center>

| Layer | Technology | Description |
| :--- | :--- | :--- |
| **🎨 Frontend (UI/UX)** | HTML5, CSS3, Vanilla JS | Interface structured with CSS Grid. Native *Dark Mode* design (*cyber/tech* aesthetic), frameless window, and dynamic collapsible panels. |
| **⚙️ Backend** | Node.js + Electron | Native desktop application packaging, ensuring high performance, secure window management, and deep access to the local file system. |
| **💾 Database** | SQLite3 | Local relational engine (single file) stored in `userData`. Supports safe ACID transactions and guarantees portability. |

</div>

### 📂 Data Flow and Storage
1. **Relational Normalization:** Strict separation between the identity of the garment (the general catalog) and its physical location (the inventories) using transactional bridge tables (*Inventory_Stock*), completely eliminating data duplication.
2. **Optimized Multimedia Management:** Storing heavy images (BLOBs) in the database is strictly prohibited. Photographs are transparently copied to a local directory, and SQLite only stores their relative paths. This keeps the database ultra-lightweight, ensuring response times of milliseconds.

<br>

## 🔗 The Kyro Modular Ecosystem

SOKO is designed with a modular architecture to serve as the core of a scalable, customizable work environment that adapts to the entrepreneur's operational and financial growth:

- **📦 SOKO (Core):** The main engine for comprehensive catalog management, multi-space logistics, and thorough variant control.
- **🛒 SOKO POS (Checkout Extension - Coming Soon):** An optional, independent, ultra-lightweight module designed exclusively for counter use. It integrates support for laser barcode scanners and fast total calculation. It acts as a "light client" that connects to the same local SQLite database to deduct stock in real time, without requiring the main administration application to be open.
- **📊 KURA (Finance - Coming Soon):** A high-level financial platform that synchronizes to automatically receive monetary revenue from sales recorded by SOKO/POS, consolidating operational and financial control into a single automated workflow.

<br>

## 🗺️ Development and Progress

### 📌 Planning and Structure Phases
- [x] Architecture and relational Database definition ([`SQLite`](https://www.sqlite.org/index.html)).
- [x] Requirements, user flows, and Multi-Inventory specification.
- [x] UI/UX Design Guide and color palette (*Dark Mode* / *Cyber tech*).
- [x] Architectural design of the Kyro Modular Ecosystem (SOKO, POS, and KURA).

### 🎨 Frontend Development Phases
- [x] Layout of the base UI architecture (CSS Grid, 4 functional zones).
- [x] Implementation of native behavior (Frameless Window and draggable Top Bar).
- [x] Development of collapsible Sidebar and dynamic Details Panel (interactive Mockup).
- [ ] Connection of the frontend to the SQLite template/data engine.

### 💼 Backend and Logic Development Phases
- [x] Configuration of the Node.js environment and Electron dependencies.
- [x] Compilation of native binaries and exclusion of `node_modules` from Git.
- [x] Automatic initialization of the local database (`soko.db`) in the user directory.
- [ ] Creation of the CRUD module for "Parent Product" and its Variant breakdown.
- [ ] Development of the secure transaction engine for stock transfers.
- [ ] Implementation of Auxiliary Modules: Label Generation, Bulk Actions, and Dead Stock Detection.

<br>

## ⚙️ Installation

Follow these steps to set up the SOKO environment on your local machine and start contributing to development.

```bash
# 1. Clone the official repository
git clone https://github.com/eldomiinus/soko.git

# 2. Navigate to the project root directory
cd soko

# 3. Install the project dependencies
npm install

# 4. Ensure the native modules (SQLite3) compile correctly
npm rebuild sqlite3

# 5. Run the application in development mode
npm start
```

<br>

## 📈 Statistics

<div align=center>
<a href="https://www.star-history.com/?repos=eldomiinus%2Fsoko&type=date&legend=bottom-right">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&theme=dark&legend=top-left" />
        <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
        <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
    </picture>
</a>
</div>

<br>

<div align="center">

<h2>¡Thank you for your attention! <3</h2>

[![GitHub License - Static](https://img.shields.io/badge/MIT-License?style=for-the-badge&logo=GitBook&label=License&labelColor=101418&color=BBBBDD)](https://github.com/eldomiinus/SOKO?tab=License-1-ov-file)

</div>
