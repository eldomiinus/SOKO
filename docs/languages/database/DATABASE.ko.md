<div align="center">
    <h1>🗄️ SOKO 데이터베이스 스키마</h1>
    <b>관계형 아키텍처, 데이터 무결성 및 로컬 저장소 규칙.</b>
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

> 이 문서는 SOKO 로컬 데이터베이스의 정확한 구조, 제약 조건 및 비즈니스 로직을 상세히 설명합니다. 클라우드 동기화에 의존하지 않고 여러 재고 간 데이터 일관성을 보장하기 위해 엄격한 관계형 모델을 사용합니다.

<br>

## ⚙️ 핵심 기술 규칙

스키마를 다루거나 수정하기 전에 개발자는 다음 원칙을 준수해야 합니다:

* **엄격한 외래 키:** 모든 연결에 `PRAGMA foreign_keys = ON;`을 명시적으로 적용합니다. 고아 레코드는 허용되지 않습니다.
* **BLOB 허용 안 됨:** 밀리초 단위의 쿼리 속도를 유지하기 위해 미디어 파일을 데이터베이스에 직접 저장하는 것은 엄격히 금지됩니다. 이미지는 로컬 파일 시스템에 저장하고 텍스트 경로(`image_path`)만 저장하세요.
* **음수 재고 금지:** 물리적 재고는 0 아래로 내려갈 수 없습니다. 트랜잭션 쿼리는 데이터베이스 수준의 `CHECK (quantity >= 0)` 제약 조건에 의존해야 합니다.

<br>

## 📑 데이터 사전

### 1. `Suppliers`(디렉터리)
향후 재입고를 위해 제조업체, 섬유 공급업체 및 실크스크린 작업장을 기록합니다.

| 필드 | 유형 | 규칙 및 설명 |
| :--- | :--- | :--- |
| `id` | INTEGER | 기본 키. 자동 증가. |
| `name` | TEXT | **NOT NULL.** 공급업체/작업장 이름. |
| `contact_info` | TEXT | 전화, 이메일 또는 실제 주소. |
| `service_type` | TEXT | 예: 봉제, 실크스크린, 원단 공급업체. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 2. `Products_Variants`(중앙 카탈로그)
각 의류의 변경 불가능한 정체성을 정의합니다. **재고 수량은 저장하지 않습니다.**

| 필드 | 유형 | 규칙 및 설명 |
| :--- | :--- | :--- |
| `id` | INTEGER | 기본 키. 자동 증가. |
| `sku` | TEXT | **UNIQUE. NOT NULL.** 예: `PANT-BAGGY-38-BLU`. |
| `parent_name` | TEXT | **NOT NULL.** 기본 모델 이름(예: 파라슈트 팬츠). |
| `category` | TEXT | **NOT NULL.** 필터링용(바지, 티셔츠, 후드티). |
| `fit` | TEXT | 의류 핏(Baggy, Oversized, Slim, Regular). |
| `size` | TEXT | **NOT NULL.** 실제 사이즈(S, M, L, XL, 38, 40). |
| `color` | TEXT | **NOT NULL.** 주요 색상 또는 프린트 변형. |
| `fabric` | TEXT | 섬유 구성(예: Denim 12oz). |
| `supplier_id` | INTEGER | `Suppliers(id)`에 연결되는 **외래 키**. |
| `status` | TEXT | `AVAILABLE`, `IN_PRODUCTION`, `RESERVED`, `ARCHIVED`. |
| `cost_price` | DECIMAL | 제조 단가(재무 모듈에 중요). |
| `sale_price` | DECIMAL | 최종 소매 가격. |
| `barcode` | TEXT | **UNIQUE.** 레이저 스캐너용 EAN/UPC 코드. |
| `image_path` | TEXT | `.jpg/.png` 파일의 로컬 절대/상대 경로. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 3. `Inventories`(위치)
SOKO가 상품을 보관하는 물리적 또는 논리적 공간을 관리합니다.

| 필드 | 유형 | 규칙 및 설명 |
| :--- | :--- | :--- |
| `id` | INTEGER | 기본 키. 자동 증가. |
| `name` | TEXT | **NOT NULL.** 예: 중앙 창고, 팔레르모 박람회. |
| `type` | TEXT | 공간의 성격: `Fijo` (Fixed), `Temporal`, `Transito`. |
| `is_active` | BOOLEAN | `1` = 활성, `0` = 보관됨/닫힘. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 4. `Inventory_Stock`(트랜잭션 브리지)
다중 재고 로직을 가능하게 하는 핵심 테이블입니다. 특정 제품 변형을 특정 위치에 연결하고 그 수량을 실시간으로 추적합니다.

| 필드 | 유형 | 규칙 및 설명 |
| :--- | :--- | :--- |
| `inventory_id` | INTEGER | `Inventories(id)`에 연결되는 **외래 키**. |
| `variant_id` | INTEGER | `Products_Variants(id)`에 연결되는 **외래 키**. |
| `quantity` | INTEGER | **NOT NULL.** `DEFAULT 0`. 제약 조건: `CHECK (quantity >= 0)`. |
| `last_updated` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. Dead Stock 보고서에 중요. |

> **참고:** `Inventory_Stock`의 기본 키는 동일한 위치 안의 중복 변형 레코드를 방지하기 위해 `(inventory_id, variant_id)`로 구성됩니다.

### 5. `App_Settings`(시스템 환경설정)
로컬 애플리케이션 환경설정을 위한 격리된 테이블로, 운영 재고 데이터와 엄격히 분리합니다.

| 필드 | 유형 | 규칙 및 설명 |
| :--- | :--- | :--- |
| `id` | INTEGER | 기본 키. |
| `theme` | TEXT | 예: `dark`, `light`, `system`. |
| `last_backup` | TIMESTAMP | 마지막 `.zip` 내보내기의 정확한 날짜와 시간을 기록합니다. |
