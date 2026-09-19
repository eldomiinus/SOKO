<div align="center">
    <h1>⚙️ SOKO Architecture</h1>
    <b>The technical foundation of our Offline-First ecosystem.</b>
</div>

<div align="center">
    <sub>
        <a href="ARCHITECTURE.md">English</a> · <a href="languages/architecture/ARCHITECTURE.es.md">Español</a> · <a href="languages/architecture/ARCHITECTURE.ru.md">Русский</a> · <a href="languages/architecture/ARCHITECTURE.ja.md">日本語</a> · <a href="languages/architecture/ARCHITECTURE.ko.md">한국어</a> · <a href="languages/architecture/ARCHITECTURE.pt.md">Português</a> · <a href="languages/architecture/ARCHITECTURE.fr.md">Français</a> · <a href="languages/architecture/ARCHITECTURE.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![Offline First - Static](https://img.shields.io/badge/Architecture-Offline_First?style=for-the-badge&logo=Databricks&label=Architecture&labelColor=101418&color=99CCFF)](#)
[![IPC Bridge - Static](https://img.shields.io/badge/Electron-IPC_Bridge?style=for-the-badge&logo=Electron&label=Communication&labelColor=101418&color=BBBBDD)](#)

</div>

> **SOKO** is built as a native desktop application designed to guarantee native performance, absolute data privacy, and full operability during temporary fairs without relying on an internet connection. This document outlines how the Frontend, Backend, and Database interact within this environment.

<br>

## 🖥️ 1. The Electron IPC Communication Model

Because SOKO is packaged with **Electron**, we maintain a strict separation of concerns between the user interface and the system resources for security and performance:

* **Frontend (Renderer Process):** Built with HTML5, CSS3 (Grid), and Vanilla JS. It handles the UI/UX, animations, and captures user inputs. **It never touches the database directly.**
* **IPC Bridge (Context Bridge):** We use Electron's `preload.js` to expose a secure API to the frontend.
* **Backend (Main Process):** Runs on Node.js. It listens to the IPC channels sent by the Frontend, executes the heavy logical operations, reads/writes to the local file system, and queries the SQLite database.

## 💾 2. Database Engine & File System

The core of our data storage relies on a relational model using **SQLite 3**. We enforce strict technical rules to keep the application lightning-fast:

### The "No BLOBs" Rule
Using BLOB fields to store images inside the database is strictly prohibited. Storing heavy media directly in SQLite causes severe database bloat and performance degradation.
* **How we handle it:** The backend saves the physical image files in a local directory tree (e.g., `/assets/images/catalog/`).
* The database only stores the text string of the local path (`image_path: TEXT`) pointing to that file.

### Data Integrity & Settings
* **Strict Relations:** We explicitly enforce `PRAGMA foreign_keys = ON;` on every connection to guarantee data integrity across suppliers, products, and inventories.
* **Application Settings:** System preferences (like dark mode state or last backup date) are isolated in a separate `App_Settings` table to prevent cluttering transactional inventory data.

## 📦 3. Multi-Inventory Logic (The Bridge)

SOKO's defining feature is its ability to manage multiple physical locations simultaneously (e.g., Central Warehouse, Pop-up Stores, Fairs). 

Locations are categorized by their nature (`type`): *Fijo* (Fixed), *Temporal* (Temporary), or *Transito* (In-Transit).

### The Transactional Bridge
We avoid duplicate product entries by using a bridge table called `Inventory_Stock`. 
* When stock is moved to a weekend fair, the system natively deducts units from the "Central Warehouse" and assigns them to the "Fair" inventory through safe SQL transactions. 
* Once the fair concludes, the remaining stock is transferred back.
* **Safety First:** We utilize `CHECK` constraints on the database level to ensure physical stock can **never** be negative.

## 🔗 4. The Modular Ecosystem

SOKO acts as the core engine of a scalable environment. Its database architecture is prepared to be consumed by upcoming extensions:

1. **SOKO POS:** A future checkout extension for cashiers to scan barcodes and deduct stock seamlessly in real time.
2. **KURA Integration:** A future module where every item marked as "Sold" in SOKO will automatically trigger a monetary revenue entry in the KURA financial system, unifying operational and economic control.
