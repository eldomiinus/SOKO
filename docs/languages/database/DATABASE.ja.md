<div align="center">
    <h1>🗄️ SOKO データベーススキーマ</h1>
    <b>リレーショナルアーキテクチャ、データ整合性、ローカルストレージのルール。</b>
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

> この文書では、SOKO ローカルデータベースの正確な構造、制約、ビジネスロジックを詳述します。クラウド同期に依存することなく、複数のインベントリ間でデータの整合性を確保するため、厳格なリレーショナルモデルを採用しています。

<br>

## ⚙️ コア技術ルール

スキーマを操作または変更する前に、開発者は以下の原則を守る必要があります:

* **厳格な外部キー:** すべての接続で `PRAGMA foreign_keys = ON;` を明示的に適用します。孤立レコードは許可されません。
* **BLOB は許可されません:** ミリ秒単位のクエリ速度を維持するため、メディアファイルをデータベースへ直接保存することは厳しく禁止されています。画像はローカルファイルシステムに保存し、テキストパス（`image_path`）のみを保存してください。
* **負の在庫なし:** 物理在庫はゼロを下回ることはできません。トランザクションクエリは、データベースレベルの `CHECK (quantity >= 0)` 制約に依存する必要があります。

<br>

## 📑 データディクショナリ

### 1. `Suppliers`（ディレクトリ）
将来の補充に備え、製造業者、繊維供給業者、シルクスクリーン工房を記録します。

| フィールド | 型 | ルールと説明 |
| :--- | :--- | :--- |
| `id` | INTEGER | 主キー。自動増分。 |
| `name` | TEXT | **NOT NULL.** 供給業者／工房の名前。 |
| `contact_info` | TEXT | 電話、メール、または住所。 |
| `service_type` | TEXT | 例: 縫製、シルクスクリーン、布地供給業者。 |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 2. `Products_Variants`（中央カタログ）
各衣類の不変のアイデンティティを定義します。**在庫数量は保存しません。**

| フィールド | 型 | ルールと説明 |
| :--- | :--- | :--- |
| `id` | INTEGER | 主キー。自動増分。 |
| `sku` | TEXT | **UNIQUE. NOT NULL.** 例: `PANT-BAGGY-38-BLU`. |
| `parent_name` | TEXT | **NOT NULL.** ベースモデル名（例: パラシュートパンツ）。 |
| `category` | TEXT | **NOT NULL.** フィルタリング用（パンツ、Tシャツ、フーディー）。 |
| `fit` | TEXT | 衣類のカット（Baggy、Oversized、Slim、Regular）。 |
| `size` | TEXT | **NOT NULL.** 物理サイズ（S、M、L、XL、38、40）。 |
| `color` | TEXT | **NOT NULL.** 主な色またはプリントのバリエーション。 |
| `fabric` | TEXT | 繊維組成（例: Denim 12oz）。 |
| `supplier_id` | INTEGER | `Suppliers(id)` にリンクする**外部キー**。 |
| `status` | TEXT | `AVAILABLE`, `IN_PRODUCTION`, `RESERVED`, `ARCHIVED`. |
| `cost_price` | DECIMAL | 製造単価（財務モジュールに不可欠）。 |
| `sale_price` | DECIMAL | 最終小売価格。 |
| `barcode` | TEXT | **UNIQUE.** レーザースキャナー用の EAN/UPC コード。 |
| `image_path` | TEXT | `.jpg/.png` ファイルへのローカル絶対／相対パス。 |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 3. `Inventories`（ロケーション）
SOKO が商品を保管する物理的または論理的な空間を管理します。

| フィールド | 型 | ルールと説明 |
| :--- | :--- | :--- |
| `id` | INTEGER | 主キー。自動増分。 |
| `name` | TEXT | **NOT NULL.** 例: 中央倉庫、パレルモフェア。 |
| `type` | TEXT | 空間の性質: `Fijo` (Fixed)、`Temporal`、`Transito`。 |
| `is_active` | BOOLEAN | `1` = 有効、`0` = アーカイブ済み／閉鎖。 |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 4. `Inventory_Stock`（トランザクションブリッジ）
マルチインベントリロジックを可能にする中核テーブルです。特定の製品バリアントを特定の場所にリンクし、その数量をリアルタイムで追跡します。

| フィールド | 型 | ルールと説明 |
| :--- | :--- | :--- |
| `inventory_id` | INTEGER | `Inventories(id)` にリンクする**外部キー**。 |
| `variant_id` | INTEGER | `Products_Variants(id)` にリンクする**外部キー**。 |
| `quantity` | INTEGER | **NOT NULL.** `DEFAULT 0`. 制約: `CHECK (quantity >= 0)`. |
| `last_updated` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. Dead Stock レポートに不可欠。 |

> **注:** `Inventory_Stock` の主キーは、同じ場所内での重複バリアントレコードを防ぐため、`(inventory_id, variant_id)` の複合キーです。

### 5. `App_Settings`（システム設定）
ローカルアプリケーション設定のための独立テーブルで、運用上のインベントリデータから厳格に分離します。

| フィールド | 型 | ルールと説明 |
| :--- | :--- | :--- |
| `id` | INTEGER | 主キー。 |
| `theme` | TEXT | 例: `dark`, `light`, `system`. |
| `last_backup` | TIMESTAMP | 最後の `.zip` エクスポートの正確な日時を記録します。 |
