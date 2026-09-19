<div align="center">
    <h1>⚙️ Architettura di SOKO</h1>
    <b>La base tecnica del nostro ecosistema Offline-First.</b>
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

> **SOKO** è realizzato come applicazione desktop nativa, progettata per garantire prestazioni native, privacy assoluta dei dati e piena operatività durante fiere temporanee senza dipendere da una connessione internet. Questo documento descrive come Frontend, Backend e Database interagiscono in questo ambiente.

<br>

## 🖥️ 1. Il modello di comunicazione IPC di Electron

Poiché SOKO è pacchettizzato con **Electron**, manteniamo una rigorosa separazione delle responsabilità tra l'interfaccia utente e le risorse di sistema per sicurezza e prestazioni:

* **Frontend (processo Renderer):** Realizzato con HTML5, CSS3 (Grid) e Vanilla JS. Gestisce UI/UX, animazioni e acquisisce gli input dell'utente. **Non accede mai direttamente al database.**
* **Ponte IPC (Context Bridge):** Utilizziamo `preload.js` di Electron per esporre un'API sicura al frontend.
* **Backend (processo Main):** Viene eseguito su Node.js. Ascolta i canali IPC inviati dal Frontend, esegue le operazioni logiche pesanti, legge/scrive nel file system locale e interroga il database SQLite.

## 💾 2. Motore di database e file system

Il nucleo dell'archiviazione dati si basa su un modello relazionale che usa **SQLite 3**. Applichiamo rigide regole tecniche per mantenere l'applicazione estremamente veloce:

### La regola «No BLOB»
L'uso di campi BLOB per archiviare immagini nel database è severamente vietato. Archiviare media pesanti direttamente in SQLite causa grave gonfiore del database e degrado delle prestazioni.
* **Come lo gestiamo:** Il backend salva i file immagine fisici in un albero di directory locale (ad es., `/assets/images/catalog/`).
* Il database memorizza solo la stringa di testo del percorso locale (`image_path: TEXT`) che punta a quel file.

### Integrità e impostazioni dei dati
* **Relazioni rigorose:** Applichiamo esplicitamente `PRAGMA foreign_keys = ON;` a ogni connessione per garantire l'integrità dei dati tra fornitori, prodotti e inventari.
* **Impostazioni dell'applicazione:** Le preferenze di sistema (come lo stato della modalità scura o la data dell'ultimo backup) sono isolate in una tabella `App_Settings` separata per non ingombrare i dati transazionali dell'inventario.

## 📦 3. Logica multi-inventario (il ponte)

La caratteristica distintiva di SOKO è la capacità di gestire contemporaneamente più sedi fisiche (ad es., magazzino centrale, negozi pop-up, fiere). 

Le sedi sono classificate in base alla loro natura (`type`): *Fijo* (Fixed), *Temporal* (Temporary) o *Transito* (In-Transit).

### Il ponte transazionale

Evitiamo voci duplicate dei prodotti tramite una tabella ponte chiamata `Inventory_Stock`. 
* Quando lo stock viene spostato a una fiera del fine settimana, il sistema sottrae nativamente le unità dal «magazzino centrale» e le assegna all'inventario della «fiera» attraverso transazioni SQL sicure. 
* Al termine della fiera, lo stock rimanente viene ritrasferito.
* **Prima la sicurezza:** Usiamo vincoli `CHECK` a livello di database per assicurare che lo stock fisico non possa **mai** essere negativo.

## 🔗 4. L'ecosistema modulare

SOKO agisce come motore centrale di un ambiente scalabile. La sua architettura di database è pronta a essere utilizzata da future estensioni:

1. **SOKO POS:** Una futura estensione di cassa per consentire ai cassieri di scansionare codici a barre e sottrarre lo stock senza problemi in tempo reale.
2. **Integrazione KURA:** Un futuro modulo in cui ogni articolo contrassegnato come «Sold» in SOKO attiverà automaticamente una registrazione di entrata monetaria nel sistema finanziario KURA, unificando il controllo operativo ed economico.
