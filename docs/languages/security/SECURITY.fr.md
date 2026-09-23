<div align="center">
    <h1>🛡️ Politique de sécurité de SOKO</h1>
    <b>Confidentialité dès la conception, architecture offline-first et contrôle local des données.</b>
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

> **SOKO** considère la confidentialité des données des utilisateurs comme une priorité absolue. Conçu pour les marques indépendantes et les entrepreneurs, notre modèle de sécurité garantit que vos données vous appartiennent. Nous ne suivons, ne collectons ni ne stockons à distance vos données d'inventaire sans votre consentement explicite.

<br>

## 🏗️ Architecture de sécurité et confidentialité des données

Notre sécurité repose sur une architecture **Offline-First** stricte. La base de données SQLite locale garantit un contrôle total et une confidentialité absolue de vos informations sans dépendre de connexions internet.

### 🔐 Chiffrement de la base de données (SQLCipher)
Pour protéger les données sensibles de votre entreprise contre tout accès local non autorisé, SOKO met en œuvre **SQLCipher**. 
* Le fichier SQLite physique (`soko.db`) est protégé contre les intrus par un mot de passe ou un PIN. 
* Cette couche de chiffrement fonctionne de manière transparente et ne modifie pas les règles structurelles de la base de données (telles que les contraintes `CHECK` conçues pour empêcher les stocks négatifs).
* **PIN à connaissance nulle :** Le PIN ou mot de passe maître qui déverrouille SQLCipher n'est **jamais** enregistré dans la base de données. Si un acteur malveillant extrait le fichier `.db`, celui-ci reste totalement illisible sans vos identifiants.

### 📦 Sauvegardes sécurisées et système de fichiers
Pour empêcher la corruption des données et garantir des sauvegardes rapides et sécurisées, SOKO isole les médias des données brutes.
* **Aucun BLOB autorisé :** Le moteur de base de données enregistre strictement des chemins de texte (`image_path: TEXT`) et rejette le stockage direct de fichiers lourds (BLOBs) dans les tables relationnelles.
* **Exportations chiffrées :** Lors de la génération d'une sauvegarde, le système regroupe de manière sûre le fichier de base de données chiffré et le dossier d'images local dans un fichier `.zip` portable, ce qui rend la migration de vos données de showroom entre appareils simple et sûre.

<br>
<hr>
<br>

## 📢 Signaler une vulnérabilité

Si vous découvrez une vulnérabilité de sécurité dans SOKO (par exemple, un exploit dans le rendu des fenêtres Electron, un problème permettant de contourner le PIN SQLite ou une fuite de données inattendue), n'ouvrez **PAS** d'issue publique.

Signalez-la plutôt en privé à notre équipe afin que nous puissions la traiter de manière responsable :

1. Envoyez vos conclusions par e-mail à : **[kyroshop.exe@gmail.com](mailto:kyroshop.exe@gmail.com)**
2. Incluez une description détaillée de la vulnérabilité.
3. Fournissez les étapes permettant de reproduire le problème (les logs, la version du système d'exploitation ou les captures d'écran sont vivement appréciés).

Nous prenons tous les rapports de sécurité au sérieux et répondrons dès que possible afin de coordonner un correctif avant la divulgation publique.

<br>

### 🗃️ Versions prises en charge
Actuellement, SOKO étant à ses premiers stades de développement, seule la branche `main` et les dernières versions préliminaires reçoivent des mises à jour de sécurité.

<div align=center>

| Version | Prise en charge     |
| ------- | ------------------- |
| 1.0.x   | ✅ Active           |
| < 1.0   | ❌ Non prise en charge |

</div>
