<div align="center">
    <h1>🛠️ Contributing to SOKO</h1>
    <b>Join us in building the ultimate inventory manager for clothing brands.</b>
</div>

<div align="center">
    <sub>
        <a href="CONTRIBUTING.md">English</a> · <a href="docs/languages/contributing/CONTRIBUTING.es.md">Español</a> · <a href="docs/languages/contributing/CONTRIBUTING.ru.md">Русский</a> · <a href="docs/languages/contributing/CONTRIBUTING.ja.md">日本語</a> · <a href="docs/languages/contributing/CONTRIBUTING.ko.md">한국어</a> · <a href="docs/languages/contributing/CONTRIBUTING.pt.md">Português</a> · <a href="docs/languages/contributing/CONTRIBUTING.fr.md">Français</a> · <a href="docs/languages/contributing/CONTRIBUTING.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![PRs Welcome - Static](https://img.shields.io/badge/PRs-Welcome?style=for-the-badge&logo=GitHub&label=PRs&labelColor=101418&color=99CCFF)](#)
[![Code Style - Static](https://img.shields.io/badge/Code-Clean?style=for-the-badge&logo=Codeigniter&label=Style&labelColor=101418&color=BBBBDD)](#)

</div>

> First off, thank you for considering contributing to **SOKO**! It's developers, designers, and brand owners like you that make the open-source community such an amazing place to learn and build.

<br>

## 🚀 How Can You Contribute?

* **Report Bugs:** Find an issue with the multi-inventory logic or UI? Open an issue and provide as much context as possible (logs, screenshots, OS version).
* **Suggest Features:** Have ideas for the label generator or the Kyro ecosystem? Open a discussion or an issue labeled `enhancement`.
* **Submit Code:** Grab any open issue labeled `good first issue` or `help wanted`, fork the repo, and start coding.

## 🛠️ Development Setup

To run SOKO locally, ensure you respect our **Offline-First** architecture powered by **Node.js, Electron, and SQLite 3**:

1. Fork and clone the repository.
2. Run `npm install` to grab all base dependencies.
3. Run `npm run rebuild sqlite3` (crucial for native binary compilation).
4. Start the development environment with `npm start`.

## 🌿 Pull Request Process

* **Create a Branch:** Branch off from `main` with a descriptive name (e.g., `feature/dark-mode-tweaks` or `fix/stock-transfer`).
* **Understand the Core:** Read our `AGENTS.md` and `AI_CONTEXT.md` files to fully understand the business logic, UI guidelines, and database strictness before writing code.
* **Commit Cleanly:** Write clear, concise commit messages.
* **Open a PR:** Describe the changes made, the problem it solves, and link any related issues. Wait for the maintainers to review it.

## 🎨 Styleguides & Conventions

* **UI/UX Aesthetics:** Any visual addition must respect the native *Dark Mode* and the *cyber/tech* aesthetic oriented towards streetwear.
* **Database Integrity:** Storing heavy images (BLOBs) in the database is strictly prohibited; use local file paths. Always respect relational limits and `PRAGMA foreign_keys = ON`.
* **Code Quality:** Keep functions modular, comment your structural decisions, and maintain clean indentation.
