<div align="center">
    <h1>🗄️ Schema del database SOKO</h1>
    <b>Architettura relazionale, integrità dei dati e regole di archiviazione locale.</b>
</div>

<div align="center">
    <sub>
        <a href="../DATABASE.md">English</a> · <a href="DATABASE.es.md">Español</a> · <a href="DATABASE.ru.md">Русский</a> · <a href="DATABASE.ja.md">日本語</a> · <a href="DATABASE.ko.md">한국어</a> · <a href="DATABASE.pt.md">Português</a> · <a href="DATABASE.fr.md">Français</a> · <a href="DATABASE.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![SQLite - Static](https://img.shields.io/badge/SQLite_3-Database?style=for-the-badge&logo=SQLite&logoColor=FFFFFF&label=Engine&labelColor=101418&color=99CCFF)](#)
[![Integrity - Static](https://img.shields.io/badge/Strict-Integrity?style=for-the-badge&logo=Databricks&label=Relations&labelColor=101418&color=BBBBDD)](#)

</div>

> Questo documento descrive la struttura esatta, i vincoli e la logica aziendale del database locale di SOKO. Utilizziamo un modello strettamente relazionale per garantire la coerenza dei dati tra più inventari senza dipendere dalla sincronizzazione cloud.

<br>

## ⚙️ Regole tecniche principali

Prima di interagire con lo schema o modificarlo, gli sviluppatori devono rispettare i seguenti principi:

* **Chiavi esterne rigorose:** Applichiamo esplicitamente `PRAGMA foreign_keys = ON;` a ogni connessione. Non sono ammessi record orfani.
* **BLOB non consentiti:** L'archiviazione diretta di file multimediali nel database è severamente vietata per mantenere velocità di query nell'ordine dei millisecondi. Salva le immagini nel file system locale e memorizza solo il percorso testuale (`image_path`).
* **Nessuno stock negativo:** Lo stock fisico non può scendere sotto zero. Le query transazionali devono basarsi sui vincoli `CHECK (quantity >= 0)` a livello di database.

<br>

## 📑 Dizionario dei dati

### 1. `Suppliers` (directory)
Registra i produttori, i fornitori tessili e i laboratori di serigrafia per futuri rifornimenti.

| Campo | Tipo | Regole e descrizione |
| :--- | :--- | :--- |
| `id` | INTEGER | Chiave primaria. Auto-incrementale. |
| `name` | TEXT | **NOT NULL.** Nome del fornitore/laboratorio. |
| `contact_info` | TEXT | Telefono, e-mail o indirizzo fisico. |
| `service_type` | TEXT | Ad es., cucito, serigrafia, fornitore di tessuti. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 2. `Products_Variants` (catalogo centrale)
Definisce l'identità immutabile di ogni capo. **Non memorizza quantità di stock.**

| Campo | Tipo | Regole e descrizione |
| :--- | :--- | :--- |
| `id` | INTEGER | Chiave primaria. Auto-incrementale. |
| `sku` | TEXT | **UNIQUE. NOT NULL.** Ad es., `PANT-BAGGY-38-BLU`. |
| `parent_name` | TEXT | **NOT NULL.** Nome del modello base (ad es., pantaloni paracadute). |
| `category` | TEXT | **NOT NULL.** Per il filtraggio (pantaloni, t-shirt, felpe con cappuccio). |
| `fit` | TEXT | Taglio del capo (Baggy, Oversized, Slim, Regular). |
| `size` | TEXT | **NOT NULL.** Taglia fisica (S, M, L, XL, 38, 40). |
| `color` | TEXT | **NOT NULL.** Colore dominante o variante di stampa. |
| `fabric` | TEXT | Composizione tessile (ad es., Denim 12oz). |
| `supplier_id` | INTEGER | **Chiave esterna** collegata a `Suppliers(id)`. |
| `status` | TEXT | `AVAILABLE`, `IN_PRODUCTION`, `RESERVED`, `ARCHIVED`. |
| `cost_price` | DECIMAL | Costo unitario di produzione (cruciale per i moduli finanziari). |
| `sale_price` | DECIMAL | Prezzo finale al dettaglio. |
| `barcode` | TEXT | **UNIQUE.** Codice EAN/UPC per scanner laser. |
| `image_path` | TEXT | Percorso locale assoluto/relativo al file `.jpg/.png`. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 3. `Inventories` (ubicazioni)
Gestisce gli spazi fisici o logici in cui SOKO conserva la merce.

| Campo | Tipo | Regole e descrizione |
| :--- | :--- | :--- |
| `id` | INTEGER | Chiave primaria. Auto-incrementale. |
| `name` | TEXT | **NOT NULL.** Ad es., magazzino centrale, fiera di Palermo. |
| `type` | TEXT | Natura dello spazio: `Fijo` (Fixed), `Temporal`, `Transito`. |
| `is_active` | BOOLEAN | `1` = Attivo, `0` = Archiviato/Chiuso. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 4. `Inventory_Stock` (il ponte transazionale)
La tabella centrale che abilita la logica multi-inventario. Collega una variante specifica del prodotto a una specifica ubicazione e ne monitora la quantità in tempo reale.

| Campo | Tipo | Regole e descrizione |
| :--- | :--- | :--- |
| `inventory_id` | INTEGER | **Chiave esterna** collegata a `Inventories(id)`. |
| `variant_id` | INTEGER | **Chiave esterna** collegata a `Products_Variants(id)`. |
| `quantity` | INTEGER | **NOT NULL.** `DEFAULT 0`. Vincolo: `CHECK (quantity >= 0)`. |
| `last_updated` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. Cruciale per i report di Dead Stock. |

> **Nota:** La chiave primaria di `Inventory_Stock` è composta da `(inventory_id, variant_id)` per impedire record di varianti duplicati nella stessa ubicazione.

### 5. `App_Settings` (preferenze di sistema)
Tabella isolata per le preferenze locali dell'applicazione, che le mantiene rigorosamente separate dai dati operativi dell'inventario.

| Campo | Tipo | Regole e descrizione |
| :--- | :--- | :--- |
| `id` | INTEGER | Chiave primaria. |
| `theme` | TEXT | Ad es., `dark`, `light`, `system`. |
| `last_backup` | TIMESTAMP | Registra la data e l'ora esatte dell'ultima esportazione `.zip`. |
