<div align="center">
	<h1>📦 SOKO</h1>
	<b>Gestion Intelligente et Multi-Inventaire pour les Marques de Vêtements</b>
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

> **"Le chaos du stock traditionnel s'arrête ici."** SOKO est un logiciel de bureau complet conçu pour les marques émergentes aux styles *alternatifs*, les showrooms et les entrepreneurs du textile qui gèrent des lancements limités ou des *drops*. Il permet de contrôler le cycle de vie complet de chaque vêtement grâce à un système avancé de variantes, en gérant en temps réel les entrepôts, les locaux et les événements temporaires sans perdre une seule unité.

## 📑 Table des matières
- [🚀 Fonctionnalités principales](#-fonctionnalités-principales)
- [🏗️ Architecture et Technologies](#️-architecture-et-technologies)
- [🔗 L'Écosystème Modulaire Kyro](#-lécosystème-modulaire-kyro)
- [🗺️ Développement et Progression](#️-développement-et-progression)
- [⚙️ Installation](#️-installation)
- [📈 Statistiques](#-statistiques)

<br>

## 🚀 Fonctionnalités principales

- **🌐 Multi-Inventaire Dynamique :** Crée des espaces de stock indépendants (Local Fixe, Entrepôt Central, Marchés du week-end). Transfère les vêtements entre les emplacements en toute sécurité grâce à des transactions relationnelles et, lors de l'archivage d'un événement temporaire, renvoie automatiquement les invendus vers le stock central.
- **🧬 Système de Variantes (Multi-Niveau) :** Configure un "Produit Parent" et détaille l'inventaire pour chaque combinaison de *Taille* et de *Couleur* avec un contrôle individuel et précis du stock.
- **🏷️ Générateur d'Étiquettes :** Attribution automatisée de SKU par variante et exportation de modèles PDF prêts à imprimer des étiquettes physiques avec leurs codes-barres et leurs prix respectifs.
- **⚡ Actions Massives du Catalogue :** Sélectionne plusieurs variantes simultanément pour appliquer des augmentations de prix en pourcentage ou modifier des états opérationnels (ex. de *En Production* à *Disponible*) en un seul clic.
- **📒 Répertoire Intégré des Fournisseurs :** Agenda interne lié à la fiche technique pour enregistrer les coordonnées exactes des ateliers de confection et de sérigraphie correspondant à chaque lot, essentiel pour accélérer la reproduction des productions réussies.
- **📉 Rapport de "Stock Dormant" (Dead Stock) :** Tableau de bord analytique intelligent qui détecte les vêtements immobilisés dans l'inventaire depuis plus de 60 jours, en fournissant la métrique indispensable pour planifier des liquidations ou des promotions spéciales.

<br>

## 🏗️ Architecture et Technologies

> [!NOTE]
> SOKO est conçu selon une architecture **Offline-First**, privilégiant les performances natives, la portabilité totale (pour fonctionner parfaitement sur les marchés sans connexion Internet) et la confidentialité absolue des données locales.

### 💻 Stack Technologique

<div align=center>

| Couche | Technologie | Description |
| :--- | :--- | :--- |
| **🎨 Frontend (UI/UX)** | HTML5, CSS3, Vanilla JS | Interface structurée avec CSS Grid. Design *Dark Mode* natif (esthétique *cyber/tech*), fenêtre sans cadre (frameless) et panneaux dynamiques réductibles. |
| **⚙️ Backend** | Node.js + Electron | Empaquetage d'une application de bureau native, garantissant de hautes performances, une gestion sécurisée des fenêtres et un accès approfondi au système de fichiers local. |
| **💾 Base de Données** | SQLite3 | Moteur relationnel local (fichier unique) hébergé dans `userData`. Prend en charge des transactions ACID sécurisées et garantit la portabilité. |

</div>

### 📂 Flux de Données et Stockage
1. **Normalisation Relationnelle :** Séparation stricte entre l'identité du vêtement (le catalogue général) et son emplacement physique (les inventaires) à l'aide de tables de liaison transactionnelles (*Inventory_Stock*), éliminant complètement la duplication des données.
2. **Gestion Multimédia Optimisée :** Il est strictement interdit de stocker des images lourdes (BLOB) dans la base de données. Les photographies sont copiées de manière transparente dans un répertoire local et SQLite enregistre uniquement les chemins relatifs. Cela garantit que la base de données conserve une taille ultra-légère et assure des temps de réponse de l'ordre de la milliseconde.

<br>

## 🔗 L'Écosystème Modulaire Kyro

SOKO est conçu avec une architecture modulaire pour se positionner comme le noyau d'un environnement de travail évolutif et sur mesure, s'adaptant à la croissance opérationnelle et financière de l'entrepreneur :

- **📦 SOKO (Core) :** Le moteur principal pour l'administration complète du catalogue, la logistique multi-espace et le contrôle exhaustif des variantes.
- **🛒 SOKO POS (Extension de Caisse - Prochainement) :** Un module optionnel, indépendant et ultraléger conçu exclusivement pour une utilisation au comptoir. Il intègre la prise en charge des scanners laser de codes-barres et le calcul rapide des totaux. Il agit comme un "client léger" qui se connecte à la même base de données locale SQLite pour déduire le stock en temps réel, sans nécessiter l'ouverture de l'application principale d'administration.
- **📊 KURA (Finances - Prochainement) :** Plateforme financière de haut niveau qui se synchronise pour recevoir automatiquement les revenus monétaires des ventes enregistrées par SOKO/POS, consolidant le contrôle opérationnel et économique au sein d'un flux automatisé unique.

<br>

## 🗺️ Développement et Progression

### 📌 Phases de Planification et de Structure
- [x] Définition de l'Architecture et de la Base de Données relationnelle ([`SQLite`](https://www.sqlite.org/index.html)).
- [x] Spécification des Exigences, des Flux Utilisateur et du Multi-Inventaire.
- [x] Guide de Conception UI/UX et Palette de Couleurs (*Dark Mode* / *Cyber tech*).
- [x] Conception architecturale de l'Écosystème Modulaire Kyro (SOKO, POS et KURA).

### 🎨 Phases de Développement Frontend
- [x] Maquettage de l'architecture UI de base (CSS Grid, 4 zones fonctionnelles).
- [x] Implémentation du comportement natif (Fenêtre Frameless et Top Bar déplaçable).
- [x] Développement de la Sidebar réductible et du Panneau de Détails dynamique (Mockup interactif).
- [ ] Connexion du frontend au moteur de modèles/données de SQLite.

### 💼 Phases de Développement Backend et Logique
- [x] Configuration de l'environnement Node.js et des dépendances d'Electron.
- [x] Compilation des binaires natifs et exclusion de `node_modules` dans Git.
- [x] Initialisation automatique de la base de données locale (`soko.db`) dans le répertoire utilisateur.
- [ ] Création du module CRUD pour le "Produit Parent" et le détail de ses Variantes.
- [ ] Développement du moteur transactionnel sécurisé pour les transferts de stock.
- [ ] Implémentation des Modules Auxiliaires : Génération d'Étiquettes, Actions Massives et Détection du Dead Stock.

<br>

## ⚙️ Installation

Suis ces étapes pour mettre en place l'environnement de SOKO sur ta machine locale et commencer à contribuer au développement.

```bash
# 1. Cloner le dépôt officiel
git clone https://github.com/eldomiinus/soko.git

# 2. Accéder au répertoire racine du projet
cd soko

# 3. Installer les dépendances du projet
npm install

# 4. S'assurer de la bonne compilation des modules natifs (SQLite3)
npm rebuild sqlite3

# 5. Exécuter l'application en mode développement
npm start
```

<br>

## 📈 Statistiques

<div align=center>
<a href="https://www.star-history.com/?repos=eldomiinus%2Fsoko&type=date&legend=bottom-right">
	<picture>
		<source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&theme=dark&legend=top-left" />
		<source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
		<img alt="Star History Chart" src="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
	</picture>
</a>
</div>

<br>

<div align="center">

<h2>¡Merci de votre attention! <3</h2>

[![GitHub License - Dynamic](https://img.shields.io/github/license/eldomiinus/soko?style=for-the-badge&logo=GitBook&label=License&labelColor=101418&color=BBBBDD)](https://github.com/eldomiinus/SOKO?tab=License-1-ov-file)

</div>
