<div align="center">
    <h1>⚙️ SOKO 아키텍처</h1>
    <b>Offline-First 생태계의 기술적 기반.</b>
</div>

<div align="center">
    <sub>
        <a href="../ARCHITECTURE.md">English</a> · <a href="ARCHITECTURE.es.md">Español</a> · <a href="ARCHITECTURE.ru.md">Русский</a> · <a href="ARCHITECTURE.ja.md">日本語</a> · <a href="ARCHITECTURE.ko.md">한국어</a> · <a href="ARCHITECTURE.pt.md">Português</a> · <a href="ARCHITECTURE.fr.md">Français</a> · <a href="ARCHITECTURE.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![Offline First - Static](https://img.shields.io/badge/Architecture-Offline_First?style=for-the-badge&logo=Databricks&label=Architecture&labelColor=101418&color=99CCFF)](#)
[![IPC Bridge - Static](https://img.shields.io/badge/Electron-IPC_Bridge?style=for-the-badge&logo=Electron&label=Communication&labelColor=101418&color=BBBBDD)](#)

</div>

> **SOKO**는 네이티브 성능, 절대적인 데이터 개인정보 보호 및 인터넷 연결에 의존하지 않는 임시 박람회 중의 완전한 운영을 보장하도록 설계된 네이티브 데스크톱 애플리케이션입니다. 이 문서는 이 환경에서 Frontend, Backend 및 데이터베이스가 상호 작용하는 방식을 설명합니다.

<br>

## 🖥️ 1. Electron IPC 통신 모델

SOKO는 **Electron**으로 패키징되므로 보안과 성능을 위해 사용자 인터페이스와 시스템 리소스 간의 책임을 엄격하게 분리합니다:

* **Frontend(Renderer 프로세스):** HTML5, CSS3(Grid), Vanilla JS로 구축됩니다. UI/UX, 애니메이션 및 사용자 입력을 처리합니다. **데이터베이스에 직접 접근하지 않습니다.**
* **IPC 브리지(Context Bridge):** Electron의 `preload.js`를 사용하여 frontend에 안전한 API를 노출합니다.
* **Backend(Main 프로세스):** Node.js에서 실행됩니다. Frontend가 보낸 IPC 채널을 수신하고, 무거운 논리 작업을 수행하며, 로컬 파일 시스템을 읽고/쓰고 SQLite 데이터베이스를 쿼리합니다.

## 💾 2. 데이터베이스 엔진 및 파일 시스템

데이터 저장의 핵심은 **SQLite 3**를 사용하는 관계형 모델에 기반합니다. 애플리케이션을 매우 빠르게 유지하기 위해 엄격한 기술 규칙을 적용합니다:

### "BLOB 없음" 규칙
데이터베이스 안에 이미지를 저장하기 위한 BLOB 필드 사용은 엄격히 금지됩니다. 무거운 미디어를 SQLite에 직접 저장하면 데이터베이스가 심각하게 비대해지고 성능이 저하됩니다.
* **처리 방식:** Backend는 물리적 이미지 파일을 로컬 디렉터리 트리(예: `/assets/images/catalog/`)에 저장합니다.
* 데이터베이스는 해당 파일을 가리키는 로컬 경로의 텍스트 문자열(`image_path: TEXT`)만 저장합니다.

### 데이터 무결성 및 설정
* **엄격한 관계:** 공급업체, 제품 및 재고 간의 데이터 무결성을 보장하기 위해 모든 연결에서 `PRAGMA foreign_keys = ON;`을 명시적으로 적용합니다.
* **애플리케이션 설정:** 다크 모드 상태나 마지막 백업 날짜 같은 시스템 기본 설정은 거래 재고 데이터를 어지럽히지 않도록 별도의 `App_Settings` 테이블에 격리됩니다.

## 📦 3. 다중 재고 로직(브리지)

SOKO의 핵심 기능은 여러 물리적 위치(예: 중앙 창고, 팝업 스토어, 박람회)를 동시에 관리하는 능력입니다. 

위치는 그 특성(`type`)에 따라 *Fijo*(Fixed), *Temporal*(Temporary) 또는 *Transito*(In-Transit)로 분류됩니다.

### 트랜잭션 브리지

`Inventory_Stock`이라는 브리지 테이블을 사용하여 중복 제품 항목을 피합니다. 
* 주말 박람회로 재고를 옮기면 시스템은 "중앙 창고"에서 단위를 차감하고 안전한 SQL 트랜잭션을 통해 "박람회" 재고에 할당합니다. 
* 박람회가 끝나면 남은 재고는 다시 이전됩니다.
* **안전 최우선:** 물리적 재고가 **절대** 음수가 되지 않도록 데이터베이스 수준에서 `CHECK` 제약 조건을 사용합니다.

## 🔗 4. 모듈식 생태계

SOKO는 확장 가능한 환경의 핵심 엔진 역할을 합니다. 데이터베이스 아키텍처는 향후 확장에서 사용할 수 있도록 준비되어 있습니다:

1. **SOKO POS:** 계산원이 바코드를 스캔하고 실시간으로 재고를 원활하게 차감할 수 있는 미래의 결제 확장 기능.
2. **KURA 통합:** SOKO에서 "Sold"로 표시된 모든 품목이 KURA 금융 시스템의 금전적 수익 항목을 자동으로 생성하여 운영 및 경제적 관리를 통합하는 미래의 모듈.
