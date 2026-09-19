<div align="center">
    <h1>🗄️ SOKO Database Schema</h1>
    <b>Relational architecture, data integrity, and local storage rules.</b>
</div>

<div align="center">
    <sub>
        <a href="DATABASE.md">English</a> · <a href="languages/database/DATABASE.es.md">Español</a> · <a href="languages/database/DATABASE.ru.md">Русский</a> · <a href="languages/database/DATABASE.ja.md">日本語</a> · <a href="languages/database/DATABASE.ko.md">한국어</a> · <a href="languages/database/DATABASE.pt.md">Português</a> · <a href="languages/database/DATABASE.fr.md">Français</a> · <a href="languages/database/DATABASE.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![SQLite - Static](https://img.shields.io/badge/SQLite_3-Database?style=for-the-badge&logo=SQLite&logoColor=FFFFFF&label=Engine&labelColor=101418&color=99CCFF)](#)
[![Integrity - Static](https://img.shields.io/badge/Strict-Integrity?style=for-the-badge&logo=Databricks&label=Relations&labelColor=101418&color=BBBBDD)](#)

</div>

> This document details the exact structure, constraints, and business logic of the SOKO local database. We utilize a strictly relational model to ensure data consistency across multiple inventories without relying on cloud synchronization.

<br>

## ⚙️ Core Technical Rules

Before interacting with or modifying the schema, developers must adhere to the following principles:

* **Strict Foreign Keys:** We explicitly enforce `PRAGMA foreign_keys = ON;` on every connection. No orphaned records are allowed.
* **No BLOBs Allowed:** Storing media files directly in the database is strictly prohibited to maintain millisecond query speeds. Save images to the local file system and store only the text path (`image_path`).
* **No Negative Stock:** Physical stock cannot drop below zero. Transactional queries must rely on `CHECK (quantity >= 0)` constraints at the database level.

<br>

## 📑 Data Dictionary

### 1. `Suppliers` (Directory)
Records the manufacturers, textile providers, and screen-printing workshops for future restocking.

| Field | Type | Rules & Description |
| :--- | :--- | :--- |
| `id` | INTEGER | Primary Key. Auto-incremental. |
| `name` | TEXT | **NOT NULL.** Name of the supplier/workshop. |
| `contact_info` | TEXT | Phone, email, or physical address. |
| `service_type` | TEXT | E.g., Sewing, Screen-printing, Fabric Provider. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 2. `Products_Variants` (Central Catalog)
Defines the immutable identity of each garment. **It does not store stock quantities.**

| Field | Type | Rules & Description |
| :--- | :--- | :--- |
| `id` | INTEGER | Primary Key. Auto-incremental. |
| `sku` | TEXT | **UNIQUE. NOT NULL.** E.g., `PANT-BAGGY-38-BLU`. |
| `parent_name` | TEXT | **NOT NULL.** Base model name (e.g., Parachute Pants). |
| `category` | TEXT | **NOT NULL.** For filtering (Pants, T-Shirts, Hoodies). |
| `fit` | TEXT | Garment cut (Baggy, Oversized, Slim, Regular). |
| `size` | TEXT | **NOT NULL.** Physical size (S, M, L, XL, 38, 40). |
| `color` | TEXT | **NOT NULL.** Dominant color or print variant. |
| `fabric` | TEXT | Textile composition (e.g., Denim 12oz). |
| `supplier_id` | INTEGER | **Foreign Key** linking to `Suppliers(id)`. |
| `status` | TEXT | `AVAILABLE`, `IN_PRODUCTION`, `RESERVED`, `ARCHIVED`. |
| `cost_price` | DECIMAL | Manufacturing unit cost (crucial for financial modules). |
| `sale_price` | DECIMAL | Final retail price. |
| `barcode` | TEXT | **UNIQUE.** EAN/UPC code for laser scanners. |
| `image_path` | TEXT | Local absolute/relative path to the `.jpg/.png` file. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 3. `Inventories` (Locations)
Manages the physical or logical spaces where SOKO stores merchandise.

| Field | Type | Rules & Description |
| :--- | :--- | :--- |
| `id` | INTEGER | Primary Key. Auto-incremental. |
| `name` | TEXT | **NOT NULL.** E.g., Central Warehouse, Palermo Fair. |
| `type` | TEXT | Nature of the space: `Fijo` (Fixed), `Temporal`, `Transito`. |
| `is_active` | BOOLEAN | `1` = Active, `0` = Archived/Closed. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 4. `Inventory_Stock` (The Transactional Bridge)
The core table that enables the Multi-Inventory logic. It links a specific product variant to a specific location and tracks its quantity in real-time.

| Field | Type | Rules & Description |
| :--- | :--- | :--- |
| `inventory_id` | INTEGER | **Foreign Key** linking to `Inventories(id)`. |
| `variant_id` | INTEGER | **Foreign Key** linking to `Products_Variants(id)`. |
| `quantity` | INTEGER | **NOT NULL.** `DEFAULT 0`. Constraint: `CHECK (quantity >= 0)`. |
| `last_updated` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. Crucial for Dead Stock reports. |

> **Note:** The Primary Key for `Inventory_Stock` is a composite of `(inventory_id, variant_id)` to prevent duplicate variant records within the same location.

### 5. `App_Settings` (System Preferences)
Isolated table for local application preferences, keeping them strictly separated from operational inventory data.

| Field | Type | Rules & Description |
| :--- | :--- | :--- |
| `id` | INTEGER | Primary Key. |
| `theme` | TEXT | E.g., `dark`, `light`, `system`. |
| `last_backup` | TIMESTAMP | Records the exact date and time of the last `.zip` export. |
