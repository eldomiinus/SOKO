<div align="center">
	<h1>📦 SOKO</h1>
	<b>Gestione Intelligente e Multi-Inventario per Brand di Abbigliamento</b>
</div>

<div align="center">
	<sub>
		<a href="../../README.md">English</a> · <a href="docs/locales/README.es.md">Español</a> · <a href="docs/locales/README.ru.md">Русский</a> · <a href="docs/locales/README.ja.md">日本語</a> · <a href="docs/locales/README.ko.md">한국어</a> · <a href="docs/locales/README.pt.md">Português</a> · <a href="docs/locales/README.fr.md">Français</a> · <a href="docs/locales/README.it.md">Italiano</a>
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

> **"Il caos dello stock tradizionale finisce qui."** SOKO è un software desktop completo progettato per brand emergenti dagli stili *alternativi*, showroom e imprenditori tessili che gestiscono lanci limitati o *drop*. Consente di controllare l'intero ciclo di vita di ogni capo attraverso un sistema avanzato di varianti, gestendo in tempo reale depositi, negozi ed eventi temporanei senza perdere una sola unità.

## 📑 Indice
- [🚀 Caratteristiche principali](#-caratteristiche-principali)
- [🏗️ Architettura e Tecnologie](#️-architettura-e-tecnologie)
- [🔗 L'Ecosistema Modulare Kyro](#-l'ecosistema-modulare-kyro)
- [🗺️ Sviluppo e Progressi](#️-sviluppo-e-progressi)
- [⚙️ Installazione](#️-installazione)
- [📈 Statistiche](#-statistiche)

<br>

## 🚀 Caratteristiche principali

- **🌐 Multi-Inventario Dinamico:** Crea spazi di stock indipendenti (Negozio Fisso, Deposito Centrale, Fiere del fine settimana). Trasferisci i capi tra le ubicazioni in modo sicuro mediante transazioni relazionali e, quando archivi un evento temporaneo, restituisce automaticamente le eccedenze allo stock centrale.
- **🧬 Sistema di Varianti (Multi-Livello):** Configura un "Prodotto Padre" e suddividi l'inventario per ogni combinazione di *Taglia* e *Colore* con un controllo dello stock individuale e preciso.
- **🏷️ Generatore di Etichette:** Assegnazione automatizzata dello SKU per variante ed esportazione di modelli PDF pronti per stampare etichette fisiche con i relativi codici a barre e prezzi.
- **⚡ Azioni Massive del Catalogo:** Seleziona più varianti contemporaneamente per applicare aumenti percentuali di prezzo o modificare gli stati operativi (es. da *In Produzione* a *Disponibile*) con un solo clic.
- **📒 Elenco Fornitori Integrato:** Agenda interna collegata alla scheda tecnica per salvare i contatti esatti dei laboratori di confezione e serigrafia corrispondenti a ogni lotto, fondamentale per velocizzare la ripetizione delle produzioni di successo.
- **📉 Report di "Stock Inutilizzato" (Dead Stock):** Pannello analitico intelligente che rileva i capi immobilizzati nell'inventario da più di 60 giorni, fornendo la metrica indispensabile per pianificare liquidazioni o promozioni speciali.

<br>

## 🏗️ Architettura e Tecnologie

> [!NOTE]
> SOKO è concepito secondo un'architettura **Offline-First**, dando priorità alle prestazioni native, alla portabilità totale (per operare fluidamente nelle fiere senza connessione internet) e alla privacy assoluta dei dati locali.

### 💻 Stack Tecnologico

<div align=center>

| Livello | Tecnologia | Descrizione |
| :--- | :--- | :--- |
| **🎨 Frontend (UI/UX)** | HTML5, CSS3, Vanilla JS | Interfaccia strutturata tramite CSS Grid. Design *Dark Mode* nativo (estetica *cyber/tech*), finestra senza cornice (frameless) e pannelli dinamici richiudibili. |
| **⚙️ Backend** | Node.js + Electron | Pacchettizzazione di un'applicazione desktop nativa, assicurando alte prestazioni, gestione sicura delle finestre e accesso profondo al file system locale. |
| **💾 Database** | SQLite3 | Motore relazionale locale (file unico) ospitato in `userData`. Supporta transazioni ACID sicure e garantisce la portabilità. |

</div>

### 📂 Flusso dei Dati e Archiviazione
1. **Normalizzazione Relazionale:** Separazione rigorosa tra l'identità del capo (il catalogo generale) e la sua ubicazione fisica (gli inventari) utilizzando tabelle ponte transazionali (*Inventory_Stock*), eliminando completamente la duplicazione dei dati.
2. **Gestione Multimediale Ottimizzata:** È severamente vietato archiviare immagini pesanti (BLOB) nel database. Le fotografie vengono copiate in modo trasparente in una directory locale e SQLite registra esclusivamente i percorsi relativi. Ciò garantisce che il database mantenga un peso ultra-leggero, assicurando tempi di risposta di pochi millisecondi.

<br>

## 🔗 L'Ecosistema Modulare Kyro

SOKO è progettato con un'architettura modulare per posizionarsi come il nucleo di un ambiente di lavoro scalabile e su misura, adattandosi alla crescita operativa e finanziaria dell'imprenditore:

- **📦 SOKO (Core):** Il motore principale per la gestione completa del catalogo, della logistica multi-spazio e del controllo esaustivo delle varianti.
- **🛒 SOKO POS (Estensione Cassa - Prossimamente):** Un modulo opzionale, indipendente e ultraleggero progettato esclusivamente per l'uso al banco. Integra il supporto per scanner laser di codici a barre e il calcolo rapido dei totali. Agisce come un "client leggero" che si connette allo stesso database locale SQLite per scaricare lo stock in tempo reale, senza richiedere l'apertura dell'applicazione principale di amministrazione.
- **📊 KURA (Finanze - Prossimamente):** Piattaforma finanziaria di alto livello che si sincronizza per ricevere automaticamente gli introiti monetari delle vendite registrate da SOKO/POS, consolidando il controllo operativo ed economico in un unico flusso automatizzato.

<br>

## 🗺️ Sviluppo e Progressi

### 📌 Fasi di Pianificazione e Struttura
- [x] Definizione dell'Architettura e del Database relazionale ([`SQLite`](https://www.sqlite.org/index.html)).
- [x] Specifica dei Requisiti, dei Flussi utente e del Multi-Inventario.
- [x] Guida al Design UI/UX e alla Palette di colori (*Dark Mode* / *Cyber tech*).
- [x] Progettazione architettonica dell'Ecosistema Modulare Kyro (SOKO, POS e KURA).

### 🎨 Fasi di Sviluppo Frontend
- [x] Progettazione dell'architettura UI di base (CSS Grid, 4 zone funzionali).
- [x] Implementazione del comportamento nativo (Finestra Frameless e Top Bar trascinabile).
- [x] Sviluppo della Sidebar richiudibile e del Pannello Dettagli dinamico (Mockup interattivo).
- [ ] Connessione del frontend al motore di template/dati di SQLite.

### 💼 Fasi di Sviluppo Backend e Logica
- [x] Configurazione dell'ambiente Node.js e delle dipendenze di Electron.
- [x] Compilazione dei binari nativi ed esclusione di `node_modules` da Git.
- [x] Inizializzazione automatica del database locale (`soko.db`) nella directory dell'utente.
- [ ] Creazione del modulo CRUD per il "Prodotto Padre" e la suddivisione delle sue Varianti.
- [ ] Sviluppo del motore transazionale sicuro per i trasferimenti di stock.
- [ ] Implementazione dei Moduli Ausiliari: Generazione di Etichette, Azioni Massive e Rilevamento del Dead Stock.

<br>

## ⚙️ Installazione

Segui questi passaggi per avviare l'ambiente di SOKO sulla tua macchina locale e iniziare a contribuire allo sviluppo.

```bash
# 1. Clonare il repository ufficiale
git clone https://github.com/eldomiinus/soko.git

# 2. Accedere alla directory principale del progetto
cd soko

# 3. Installare le dipendenze del progetto
npm install

# 4. Assicurare la corretta compilazione dei moduli nativi (SQLite3)
npm rebuild sqlite3

# 5. Eseguire l'applicazione in modalità sviluppo
npm start
```

<br>

## 📈 Statistiche

<div align=center>
<a href="https://www.star-history.com/?repos=eldomiinus%2Fsoko&type=date&legend=bottom-right">
	<picture>
		<source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&theme=dark&legend=top-left" />
		<source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
		<img alt="Grafico della cronologia delle stelle" src="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
	</picture>
</a>
</div>

<br>

<div align="center">

<h2>¡Grazie per l'attenzione! <3</h2>

[![GitHub License - Dynamic](https://img.shields.io/github/license/eldomiinus/soko?style=for-the-badge&logo=GitBook&label=License&labelColor=101418&color=BBBBDD)](https://github.com/eldomiinus/SOKO?tab=MIT-1-ov-file)

</div>
