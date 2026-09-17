<div align="center">
    <h1>🛠️ Contribuire a SOKO</h1>
    <b>Unisciti a noi per costruire il gestore di inventario definitivo per i marchi di abbigliamento.</b>
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

> Prima di tutto, grazie per aver considerato di contribuire a **SOKO**! Sono sviluppatori, designer e proprietari di marchi come te a rendere la comunità open source un luogo così straordinario in cui imparare e costruire.

<br>

## 🚀 Come puoi contribuire?

* **Segnalare bug:** Hai trovato un problema con la logica multi-inventario o l'UI? Apri una issue e fornisci il maggior contesto possibile (log, screenshot, versione del sistema operativo).
* **Suggerire funzionalità:** Hai idee per il generatore di etichette o l'ecosistema Kyro? Apri una discussione o una issue con l'etichetta `enhancement`.
* **Inviare codice:** Scegli una qualsiasi issue aperta con l'etichetta `good first issue` o `help wanted`, fai fork del repository e inizia a programmare.

## 🛠️ Configurazione di sviluppo

Per eseguire SOKO localmente, assicurati di rispettare la nostra architettura **Offline-First** basata su **Node.js, Electron e SQLite 3**:

1. Fai fork e clona il repository.
2. Esegui `npm install` per ottenere tutte le dipendenze di base.
3. Esegui `npm run rebuild sqlite3` (fondamentale per la compilazione binaria nativa).
4. Avvia l'ambiente di sviluppo con `npm start`.

## 🌿 Processo di Pull Request

* **Crea un branch:** Parti da `main` con un nome descrittivo (ad es., `feature/dark-mode-tweaks` o `fix/stock-transfer`).
* **Comprendi il nucleo:** Leggi i nostri file `AGENTS.md` e `AI_CONTEXT.md` per comprendere pienamente la logica di business, le linee guida UI e il rigore del database prima di scrivere codice.
* **Fai commit puliti:** Scrivi messaggi di commit chiari e concisi.
* **Apri una PR:** Descrivi le modifiche apportate, il problema che risolve e collega tutte le issue correlate. Attendi che i manutentori la esaminino.

## 🎨 Guide di stile e convenzioni

* **Estetica UI/UX:** Qualsiasi aggiunta visiva deve rispettare il *Dark Mode* nativo e l'estetica *cyber/tech* orientata allo streetwear.
* **Integrità del database:** È severamente vietato archiviare immagini pesanti (BLOB) nel database; usa percorsi di file locali. Rispetta sempre i limiti relazionali e `PRAGMA foreign_keys = ON`.
* **Qualità del codice:** Mantieni le funzioni modulari, commenta le tue decisioni strutturali e conserva un'indentazione pulita.
