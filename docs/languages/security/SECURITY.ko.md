<div align="center">
    <h1>🛡️ SOKO 보안 정책</h1>
    <b>설계 단계부터의 개인정보 보호, offline-first 아키텍처 및 로컬 데이터 제어.</b>
</div>

<div align="center">
    <sub>
        <a href="../../../SECURITY.md">English</a> · <a href="SECURITY.es.md">Español</a> · <a href="SECURITY.ru.md">Русский</a> · <a href="SECURITY.ja.md">日本語</a> · <a href="SECURITY.ko.md">한국어</a> · <a href="SECURITY.pt.md">Português</a> · <a href="SECURITY.fr.md">Français</a> · <a href="SECURITY.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![Privacy First - Static](https://img.shields.io/badge/Privacy-First?style=for-the-badge&logo=Shield&label=Data&labelColor=101418&color=99CCFF)](#)
[![Encryption - Static](https://img.shields.io/badge/AES_256-SQLCipher?style=for-the-badge&logo=Lock&label=Encryption&labelColor=101418&color=BBBBDD)](#)

</div>

> **SOKO**는 사용자 데이터의 개인정보 보호를 절대적인 우선순위로 여깁니다. 독립 브랜드와 기업가를 위해 설계된 당사의 보안 모델은 데이터의 소유권이 사용자에게 있음을 보장합니다. 명시적인 동의 없이는 재고 데이터를 추적, 수집하거나 원격으로 저장하지 않습니다.

<br>

## 🏗️ 보안 아키텍처 및 데이터 개인정보 보호

당사의 보안은 엄격한 **Offline-First** 아키텍처에 기반합니다. 로컬 SQLite 데이터베이스는 인터넷 연결에 의존하지 않고도 정보에 대한 완전한 제어와 절대적인 개인정보 보호를 보장합니다.

### 🔐 데이터베이스 암호화(SQLCipher)
민감한 비즈니스 데이터를 무단 로컬 접근으로부터 보호하기 위해 SOKO는 **SQLCipher**를 구현합니다. 
* 물리적 SQLite 파일(`soko.db`)은 비밀번호 또는 PIN을 통해 침입자로부터 보호됩니다. 
* 이 암호화 계층은 투명하게 작동하며 데이터베이스의 구조적 규칙(음수 재고를 방지하도록 설계된 `CHECK` 제약 조건 등)을 변경하지 않습니다.
* **영지식 PIN:** SQLCipher를 잠금 해제하는 PIN 또는 마스터 비밀번호는 데이터베이스 내부에 **절대** 저장되지 않습니다. 악의적인 행위자가 `.db` 파일을 추출하더라도 자격 증명 없이는 완전히 읽을 수 없습니다.

### 📦 안전한 백업 및 파일 시스템
데이터 손상을 방지하고 빠르고 안전한 백업을 보장하기 위해 SOKO는 미디어를 원시 데이터로부터 분리합니다.
* **BLOB 허용 안 됨:** 데이터베이스 엔진은 텍스트 경로(`image_path: TEXT`)만 엄격하게 저장하며, 관계형 테이블 내에 무거운 파일(BLOB)을 직접 저장하는 것을 거부합니다.
* **암호화된 내보내기:** 백업을 생성할 때 시스템은 암호화된 데이터베이스 파일과 로컬 이미지 폴더를 휴대 가능한 `.zip` 파일로 안전하게 통합하여, 기기 간 쇼룸 데이터를 쉽고 안전하게 마이그레이션할 수 있게 합니다.

<br>
<hr>
<br>

## 📢 취약점 신고

SOKO 내에서 보안 취약점(예: Electron 창 렌더링의 익스플로잇, SQLite PIN을 우회하는 문제 또는 예상치 못한 데이터 유출)을 발견한 경우 공개 issue를 **열지 마세요**.

대신 책임감 있게 해결할 수 있도록 비공개로 팀에 신고해 주세요:

1. 발견 사항을 다음 이메일로 보내세요: **[kyroshop.exe@gmail.com](mailto:kyroshop.exe@gmail.com)**
2. 취약점에 대한 자세한 설명을 포함하세요.
3. 문제를 재현하는 단계를 제공하세요(로그, OS 버전 또는 스크린샷을 매우 환영합니다).

모든 보안 보고를 중요하게 여기며, 공개 전에 패치를 조율할 수 있도록 가능한 한 빨리 답변드리겠습니다.

<br>

### 🗃️ 지원되는 버전
현재 SOKO는 개발 초기 단계에 있으므로 `main` 브랜치와 최신 사전 릴리스 버전만 보안 업데이트를 받습니다.

<div align=center>

| 버전    | 지원 여부          |
| ------- | ------------------ |
| 1.0.x   | ✅ 활성            |
| < 1.0   | ❌ 지원되지 않음   |

</div>
