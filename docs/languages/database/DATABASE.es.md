<div align="center">
    <h1>🗄️ Esquema de base de datos de SOKO</h1>
    <b>Arquitectura relacional, integridad de los datos y reglas de almacenamiento local.</b>
</div>

<div align="center">
    <sub>
        <a href="../../DATABASE.md">English</a> · <a href="DATABASE.es.md">Español</a> · <a href="DATABASE.ru.md">Русский</a> · <a href="DATABASE.ja.md">日本語</a> · <a href="DATABASE.ko.md">한국어</a> · <a href="DATABASE.pt.md">Português</a> · <a href="DATABASE.fr.md">Français</a> · <a href="DATABASE.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![SQLite - Static](https://img.shields.io/badge/SQLite_3-Database?style=for-the-badge&logo=SQLite&logoColor=FFFFFF&label=Engine&labelColor=101418&color=99CCFF)](#)
[![Integrity - Static](https://img.shields.io/badge/Strict-Integrity?style=for-the-badge&logo=Databricks&label=Relations&labelColor=101418&color=BBBBDD)](#)

</div>

> Este documento detalla la estructura exacta, las restricciones y la lógica de negocio de la base de datos local de SOKO. Utilizamos un modelo estrictamente relacional para garantizar la consistencia de los datos en múltiples inventarios sin depender de la sincronización en la nube.

<br>

## ⚙️ Reglas técnicas principales

Antes de interactuar con el esquema o modificarlo, los desarrolladores deben seguir los siguientes principios:

* **Claves foráneas estrictas:** Aplicamos explícitamente `PRAGMA foreign_keys = ON;` en cada conexión. No se permiten registros huérfanos.
* **No se permiten BLOBs:** Está estrictamente prohibido almacenar archivos multimedia directamente en la base de datos para mantener velocidades de consulta de milisegundos. Guarda las imágenes en el sistema de archivos local y almacena solo la ruta de texto (`image_path`).
* **Sin stock negativo:** El stock físico no puede bajar de cero. Las consultas transaccionales deben basarse en restricciones `CHECK (quantity >= 0)` a nivel de base de datos.

<br>

## 📑 Diccionario de datos

### 1. `Suppliers` (directorio)
Registra los fabricantes, proveedores textiles y talleres de serigrafía para futuras reposiciones.

| Campo | Tipo | Reglas y descripción |
| :--- | :--- | :--- |
| `id` | INTEGER | Clave primaria. Autoincremental. |
| `name` | TEXT | **NOT NULL.** Nombre del proveedor/taller. |
| `contact_info` | TEXT | Teléfono, correo electrónico o dirección física. |
| `service_type` | TEXT | P. ej., costura, serigrafía, proveedor de telas. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 2. `Products_Variants` (catálogo central)
Define la identidad inmutable de cada prenda. **No almacena cantidades de stock.**

| Campo | Tipo | Reglas y descripción |
| :--- | :--- | :--- |
| `id` | INTEGER | Clave primaria. Autoincremental. |
| `sku` | TEXT | **UNIQUE. NOT NULL.** P. ej., `PANT-BAGGY-38-BLU`. |
| `parent_name` | TEXT | **NOT NULL.** Nombre del modelo base (p. ej., pantalones paracaidistas). |
| `category` | TEXT | **NOT NULL.** Para filtrar (pantalones, camisetas, sudaderas). |
| `fit` | TEXT | Corte de la prenda (Baggy, Oversized, Slim, Regular). |
| `size` | TEXT | **NOT NULL.** Talla física (S, M, L, XL, 38, 40). |
| `color` | TEXT | **NOT NULL.** Color dominante o variante de estampado. |
| `fabric` | TEXT | Composición textil (p. ej., Denim 12oz). |
| `supplier_id` | INTEGER | **Clave foránea** que enlaza con `Suppliers(id)`. |
| `status` | TEXT | `AVAILABLE`, `IN_PRODUCTION`, `RESERVED`, `ARCHIVED`. |
| `cost_price` | DECIMAL | Coste unitario de fabricación (crucial para los módulos financieros). |
| `sale_price` | DECIMAL | Precio final de venta al público. |
| `barcode` | TEXT | **UNIQUE.** Código EAN/UPC para escáneres láser. |
| `image_path` | TEXT | Ruta local absoluta/relativa al archivo `.jpg/.png`. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 3. `Inventories` (ubicaciones)
Gestiona los espacios físicos o lógicos donde SOKO almacena mercancía.

| Campo | Tipo | Reglas y descripción |
| :--- | :--- | :--- |
| `id` | INTEGER | Clave primaria. Autoincremental. |
| `name` | TEXT | **NOT NULL.** P. ej., almacén central, feria de Palermo. |
| `type` | TEXT | Naturaleza del espacio: `Fijo` (Fixed), `Temporal`, `Transito`. |
| `is_active` | BOOLEAN | `1` = Activo, `0` = Archivado/Cerrado. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 4. `Inventory_Stock` (el puente transaccional)
La tabla principal que habilita la lógica de multiinventario. Vincula una variante de producto específica con una ubicación específica y realiza el seguimiento de su cantidad en tiempo real.

| Campo | Tipo | Reglas y descripción |
| :--- | :--- | :--- |
| `inventory_id` | INTEGER | **Clave foránea** que enlaza con `Inventories(id)`. |
| `variant_id` | INTEGER | **Clave foránea** que enlaza con `Products_Variants(id)`. |
| `quantity` | INTEGER | **NOT NULL.** `DEFAULT 0`. Restricción: `CHECK (quantity >= 0)`. |
| `last_updated` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. Crucial para los informes de Dead Stock. |

> **Nota:** La clave primaria de `Inventory_Stock` es una composición de `(inventory_id, variant_id)` para evitar registros de variantes duplicados dentro de la misma ubicación.

### 5. `App_Settings` (preferencias del sistema)
Tabla aislada para las preferencias locales de la aplicación, que las mantiene estrictamente separadas de los datos operativos del inventario.

| Campo | Tipo | Reglas y descripción |
| :--- | :--- | :--- |
| `id` | INTEGER | Clave primaria. |
| `theme` | TEXT | P. ej., `dark`, `light`, `system`. |
| `last_backup` | TIMESTAMP | Registra la fecha y hora exactas de la última exportación `.zip`. |
