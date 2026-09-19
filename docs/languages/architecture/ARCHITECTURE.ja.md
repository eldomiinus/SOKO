<div align="center">
    <h1>⚙️ SOKO アーキテクチャ</h1>
    <b>Offline-First エコシステムの技術的基盤。</b>
</div>

<div align="center">
    <sub>
        <a href="../../ARCHITECTURE.md">English</a> · <a href="ARCHITECTURE.es.md">Español</a> · <a href="ARCHITECTURE.ru.md">Русский</a> · <a href="ARCHITECTURE.ja.md">日本語</a> · <a href="ARCHITECTURE.ko.md">한국어</a> · <a href="ARCHITECTURE.pt.md">Português</a> · <a href="ARCHITECTURE.fr.md">Français</a> · <a href="ARCHITECTURE.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![Offline First - Static](https://img.shields.io/badge/Architecture-Offline_First?style=for-the-badge&logo=Databricks&label=Architecture&labelColor=101418&color=99CCFF)](#)
[![IPC Bridge - Static](https://img.shields.io/badge/Electron-IPC_Bridge?style=for-the-badge&logo=Electron&label=Communication&labelColor=101418&color=BBBBDD)](#)

</div>

> **SOKO** は、ネイティブ性能、絶対的なデータプライバシー、インターネット接続に依存しない一時的なフェアでの完全な運用性を保証するために設計されたネイティブデスクトップアプリケーションです。この文書では、この環境における Frontend、Backend、データベースの相互作用を説明します。

<br>

## 🖥️ 1. Electron IPC 通信モデル

SOKO は **Electron** でパッケージ化されているため、セキュリティと性能のために、ユーザーインターフェースとシステムリソースの責任を厳格に分離しています:

* **Frontend（Renderer プロセス）:** HTML5、CSS3（Grid）、Vanilla JS で構築されています。UI/UX、アニメーション、ユーザー入力を処理します。**データベースに直接触れることはありません。**
* **IPC ブリッジ（Context Bridge）:** Electron の `preload.js` を使用して、frontend に安全な API を公開します。
* **Backend（Main プロセス）:** Node.js 上で動作します。Frontend から送信された IPC チャネルを受け取り、重い論理操作を実行し、ローカルファイルシステムの読み書きと SQLite データベースの照会を行います。

## 💾 2. データベースエンジンとファイルシステム

データストレージの中核は **SQLite 3** を使うリレーショナルモデルです。アプリケーションを高速に保つため、厳格な技術ルールを適用しています:

### 「BLOB なし」のルール
データベース内に画像を保存するための BLOB フィールドの使用は厳しく禁止されています。重いメディアを SQLite に直接保存すると、データベースの肥大化と性能低下を招きます。
* **処理方法:** Backend は物理画像ファイルをローカルディレクトリツリー（例: `/assets/images/catalog/`）に保存します。
* データベースには、そのファイルを指すローカルパスのテキスト文字列（`image_path: TEXT`）だけを保存します。

### データ整合性と設定
* **厳格な関係:** 供給業者、製品、インベントリ間の整合性を保証するため、すべての接続で `PRAGMA foreign_keys = ON;` を明示的に適用します。
* **アプリケーション設定:** ダークモードの状態や最終バックアップ日などのシステム設定は、トランザクション在庫データを煩雑にしないよう、別の `App_Settings` テーブルに分離されます。

## 📦 3. マルチインベントリロジック（ブリッジ）

SOKO の特徴は、複数の物理的な場所（例: 中央倉庫、ポップアップストア、フェア）を同時に管理できることです。 

場所は性質（`type`）により、*Fijo*（Fixed）、*Temporal*（Temporary）、*Transito*（In-Transit）に分類されます。

### トランザクションブリッジ

`Inventory_Stock` というブリッジテーブルを使い、重複する製品エントリを回避します。 
* 週末のフェアに在庫を移動すると、システムは「中央倉庫」からユニットを差し引き、安全な SQL トランザクションにより「フェア」インベントリへ割り当てます。 
* フェア終了後、残った在庫は戻されます。
* **安全第一:** 物理在庫が**決して**負にならないよう、データベースレベルで `CHECK` 制約を使います。

## 🔗 4. モジュラーエコシステム

SOKO はスケーラブルな環境の中核エンジンとして機能します。データベースアーキテクチャは、今後の拡張機能で利用できるよう準備されています:

1. **SOKO POS:** レジ担当者がバーコードをスキャンし、リアルタイムで在庫を円滑に差し引くための将来の会計拡張機能。
2. **KURA 統合:** SOKO で「Sold」とマークされたすべての品目が、KURA 財務システムの収益エントリを自動的に発生させ、運用と経済の管理を統合する将来のモジュール。
