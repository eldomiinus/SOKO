<div align="center">
    <h1>🛠️ SOKO への貢献</h1>
    <b>アパレルブランドのための究極の在庫管理ツールを、私たちと一緒に作りましょう。</b>
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

> まずは、**SOKO** への貢献を検討していただきありがとうございます！ オープンソースコミュニティを学び、構築するための素晴らしい場にしているのは、あなたのような開発者、デザイナー、ブランドオーナーです。

<br>

## 🚀 どのように貢献できますか？

* **バグを報告する:** マルチ在庫ロジックや UI に問題を見つけましたか？ issue を作成し、できるだけ多くの背景情報（ログ、スクリーンショット、OS バージョン）を提供してください。
* **機能を提案する:** ラベルジェネレーターや Kyro エコシステムについてのアイデアがありますか？ ディスカッションまたは `enhancement` ラベル付きの issue を作成してください。
* **コードを提出する:** `good first issue` または `help wanted` ラベルの付いたオープンな issue を選び、リポジトリをフォークしてコーディングを始めてください。

## 🛠️ 開発環境のセットアップ

SOKO をローカルで実行するには、**Node.js、Electron、SQLite 3** を基盤とする **Offline-First** アーキテクチャを必ず守ってください:

1. リポジトリをフォークしてクローンします。
2. `npm install` を実行して、すべての基本依存関係を取得します。
3. `npm run rebuild sqlite3` を実行します（ネイティブバイナリのコンパイルに不可欠です）。
4. `npm start` で開発環境を起動します。

## 🌿 Pull Request のプロセス

* **ブランチを作成する:** `main` から説明的な名前でブランチを作成します（例: `feature/dark-mode-tweaks` または `fix/stock-transfer`）。
* **コアを理解する:** コードを書く前に、ビジネスロジック、UI ガイドライン、データベースの厳格さを十分に理解するため、`AGENTS.md` と `AI_CONTEXT.md` を読んでください。
* **クリーンにコミットする:** 明確で簡潔なコミットメッセージを書いてください。
* **PR を作成する:** 行った変更、それが解決する問題を説明し、関連する issue をリンクしてください。メンテナーによるレビューを待ってください。

## 🎨 スタイルガイドと規約

* **UI/UX の美学:** すべての視覚的な追加は、ネイティブの *Dark Mode* とストリートウェア志向の *cyber/tech* 美学を尊重しなければなりません。
* **データベースの整合性:** データベースに重い画像（BLOB）を保存することは厳しく禁止されています。ローカルファイルパスを使用してください。常にリレーショナルな制限と `PRAGMA foreign_keys = ON` を守ってください。
* **コード品質:** 関数をモジュール化し、構造上の決定にはコメントを付け、きれいなインデントを維持してください。
