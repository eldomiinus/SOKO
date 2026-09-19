<div align="center">
    <h1>🗄️ Schéma de base de données SOKO</h1>
    <b>Architecture relationnelle, intégrité des données et règles de stockage local.</b>
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

> Ce document détaille la structure exacte, les contraintes et la logique métier de la base de données locale de SOKO. Nous utilisons un modèle strictement relationnel afin d'assurer la cohérence des données sur plusieurs inventaires sans dépendre de la synchronisation cloud.

<br>

## ⚙️ Règles techniques fondamentales

Avant d'interagir avec le schéma ou de le modifier, les développeurs doivent respecter les principes suivants :

* **Clés étrangères strictes :** Nous appliquons explicitement `PRAGMA foreign_keys = ON;` à chaque connexion. Aucun enregistrement orphelin n'est autorisé.
* **Aucun BLOB autorisé :** Le stockage direct de fichiers multimédias dans la base de données est strictement interdit afin de conserver des vitesses de requête de l'ordre de la milliseconde. Enregistrez les images dans le système de fichiers local et stockez uniquement le chemin texte (`image_path`).
* **Pas de stock négatif :** Le stock physique ne peut pas descendre sous zéro. Les requêtes transactionnelles doivent s'appuyer sur des contraintes `CHECK (quantity >= 0)` au niveau de la base de données.

<br>

## 📑 Dictionnaire de données

### 1. `Suppliers` (répertoire)
Enregistre les fabricants, fournisseurs de textile et ateliers de sérigraphie pour les futurs réapprovisionnements.

| Champ | Type | Règles et description |
| :--- | :--- | :--- |
| `id` | INTEGER | Clé primaire. Auto-incrémentée. |
| `name` | TEXT | **NOT NULL.** Nom du fournisseur/de l'atelier. |
| `contact_info` | TEXT | Téléphone, e-mail ou adresse physique. |
| `service_type` | TEXT | Par ex., couture, sérigraphie, fournisseur de tissu. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 2. `Products_Variants` (catalogue central)
Définit l'identité immuable de chaque vêtement. **Ne stocke pas les quantités de stock.**

| Champ | Type | Règles et description |
| :--- | :--- | :--- |
| `id` | INTEGER | Clé primaire. Auto-incrémentée. |
| `sku` | TEXT | **UNIQUE. NOT NULL.** Par ex., `PANT-BAGGY-38-BLU`. |
| `parent_name` | TEXT | **NOT NULL.** Nom du modèle de base (par ex., pantalon parachute). |
| `category` | TEXT | **NOT NULL.** Pour le filtrage (pantalons, t-shirts, sweats à capuche). |
| `fit` | TEXT | Coupe du vêtement (Baggy, Oversized, Slim, Regular). |
| `size` | TEXT | **NOT NULL.** Taille physique (S, M, L, XL, 38, 40). |
| `color` | TEXT | **NOT NULL.** Couleur dominante ou variante d'imprimé. |
| `fabric` | TEXT | Composition textile (par ex., Denim 12oz). |
| `supplier_id` | INTEGER | **Clé étrangère** liée à `Suppliers(id)`. |
| `status` | TEXT | `AVAILABLE`, `IN_PRODUCTION`, `RESERVED`, `ARCHIVED`. |
| `cost_price` | DECIMAL | Coût unitaire de fabrication (crucial pour les modules financiers). |
| `sale_price` | DECIMAL | Prix de vente final. |
| `barcode` | TEXT | **UNIQUE.** Code EAN/UPC pour scanners laser. |
| `image_path` | TEXT | Chemin local absolu/relatif vers le fichier `.jpg/.png`. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 3. `Inventories` (emplacements)
Gère les espaces physiques ou logiques dans lesquels SOKO stocke les marchandises.

| Champ | Type | Règles et description |
| :--- | :--- | :--- |
| `id` | INTEGER | Clé primaire. Auto-incrémentée. |
| `name` | TEXT | **NOT NULL.** Par ex., entrepôt central, foire de Palermo. |
| `type` | TEXT | Nature de l'espace : `Fijo` (Fixed), `Temporal`, `Transito`. |
| `is_active` | BOOLEAN | `1` = Actif, `0` = Archivé/Fermé. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 4. `Inventory_Stock` (le pont transactionnel)
La table centrale qui permet la logique multi-inventaire. Elle relie une variante de produit spécifique à un emplacement spécifique et suit sa quantité en temps réel.

| Champ | Type | Règles et description |
| :--- | :--- | :--- |
| `inventory_id` | INTEGER | **Clé étrangère** liée à `Inventories(id)`. |
| `variant_id` | INTEGER | **Clé étrangère** liée à `Products_Variants(id)`. |
| `quantity` | INTEGER | **NOT NULL.** `DEFAULT 0`. Contrainte : `CHECK (quantity >= 0)`. |
| `last_updated` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. Crucial pour les rapports de Dead Stock. |

> **Remarque :** La clé primaire d'`Inventory_Stock` est composée de `(inventory_id, variant_id)` afin d'empêcher les enregistrements de variantes dupliqués au même emplacement.

### 5. `App_Settings` (préférences système)
Table isolée pour les préférences locales de l'application, les séparant strictement des données opérationnelles d'inventaire.

| Champ | Type | Règles et description |
| :--- | :--- | :--- |
| `id` | INTEGER | Clé primaire. |
| `theme` | TEXT | Par ex., `dark`, `light`, `system`. |
| `last_backup` | TIMESTAMP | Enregistre la date et l'heure exactes de la dernière exportation `.zip`. |
