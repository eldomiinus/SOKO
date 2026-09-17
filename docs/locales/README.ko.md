<div align="center">
	<h1>📦 SOKO</h1>
	<b>의류 브랜드를 위한 지능형 멀티 재고 관리</b>
</div>

<div align="center">
	<sub>
		<a href="../../README.md">English</a> · <a href="README.es.md">Español</a> · <a href="README.ru.md">Русский</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.pt.md">Português</a> · <a href="README.fr.md">Français</a> · <a href="README.it.md">Italiano</a>
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

> **"전통적인 재고 관리의 혼란은 여기서 끝납니다."** SOKO는 *얼터너티브* 스타일의 신생 브랜드, 쇼룸 및 한정 출시나 *drops*를 운영하는 섬유 사업자를 위해 설계된 종합 데스크톱 소프트웨어입니다. 고급 변형 시스템을 통해 각 의류의 전체 수명 주기를 관리하고, 단 한 개도 놓치지 않으면서 창고, 매장 및 임시 이벤트를 실시간으로 관리할 수 있습니다.

## 📑 목차
- [🚀 주요 기능](#-주요-기능)
- [🏗️ 아키텍처 및 기술](#️-아키텍처-및-기술)
- [🔗 Kyro 모듈형 생태계](#-kyro-모듈형-생태계)
- [🗺️ 개발 및 진행 상황](#️-개발-및-진행-상황)
- [⚙️ 설치](#️-설치)
- [📈 통계](#-통계)

<br>

## 🚀 주요 기능

- **🌐 동적 멀티 재고:** 독립적인 재고 공간(고정 매장, 중앙 창고, 주말 플리마켓)을 생성합니다. 관계형 트랜잭션을 통해 위치 간 의류를 안전하게 이동하고, 임시 이벤트를 보관 처리하면 남은 재고를 중앙 재고로 자동 반환합니다.
- **🧬 변형 시스템(다중 레벨):** "상위 제품"을 구성하고 각 *사이즈*와 *색상* 조합별로 재고를 개별적이고 정확하게 관리합니다.
- **🏷️ 라벨 생성기:** 변형별 SKU를 자동으로 할당하고, 각각의 바코드와 가격이 포함된 실제 라벨 인쇄용 PDF 템플릿을 내보냅니다.
- **⚡ 카탈로그 일괄 작업:** 여러 변형을 동시에 선택하여 가격을 백분율로 인상하거나 운영 상태(예: *생산 중*에서 *판매 가능*으로)를 한 번의 클릭으로 변경합니다.
- **📒 통합 공급업체 디렉터리:** 기술 명세와 연결된 내부 주소록에 각 생산 배치에 해당하는 봉제 및 실크스크린 작업장의 정확한 연락처를 저장하여, 성공적인 생산을 신속하게 반복하는 데 필요한 정보를 관리합니다.
- **📉 "정체 재고"(Dead Stock) 보고서:** 60일 이상 재고에서 움직이지 않은 의류를 감지하는 지능형 분석 패널로, 재고 정리나 특별 프로모션을 계획하는 데 필수적인 지표를 제공합니다.

<br>

## 🏗️ 아키텍처 및 기술

> [!NOTE]
> SOKO는 **Offline-First** 아키텍처를 기반으로 설계되어, 네이티브 성능, 완전한 이식성(인터넷 연결 없이도 플리마켓에서 원활하게 운영) 및 로컬 데이터의 절대적인 개인정보 보호를 우선시합니다.

### 💻 기술 스택

<div align=center>

| 계층 | 기술 | 설명 |
| :--- | :--- | :--- |
| **🎨 프론트엔드 (UI/UX)** | HTML5, CSS3, Vanilla JS | CSS Grid로 구성된 인터페이스입니다. 네이티브 *Dark Mode*(*cyber/tech* 스타일), 프레임 없는 창(frameless) 및 동적 접이식 패널을 제공합니다. |
| **⚙️ 백엔드** | Node.js + Electron | 네이티브 데스크톱 애플리케이션으로 패키징하여 높은 성능, 안전한 창 관리 및 로컬 파일 시스템에 대한 깊은 접근을 보장합니다. |
| **💾 데이터베이스** | SQLite3 | `userData`에 저장되는 로컬 관계형 엔진(단일 파일)입니다. 안전한 ACID 트랜잭션을 지원하고 이식성을 보장합니다. |

</div>

### 📂 데이터 흐름 및 저장
1. **관계형 정규화:** 트랜잭션 브리지 테이블(*Inventory_Stock*)을 사용하여 의류의 정체성(일반 카탈로그)과 물리적 위치(재고)를 엄격하게 분리하고 데이터 중복을 완전히 제거합니다.
2. **최적화된 멀티미디어 관리:** 데이터베이스에 무거운 이미지(BLOB)를 저장하는 것은 엄격히 금지됩니다. 사진은 로컬 디렉터리에 투명하게 복사되고 SQLite에는 상대 경로만 기록됩니다. 이를 통해 데이터베이스를 매우 가볍게 유지하여 밀리초 단위의 응답 시간을 보장합니다.

<br>

## 🔗 Kyro 모듈형 생태계

SOKO는 확장 가능하고 맞춤화된 작업 환경의 핵심으로 자리 잡도록 모듈형 아키텍처로 설계되어, 사업자의 운영 및 재정적 성장에 맞춰 확장됩니다.

- **📦 SOKO (Core):** 카탈로그의 종합 관리, 다중 공간 물류 및 변형의 철저한 관리를 담당하는 핵심 엔진입니다.
- **🛒 SOKO POS (계산대 확장 - 출시 예정):** 계산대에서만 사용하도록 설계된 선택적이고 독립적인 초경량 모듈입니다. 레이저 바코드 스캐너 지원과 빠른 합계 계산을 통합합니다. 메인 관리 애플리케이션을 열 필요 없이 동일한 로컬 SQLite 데이터베이스에 연결하여 실시간으로 재고를 차감하는 "경량 클라이언트"로 작동합니다.
- **📊 KURA (재무 - 출시 예정):** SOKO/POS에 기록된 판매 수익을 자동으로 수신하도록 동기화되는 고급 금융 플랫폼으로, 하나의 자동화된 흐름 안에서 운영 및 경제적 관리를 통합합니다.

<br>

## 🗺️ 개발 및 진행 상황

### 📌 계획 및 구조 단계
- [x] 아키텍처 및 관계형 데이터베이스 정의([`SQLite`](https://www.sqlite.org/index.html)).
- [x] 요구사항, 사용자 흐름 및 멀티 재고 사양 정의.
- [x] UI/UX 디자인 가이드 및 색상 팔레트(*Dark Mode* / *Cyber tech*).
- [x] Kyro 모듈형 생태계의 아키텍처 설계(SOKO, POS 및 KURA).

### 🎨 프론트엔드 개발 단계
- [x] 기본 UI 아키텍처 설계(CSS Grid, 4개의 기능 영역).
- [x] 네이티브 동작 구현(프레임 없는 창 및 드래그 가능한 Top Bar).
- [x] 접이식 Sidebar 및 동적 세부 정보 패널 개발(대화형 Mockup).
- [ ] 프론트엔드와 SQLite 템플릿/데이터 엔진 연결.

### 💼 백엔드 및 로직 개발 단계
- [x] Node.js 환경 및 Electron 종속성 구성.
- [x] 네이티브 바이너리 컴파일 및 Git에서 `node_modules` 제외.
- [x] 사용자 디렉터리에서 로컬 데이터베이스(`soko.db`) 자동 초기화.
- [ ] "상위 제품" 및 해당 변형의 CRUD 모듈 생성.
- [ ] 재고 이동을 위한 안전한 트랜잭션 엔진 개발.
- [ ] 보조 모듈 구현: 라벨 생성, 일괄 작업 및 Dead Stock 감지.

<br>

## ⚙️ 설치

로컬 컴퓨터에서 SOKO 환경을 시작하고 개발에 기여하려면 다음 단계를 따르세요.

```bash
# 1. 공식 저장소 복제
git clone https://github.com/eldomiinus/soko.git

# 2. 프로젝트 루트 디렉터리로 이동
cd soko

# 3. 프로젝트 종속성 설치
npm install

# 4. 네이티브 모듈(SQLite3)의 올바른 컴파일 보장
npm rebuild sqlite3

# 5. 개발 모드로 애플리케이션 실행
npm start
```

<br>

## 📈 통계

<div align=center>
<a href="https://www.star-history.com/?repos=eldomiinus%2Fsoko&type=date&legend=bottom-right">
	<picture>
		<source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&theme=dark&legend=top-left" />
		<source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
		<img alt="Star History 차트" src="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
	</picture>
</a>
</div>

<br>

<div align="center">

<h2>¡관심을 가져 주셔서 감사합니다! <3</h2>

[![GitHub License - Static](https://img.shields.io/badge/MIT-License?style=for-the-badge&logo=GitBook&label=License&labelColor=101418&color=BBBBDD)](https://github.com/eldomiinus/SOKO?tab=License-1-ov-file)

</div>
