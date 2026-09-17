<div align="center">
    <h1>🛠️ Contribuer à SOKO</h1>
    <b>Rejoignez-nous pour créer le gestionnaire d'inventaire ultime pour les marques de vêtements.</b>
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

> Avant toute chose, merci d'envisager de contribuer à **SOKO** ! Ce sont des développeurs, des designers et des propriétaires de marques comme vous qui font de la communauté open source un lieu aussi formidable pour apprendre et construire.

<br>

## 🚀 Comment pouvez-vous contribuer ?

* **Signaler des bugs :** Vous avez trouvé un problème dans la logique multi-inventaire ou l'UI ? Ouvrez une issue et fournissez autant de contexte que possible (logs, captures d'écran, version du système d'exploitation).
* **Suggérer des fonctionnalités :** Vous avez des idées pour le générateur d'étiquettes ou l'écosystème Kyro ? Ouvrez une discussion ou une issue avec le label `enhancement`.
* **Soumettre du code :** Prenez n'importe quelle issue ouverte avec le label `good first issue` ou `help wanted`, forkez le dépôt et commencez à coder.

## 🛠️ Configuration de développement

Pour exécuter SOKO localement, assurez-vous de respecter notre architecture **Offline-First** propulsée par **Node.js, Electron et SQLite 3** :

1. Forkez et clonez le dépôt.
2. Exécutez `npm install` pour récupérer toutes les dépendances de base.
3. Exécutez `npm run rebuild sqlite3` (crucial pour la compilation binaire native).
4. Démarrez l'environnement de développement avec `npm start`.

## 🌿 Processus de Pull Request

* **Créez une branche :** Partez de `main` avec un nom descriptif (par ex., `feature/dark-mode-tweaks` ou `fix/stock-transfer`).
* **Comprenez le cœur :** Lisez nos fichiers `AGENTS.md` et `AI_CONTEXT.md` pour comprendre pleinement la logique métier, les directives d'UI et la rigueur de la base de données avant d'écrire du code.
* **Faites des commits propres :** Rédigez des messages de commit clairs et concis.
* **Ouvrez une PR :** Décrivez les modifications apportées, le problème qu'elles résolvent et liez toutes les issues associées. Attendez que les responsables l'examinent.

## 🎨 Guides de style et conventions

* **Esthétique UI/UX :** Tout ajout visuel doit respecter le *Dark Mode* natif et l'esthétique *cyber/tech* orientée streetwear.
* **Intégrité de la base de données :** Le stockage d'images lourdes (BLOBs) dans la base de données est strictement interdit ; utilisez des chemins de fichiers locaux. Respectez toujours les limites relationnelles et `PRAGMA foreign_keys = ON`.
* **Qualité du code :** Gardez les fonctions modulaires, commentez vos décisions structurelles et maintenez une indentation propre.
