<div align="center">
    <h1>🛡️ Informativa sulla sicurezza di SOKO</h1>
    <b>Privacy fin dalla progettazione, architettura offline-first e controllo locale dei dati.</b>
</div>

<div align="center">
    <sub>
        <a href="../../../SECURITY.md">English</a> · <a href="SECURITY.es.md">Español</a> · <a href="SECURITY.ru.md">Русский</a> · <a href="SECURITY.ja.md">日本語</a> · <a href="SECURITY.ko.md">한국어</a> · <a href="SECURITY.pt.md">Português</a> · <a href="SECURITY.fr.md">Français</a> · <a href="SECURITY.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![Privacy First - Static](https://img.shields.io/badge/Privacy-First?style=for-the-badge&logo=Shield&label=Data&labelColor=101418&color=99CCFF)](#)
[![Encryption - Static](https://img.shields.io/badge/AES_256-SQLCipher?style=for-the-badge&logo=Lock&label=Encryption&labelColor=101418&color=BBBBDD)](#)

</div>

> **SOKO** considera la privacy dei dati degli utenti una priorità assoluta. Progettato per marchi indipendenti e imprenditori, il nostro modello di sicurezza garantisce che i dati ti appartengano. Non tracciamo, raccogliamo né archiviamo in remoto i dati del tuo inventario senza il tuo consenso esplicito.

<br>

## 🏗️ Architettura di sicurezza e privacy dei dati

La nostra sicurezza si basa su una rigorosa architettura **Offline-First**. Il database SQLite locale garantisce il controllo totale e la privacy assoluta delle tue informazioni senza dipendere da connessioni internet.

### 🔐 Crittografia del database (SQLCipher)
Per proteggere i dati aziendali sensibili dall'accesso locale non autorizzato, SOKO implementa **SQLCipher**. 
* Il file SQLite fisico (`soko.db`) è protetto dagli intrusi tramite password o PIN. 
* Questo livello di crittografia opera in modo trasparente e non altera le regole strutturali del database (come i vincoli `CHECK` progettati per impedire stock negativi).
* **PIN a conoscenza zero:** Il PIN o la password principale che sblocca SQLCipher non viene **mai** salvato nel database. Se un malintenzionato estrae il file `.db`, esso rimane completamente illeggibile senza le tue credenziali.

### 📦 Backup sicuri e file system
Per prevenire la corruzione dei dati e garantire backup rapidi e sicuri, SOKO isola i contenuti multimediali dai dati grezzi.
* **BLOB non consentiti:** Il motore del database salva rigorosamente percorsi di testo (`image_path: TEXT`) e rifiuta l'archiviazione diretta di file pesanti (BLOB) all'interno delle tabelle relazionali.
* **Esportazioni crittografate:** Quando genera un backup, il sistema unifica in modo sicuro il file di database crittografato e la cartella locale delle immagini in un file `.zip` portatile, rendendo semplice e sicura la migrazione dei dati del tuo showroom tra dispositivi.

<br>
<hr>
<br>

## 📢 Segnalazione di una vulnerabilità

Se scopri una vulnerabilità di sicurezza all'interno di SOKO (ad esempio, un exploit nel rendering delle finestre Electron, un problema che aggira il PIN SQLite o una perdita di dati imprevista), **NON** aprire una issue pubblica.

Segnalala invece privatamente al nostro team affinché possiamo affrontarla in modo responsabile:

1. Invia le tue scoperte via e-mail a: **[kyroshop.exe@gmail.com](mailto:kyroshop.exe@gmail.com)**
2. Includi una descrizione dettagliata della vulnerabilità.
3. Fornisci i passaggi per riprodurre il problema (log, versione del sistema operativo o screenshot sono molto apprezzati).

Prendiamo sul serio tutte le segnalazioni di sicurezza e risponderemo il prima possibile per coordinare una patch prima della divulgazione pubblica.

<br>

### 🗃️ Versioni supportate
Attualmente, poiché SOKO è nelle prime fasi di sviluppo, solo il branch `main` e le versioni preliminari più recenti ricevono aggiornamenti di sicurezza.

<div align=center>

| Versione | Supportata         |
| -------- | ------------------ |
| 1.0.x    | ✅ Attiva          |
| < 1.0    | ❌ Non supportata  |

</div>
