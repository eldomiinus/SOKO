<div align="center">
    <h1>🛡️ SOKO セキュリティポリシー</h1>
    <b>設計段階からのプライバシー、offline-first アーキテクチャ、ローカルでのデータ管理。</b>
</div>

<div align="center">
    <sub>
        <a href="../../../SECURITY.md">English</a> · <a href="SECURITY.es.md">Español</a> · <a href="SECURITY.ru.md">Русский</a> · <a href="SECURITY.ja.md">日本語</a> · <a href="SECURITY.ko.md">한국어</a> · <a href="SECURITY.pt.md">Português</a> · <a href="SECURITY.fr.md">Français</a> · <a href="SECURITY.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![Privacy First - Static](https://img.shields.io/badge/Privacity-Data?style=for-the-badge&logo=GoogleAppsScript&logoColor=65686B&label=Data&labelColor=101418&color=99CCFF)](#)
[![Encryption - Static](https://img.shields.io/badge/AES_256-Encryption?style=for-the-badge&logo=LetsEncrypt&logoColor=65686B&label=Encryption&labelColor=101418&color=BBBBDD)](#)

</div>

> **SOKO** は、ユーザーデータのプライバシーを絶対的な最優先事項として扱います。独立系ブランドや起業家向けに設計された当社のセキュリティモデルは、データの所有者があなたであることを保証します。明示的な同意なしに、在庫データを追跡、収集、またはリモートで保存することはありません。

<br>

## 🏗️ セキュリティアーキテクチャとデータプライバシー

当社のセキュリティは、厳格な **Offline-First** アーキテクチャに依存しています。ローカルの SQLite データベースにより、インターネット接続に依存することなく、情報の完全な管理と絶対的なプライバシーが保証されます。

### 🔐 データベース暗号化（SQLCipher）
機密性の高い事業データを不正なローカルアクセスから保護するため、SOKO は **SQLCipher** を実装しています。 
* 物理 SQLite ファイル（`soko.db`）は、パスワードまたは PIN によって侵入者から保護されます。 
* この暗号化レイヤーは透過的に動作し、データベースの構造ルール（負の在庫を防ぐために設計された `CHECK` 制約など）を変更しません。
* **ゼロ知識 PIN:** SQLCipher のロックを解除する PIN またはマスターパスワードがデータベース内に保存されることは**ありません**。悪意のある者が `.db` ファイルを抽出しても、資格情報がなければ完全に読み取れません。

### 📦 安全なバックアップとファイルシステム
データ破損を防ぎ、高速で安全なバックアップを確保するため、SOKO はメディアを生データから分離します。
* **BLOB は許可されません:** データベースエンジンはテキストパス（`image_path: TEXT`）のみを厳格に保存し、リレーショナルテーブル内への重いファイル（BLOB）の直接保存を拒否します。
* **暗号化されたエクスポート:** バックアップを生成する際、システムは暗号化されたデータベースファイルとローカル画像フォルダを、ポータブルな `.zip` ファイルに安全に統合します。これにより、ショールームデータをデバイス間で簡単かつ安全に移行できます。

<br>
<hr>
<br>

## 📢 脆弱性の報告

SOKO 内でセキュリティ脆弱性（たとえば、Electron ウィンドウレンダリングのエクスプロイト、SQLite PIN を回避する問題、予期しないデータ漏洩）を発見した場合は、公開 issue を**開かないでください**。

代わりに、私たちが責任を持って対処できるよう、チームに非公開で報告してください:

1. 調査結果を次のメールアドレスに送信してください: **[kyroshop.exe@gmail.com](mailto:kyroshop.exe@gmail.com)**
2. 脆弱性の詳細な説明を含めてください。
3. 問題を再現する手順を提供してください（ログ、OS バージョン、スクリーンショットは大変歓迎します）。

すべてのセキュリティ報告を真剣に受け止め、公開前にパッチを調整するため、できるだけ早く返信します。

<br>

### 🗃️ サポート対象バージョン
現在、SOKO は開発の初期段階にあるため、セキュリティアップデートを受け取るのは `main` ブランチと最新のプレリリースバージョンのみです。

<div align=center>

| バージョン | サポート状況       |
| ---------- | ------------------ |
| 1.0.x      | ✅ 有効            |
| < 1.0      | ❌ サポート対象外  |

</div>
