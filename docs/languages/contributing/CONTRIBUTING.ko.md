<div align="center">
    <h1>🛠️ SOKO에 기여하기</h1>
    <b>의류 브랜드를 위한 최고의 재고 관리자를 만드는 데 함께해 주세요.</b>
</div>

<div align="center">
    <sub>
        <a href="../../../CONTRIBUTING.md">English</a> · <a href="CONTRIBUTING.es.md">Español</a> · <a href="CONTRIBUTING.ru.md">Русский</a> · <a href="CONTRIBUTING.ja.md">日本語</a> · <a href="CONTRIBUTING.ko.md">한국어</a> · <a href="CONTRIBUTING.pt.md">Português</a> · <a href="CONTRIBUTING.fr.md">Français</a> · <a href="CONTRIBUTING.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![PRs Welcome - Static](https://img.shields.io/badge/PRs-Welcome?style=for-the-badge&logo=GitHub&label=PRs&labelColor=101418&color=99CCFF)](#)
[![Code Style - Static](https://img.shields.io/badge/Code-Clean?style=for-the-badge&logo=Codeigniter&label=Style&labelColor=101418&color=BBBBDD)](#)

</div>

> 먼저, **SOKO**에 기여하는 것을 고려해 주셔서 감사합니다! 오픈 소스 커뮤니티를 배우고 만들어 가기에 이토록 훌륭한 곳으로 만드는 것은 바로 여러분과 같은 개발자, 디자이너, 브랜드 소유자입니다.

<br>

## 🚀 어떻게 기여할 수 있나요?

* **버그 신고:** 다중 재고 로직이나 UI에서 문제를 발견하셨나요? issue를 열고 가능한 한 많은 맥락(로그, 스크린샷, OS 버전)을 제공해 주세요.
* **기능 제안:** 라벨 생성기나 Kyro 생태계에 대한 아이디어가 있나요? 토론을 열거나 `enhancement` 라벨이 있는 issue를 등록해 주세요.
* **코드 제출:** `good first issue` 또는 `help wanted` 라벨이 있는 열린 issue를 선택하고, 리포지토리를 포크하여 코딩을 시작하세요.

## 🛠️ 개발 환경 설정

SOKO를 로컬에서 실행하려면 **Node.js, Electron 및 SQLite 3**로 구동되는 **Offline-First** 아키텍처를 반드시 준수해야 합니다:

1. 리포지토리를 포크하고 클론합니다.
2. `npm install`을 실행하여 모든 기본 종속성을 설치합니다.
3. `npm run rebuild sqlite3`을 실행합니다(네이티브 바이너리 컴파일에 매우 중요합니다).
4. `npm start`로 개발 환경을 시작합니다.

## 🌿 Pull Request 프로세스

* **브랜치 생성:** `main`에서 설명적인 이름의 브랜치를 만듭니다(예: `feature/dark-mode-tweaks` 또는 `fix/stock-transfer`).
* **핵심 이해:** 코드를 작성하기 전에 비즈니스 로직, UI 지침 및 데이터베이스 엄격성을 충분히 이해할 수 있도록 `AGENTS.md` 및 `AI_CONTEXT.md` 파일을 읽어 주세요.
* **깔끔하게 커밋:** 명확하고 간결한 커밋 메시지를 작성하세요.
* **PR 열기:** 수행한 변경 사항과 해결하는 문제를 설명하고, 관련 issue를 연결하세요. 유지 관리자가 검토할 때까지 기다려 주세요.

## 🎨 스타일 가이드 및 규약

* **UI/UX 미학:** 모든 시각적 추가 사항은 네이티브 *Dark Mode*와 스트리트웨어 지향의 *cyber/tech* 미학을 존중해야 합니다.
* **데이터베이스 무결성:** 데이터베이스에 무거운 이미지(BLOB)를 저장하는 것은 엄격히 금지됩니다. 로컬 파일 경로를 사용하세요. 항상 관계형 제한과 `PRAGMA foreign_keys = ON`을 준수하세요.
* **코드 품질:** 함수를 모듈식으로 유지하고, 구조적 결정에 주석을 달며, 깔끔한 들여쓰기를 유지하세요.
