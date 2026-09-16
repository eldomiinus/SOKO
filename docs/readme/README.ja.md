<div align="center">
	<h1>📦 SOKO</h1>
	<b>アパレルブランドのためのインテリジェント・マルチインベントリ管理</b>
</div>

<div align="center">
	<sub>
		<a href="README.md">English</a> · <a href="docs/readme/README.es.md">Español</a> · <a href="docs/readme/README.ru.md">Русский</a> · <a href="docs/readme/README.ja.md">日本語</a> · <a href="docs/readme/README.ko.md">한국어</a> · <a href="docs/readme/README.pt.md">Português</a> · <a href="docs/readme/README.fr.md">Français</a> · <a href="docs/readme/README.it.md">Italiano</a>
	</sub>
</div>

<br>

<div align="center">

[![GitHub last commit](https://img.shields.io/github/last-commit/eldomiinus/SOKO?style=for-the-badge&labelColor=101418&color=9ccbfb)](https://github.com/eldomiinus/SOKO/activity)
[![GitHub Repo Stars](https://img.shields.io/github/stars/eldomiinus/SOKO?style=for-the-badge&labelColor=101418&color=b9c8da)](https://github.com/eldomiinus/SOKO/stargazers)
[![GitHub Repo Size](https://img.shields.io/github/repo-size/eldomiinus/SOKO?style=for-the-badge&labelColor=101418&color=d3bfe6)](https://github.com/eldomiinus/SOKO)
[![Framework](https://img.shields.io/badge/Framework-Electron-101418?style=for-the-badge&logo=electron&logoColor=ffffff&label=Framework&labelColor=101418&color=90C7FF)](https://www.electronjs.org/)
[![DataBase](https://img.shields.io/badge/Database-SQLite_3-101418?style=for-the-badge&logo=Sqlite&logoColor=747474&label=DataBase&labelColor=101418&color=90C7FF)](https://www.sqlite.org/index.html)
[![Ko-Fi Donate](https://img.shields.io/badge/donate-kofi?style=for-the-badge&logo=ko-fi&logoColor=ffffff&label=ko-fi&labelColor=101418&color=f16061)](https://ko-fi.com/eldomiinus)

</div>

> **「従来の在庫管理の混乱は、ここで終わります。」** SOKOは、*オルタナティブ*スタイルの新興ブランド、ショールーム、そして限定ローンチや*drops*を扱うアパレル事業者向けに設計された、包括的なデスクトップソフトウェアです。高度なバリエーションシステムにより各衣料品のライフサイクル全体を管理し、1点も失うことなく、倉庫、店舗、一時的なイベントをリアルタイムで管理できます。

## 📑 目次
- [🚀 主な機能](#-主な機能)
- [🏗️ アーキテクチャとテクノロジー](#️-アーキテクチャとテクノロジー)
- [🔗 Kyroモジュラーエコシステム](#-kyroモジュラーエコシステム)
- [🗺️ 開発と進捗](#️-開発と進捗)
- [⚙️ インストール](#️-インストール)
- [📈 統計](#-統計)

<br>

## 🚀 主な機能

- **🌐 動的マルチインベントリ:** 独立した在庫スペース（固定店舗、中央倉庫、週末のマーケット）を作成できます。リレーショナル・トランザクションによって拠点間で衣料品を安全に移動し、一時イベントをアーカイブすると、残った商品を中央在庫へ自動的に戻します。
- **🧬 バリエーションシステム（マルチレベル）:** 「親商品」を設定し、*サイズ*と*カラー*の組み合わせごとに在庫を分解して、個別かつ正確な在庫管理を行えます。
- **🏷️ ラベルジェネレーター:** バリエーションごとのSKU割り当てを自動化し、対応するバーコードと価格が入った物理ラベル用の印刷可能なPDFテンプレートを出力します。
- **⚡ カタログの一括操作:** 複数のバリエーションを同時に選択し、価格を一定の割合で引き上げたり、ワンクリックで運用ステータス（例: *生産中*から*販売可能*へ）を変更したりできます。
- **📒 統合サプライヤーディレクトリ:** 技術仕様書と連携した内部アドレス帳で、各ロットに対応する縫製工房やスクリーン印刷工房の正確な連絡先を保存できます。成功した生産をすばやく繰り返すうえで不可欠です。
- **📉 「滞留在庫」（Dead Stock）レポート:** 60日を超えて在庫内で動きのない衣料品を検出するインテリジェントな分析パネルを備え、在庫処分や特別プロモーションの計画に不可欠な指標を提供します。

<br>

## 🏗️ アーキテクチャとテクノロジー

> [!NOTE]
> SOKOは**Offline-First**アーキテクチャに基づいて設計されており、ネイティブ性能、完全なポータビリティ（インターネット接続のないマーケットでもスムーズに運用可能）、そしてローカルデータの完全なプライバシーを優先しています。

### 💻 技術スタック

<div align=center>

| レイヤー | テクノロジー | 説明 |
| :--- | :--- | :--- |
| **🎨 フロントエンド（UI/UX）** | HTML5, CSS3, Vanilla JS | CSS Gridで構成されたインターフェース。ネイティブな*Dark Mode*（*cyber/tech*の美学）、フレームなしウィンドウ（frameless）、動的に折りたためるパネルを採用しています。 |
| **⚙️ バックエンド** | Node.js + Electron | ネイティブデスクトップアプリケーションとしてパッケージ化し、高い性能、安全なウィンドウ管理、ローカルファイルシステムへの深いアクセスを実現します。 |
| **💾 データベース** | SQLite3 | `userData`に配置されるローカルのリレーショナルエンジン（単一ファイル）。安全なACIDトランザクションをサポートし、ポータビリティを保証します。 |

</div>

### 📂 データフローとストレージ
1. **リレーショナル正規化:** 衣料品の識別情報（総合カタログ）と物理的な場所（在庫）を、トランザクション用の中間テーブル（*Inventory_Stock*）で厳密に分離し、データの重複を完全に排除します。
2. **最適化されたマルチメディア管理:** データベースに大容量画像（BLOB）を保存することは固く禁止されています。写真はローカルディレクトリへ透過的にコピーされ、SQLiteには相対パスだけが記録されます。これによりデータベースを極めて軽量に保ち、ミリ秒単位の応答時間を保証します。

<br>

## 🔗 Kyroモジュラーエコシステム

SOKOは、スケーラブルでオーダーメイドの作業環境の中核となるよう、モジュラーアーキテクチャで設計されています。起業家の事業運営と財務の成長に合わせて適応します。

- **📦 SOKO（Core）:** カタログ全体の管理、複数スペースの物流、バリエーションの徹底的な管理を担うメインエンジンです。
- **🛒 SOKO POS（レジ拡張 - 近日公開）:** レジでの使用だけを目的に設計された、任意で独立した超軽量モジュールです。レーザーバーコードスキャナーのサポートと素早い合計計算を統合します。メインの管理アプリケーションを開かなくても、同じローカルSQLiteデータベースに接続して在庫をリアルタイムで差し引く「ライトクライアント」として機能します。
- **📊 KURA（財務 - 近日公開）:** SOKO/POSで記録された売上から金銭的な収入を自動的に受け取るために同期する、高度な財務プラットフォームです。単一の自動化されたフローの下で、運用と経済の管理を統合します。

<br>

## 🗺️ 開発と進捗

### 📌 計画と構造化のフェーズ
- [x] アーキテクチャとリレーショナルデータベースの定義（[`SQLite`](https://www.sqlite.org/index.html)）。
- [x] 要件、ユーザーフロー、マルチインベントリの仕様策定。
- [x] UI/UXデザインガイドとカラーパレット（*Dark Mode* / *Cyber tech*）。
- [x] Kyroモジュラーエコシステム（SOKO、POS、KURA）のアーキテクチャ設計。

### 🎨 フロントエンド開発のフェーズ
- [x] UI基盤アーキテクチャのレイアウト（CSS Grid、4つの機能ゾーン）。
- [x] ネイティブ動作の実装（フレームレスウィンドウとドラッグ可能なTop Bar）。
- [x] 折りたたみ可能なSidebarと動的な詳細パネルの開発（インタラクティブなMockup）。
- [ ] フロントエンドとSQLiteのテンプレート/データエンジンの接続。

### 💼 バックエンドとロジック開発のフェーズ
- [x] Node.js環境とElectron依存関係の設定。
- [x] ネイティブバイナリのコンパイルとGitでの`node_modules`除外。
- [x] ユーザーディレクトリへのローカルデータベース（`soko.db`）自動初期化。
- [ ] 「親商品」モジュールとそのバリエーション分解のためのCRUD作成。
- [ ] 在庫移動のための安全なトランザクションエンジンの開発。
- [ ] 補助モジュールの実装: ラベル生成、一括操作、Dead Stock検出。

<br>

## ⚙️ インストール

ローカルマシンでSOKOの環境を起動し、開発への貢献を始めるには、次の手順に従ってください。

```bash
# 1. 公式リポジトリをクローン
git clone https://github.com/eldomiinus/soko.git

# 2. プロジェクトのルートディレクトリへ移動
cd soko

# 3. プロジェクトの依存関係をインストール
npm install

# 4. ネイティブモジュール（SQLite3）が正しくコンパイルされるようにする
npm rebuild sqlite3

# 5. 開発モードでアプリケーションを実行
npm start
```

<br>

## 📈 統計

<a href="https://www.star-history.com/?repos=eldomiinus%2Fsoko&type=date&legend=bottom-right">
	<picture>
		<source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&theme=dark&legend=top-left" />
		<source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
		<img alt="Star History Chart" src="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
	</picture>
</a>

<br>

<div align="center">
	<h2>¡ご覧いただきありがとうございました！ <3</h2>
</div>
