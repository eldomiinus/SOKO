<div align="center">
    <h1>⚙️ Architecture de SOKO</h1>
    <b>La fondation technique de notre écosystème Offline-First.</b>
</div>

<div align="center">
    <sub>
        <a href="../ARCHITECTURE.md">English</a> · <a href="ARCHITECTURE.es.md">Español</a> · <a href="ARCHITECTURE.ru.md">Русский</a> · <a href="ARCHITECTURE.ja.md">日本語</a> · <a href="ARCHITECTURE.ko.md">한국어</a> · <a href="ARCHITECTURE.pt.md">Português</a> · <a href="ARCHITECTURE.fr.md">Français</a> · <a href="ARCHITECTURE.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![Offline First - Static](https://img.shields.io/badge/Architecture-Offline_First?style=for-the-badge&logo=Databricks&label=Architecture&labelColor=101418&color=99CCFF)](#)
[![IPC Bridge - Static](https://img.shields.io/badge/Electron-IPC_Bridge?style=for-the-badge&logo=Electron&label=Communication&labelColor=101418&color=BBBBDD)](#)

</div>

> **SOKO** est conçu comme une application de bureau native destinée à garantir des performances natives, une confidentialité absolue des données et une opérabilité totale lors de foires temporaires sans dépendre d'une connexion internet. Ce document décrit comment le Frontend, le Backend et la base de données interagissent dans cet environnement.

<br>

## 🖥️ 1. Le modèle de communication IPC d'Electron

Comme SOKO est empaqueté avec **Electron**, nous maintenons une stricte séparation des responsabilités entre l'interface utilisateur et les ressources système, pour la sécurité et les performances :

* **Frontend (processus Renderer) :** Construit avec HTML5, CSS3 (Grid) et Vanilla JS. Il gère l'UI/UX, les animations et capture les entrées utilisateur. **Il n'accède jamais directement à la base de données.**
* **Pont IPC (Context Bridge) :** Nous utilisons le `preload.js` d'Electron pour exposer une API sécurisée au frontend.
* **Backend (processus Main) :** Il s'exécute sur Node.js. Il écoute les canaux IPC envoyés par le Frontend, exécute les opérations logiques lourdes, lit/écrit dans le système de fichiers local et interroge la base de données SQLite.

## 💾 2. Moteur de base de données et système de fichiers

Le cœur de notre stockage de données repose sur un modèle relationnel utilisant **SQLite 3**. Nous appliquons des règles techniques strictes pour que l'application reste extrêmement rapide :

### La règle « sans BLOB »
L'utilisation de champs BLOB pour stocker des images dans la base de données est strictement interdite. Le stockage direct de médias lourds dans SQLite entraîne un gonflement important de la base de données et une dégradation des performances.
* **Notre approche :** Le backend enregistre les fichiers image physiques dans une arborescence locale (par ex., `/assets/images/catalog/`).
* La base de données ne stocke que la chaîne de texte du chemin local (`image_path: TEXT`) qui pointe vers ce fichier.

### Intégrité et paramètres des données
* **Relations strictes :** Nous appliquons explicitement `PRAGMA foreign_keys = ON;` à chaque connexion pour garantir l'intégrité des données entre les fournisseurs, les produits et les inventaires.
* **Paramètres de l'application :** Les préférences système (comme l'état du mode sombre ou la date de la dernière sauvegarde) sont isolées dans une table `App_Settings` distincte afin de ne pas encombrer les données d'inventaire transactionnelles.

## 📦 3. Logique multi-inventaire (le pont)

La caractéristique distinctive de SOKO est sa capacité à gérer simultanément plusieurs emplacements physiques (par ex., entrepôt central, boutiques éphémères, foires). 

Les emplacements sont catégorisés selon leur nature (`type`) : *Fijo* (Fixed), *Temporal* (Temporary) ou *Transito* (In-Transit).

### Le pont transactionnel

Nous évitons les entrées de produits en double en utilisant une table de liaison appelée `Inventory_Stock`. 
* Lorsqu'un stock est déplacé vers une foire du week-end, le système déduit nativement les unités de l'« entrepôt central » et les affecte à l'inventaire de la « foire » au moyen de transactions SQL sécurisées. 
* Une fois la foire terminée, le stock restant est transféré en retour.
* **La sécurité avant tout :** Nous utilisons des contraintes `CHECK` au niveau de la base de données pour garantir que le stock physique ne puisse **jamais** être négatif.

## 🔗 4. L'écosystème modulaire

SOKO agit comme le moteur central d'un environnement évolutif. Son architecture de base de données est prête à être exploitée par de futures extensions :

1. **SOKO POS :** Une future extension de caisse permettant aux caissiers de scanner les codes-barres et de déduire le stock sans friction, en temps réel.
2. **Intégration KURA :** Un futur module où chaque article marqué comme « Sold » dans SOKO déclenchera automatiquement une entrée de revenu monétaire dans le système financier KURA, unifiant le contrôle opérationnel et économique.
