<div align="center">
    <h1>🗄️ Схема базы данных SOKO</h1>
    <b>Реляционная архитектура, целостность данных и правила локального хранения.</b>
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

> В этом документе подробно описаны точная структура, ограничения и бизнес-логика локальной базы данных SOKO. Мы используем строго реляционную модель, чтобы обеспечить согласованность данных между несколькими инвентарями без зависимости от облачной синхронизации.

<br>

## ⚙️ Основные технические правила

Перед взаимодействием со схемой или её изменением разработчики должны соблюдать следующие принципы:

* **Строгие внешние ключи:** Мы явно применяем `PRAGMA foreign_keys = ON;` при каждом подключении. Записи-сироты не допускаются.
* **BLOB запрещены:** Прямое хранение медиафайлов в базе данных строго запрещено для сохранения скорости запросов на уровне миллисекунд. Сохраняйте изображения в локальной файловой системе и храните только текстовый путь (`image_path`).
* **Без отрицательных остатков:** Физический запас не может опускаться ниже нуля. Транзакционные запросы должны опираться на ограничения `CHECK (quantity >= 0)` на уровне базы данных.

<br>

## 📑 Словарь данных

### 1. `Suppliers` (справочник)
Содержит производителей, поставщиков текстиля и мастерские шелкографии для будущих пополнений запасов.

| Поле | Тип | Правила и описание |
| :--- | :--- | :--- |
| `id` | INTEGER | Первичный ключ. Автоинкремент. |
| `name` | TEXT | **NOT NULL.** Название поставщика/мастерской. |
| `contact_info` | TEXT | Телефон, электронная почта или физический адрес. |
| `service_type` | TEXT | Например: пошив, шелкография, поставщик тканей. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 2. `Products_Variants` (центральный каталог)
Определяет неизменяемую идентичность каждого предмета одежды. **Не хранит количество запаса.**

| Поле | Тип | Правила и описание |
| :--- | :--- | :--- |
| `id` | INTEGER | Первичный ключ. Автоинкремент. |
| `sku` | TEXT | **UNIQUE. NOT NULL.** Например: `PANT-BAGGY-38-BLU`. |
| `parent_name` | TEXT | **NOT NULL.** Название базовой модели (например, парашютные брюки). |
| `category` | TEXT | **NOT NULL.** Для фильтрации (брюки, футболки, худи). |
| `fit` | TEXT | Крой одежды (Baggy, Oversized, Slim, Regular). |
| `size` | TEXT | **NOT NULL.** Физический размер (S, M, L, XL, 38, 40). |
| `color` | TEXT | **NOT NULL.** Основной цвет или вариант принта. |
| `fabric` | TEXT | Состав ткани (например, Denim 12oz). |
| `supplier_id` | INTEGER | **Внешний ключ**, связанный с `Suppliers(id)`. |
| `status` | TEXT | `AVAILABLE`, `IN_PRODUCTION`, `RESERVED`, `ARCHIVED`. |
| `cost_price` | DECIMAL | Себестоимость единицы производства (важно для финансовых модулей). |
| `sale_price` | DECIMAL | Окончательная розничная цена. |
| `barcode` | TEXT | **UNIQUE.** Код EAN/UPC для лазерных сканеров. |
| `image_path` | TEXT | Локальный абсолютный/относительный путь к файлу `.jpg/.png`. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 3. `Inventories` (локации)
Управляет физическими или логическими пространствами, где SOKO хранит товар.

| Поле | Тип | Правила и описание |
| :--- | :--- | :--- |
| `id` | INTEGER | Первичный ключ. Автоинкремент. |
| `name` | TEXT | **NOT NULL.** Например: центральный склад, ярмарка в Палермо. |
| `type` | TEXT | Характер пространства: `Fijo` (Fixed), `Temporal`, `Transito`. |
| `is_active` | BOOLEAN | `1` = Активен, `0` = Архивирован/Закрыт. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 4. `Inventory_Stock` (транзакционный мост)
Основная таблица, обеспечивающая логику мультиинвентаря. Она связывает конкретный вариант продукта с конкретной локацией и отслеживает его количество в реальном времени.

| Поле | Тип | Правила и описание |
| :--- | :--- | :--- |
| `inventory_id` | INTEGER | **Внешний ключ**, связанный с `Inventories(id)`. |
| `variant_id` | INTEGER | **Внешний ключ**, связанный с `Products_Variants(id)`. |
| `quantity` | INTEGER | **NOT NULL.** `DEFAULT 0`. Ограничение: `CHECK (quantity >= 0)`. |
| `last_updated` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. Важно для отчётов Dead Stock. |

> **Примечание:** Первичный ключ `Inventory_Stock` является составным из `(inventory_id, variant_id)`, чтобы предотвращать дублирование записей вариантов в одной локации.

### 5. `App_Settings` (системные настройки)
Изолированная таблица для локальных настроек приложения, строго отделяющая их от операционных данных инвентаря.

| Поле | Тип | Правила и описание |
| :--- | :--- | :--- |
| `id` | INTEGER | Первичный ключ. |
| `theme` | TEXT | Например: `dark`, `light`, `system`. |
| `last_backup` | TIMESTAMP | Записывает точные дату и время последнего экспорта `.zip`. |
