<div align="center">
    <h1>🛡️ Política de segurança do SOKO</h1>
    <b>Privacidade desde a concepção, arquitetura offline-first e controle local de dados.</b>
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

> **SOKO** trata a privacidade dos dados dos usuários como uma prioridade absoluta. Projetado para marcas independentes e empreendedores, nosso modelo de segurança garante que você é o proprietário dos seus dados. Não rastreamos, coletamos nem armazenamos remotamente os dados do seu inventário sem seu consentimento explícito.

<br>

## 🏗️ Arquitetura de segurança e privacidade de dados

Nossa segurança se baseia em uma rigorosa arquitetura **Offline-First**. O banco de dados SQLite local garante controle total e privacidade absoluta das suas informações sem depender de conexões com a internet.

### 🔐 Criptografia do banco de dados (SQLCipher)
Para proteger os dados confidenciais da sua empresa contra acesso local não autorizado, o SOKO implementa **SQLCipher**. 
* O arquivo SQLite físico (`soko.db`) é protegido contra invasores por meio de uma senha ou PIN. 
* Esta camada de criptografia opera de forma transparente e não altera as regras estruturais do banco de dados (como as restrições `CHECK` projetadas para impedir estoque negativo).
* **PIN de conhecimento zero:** O PIN ou senha mestra que desbloqueia o SQLCipher **nunca** é salvo dentro do banco de dados. Se um agente mal-intencionado extrair o arquivo `.db`, ele permanecerá completamente ilegível sem suas credenciais.

### 📦 Backups seguros e sistema de arquivos
Para evitar a corrupção de dados e garantir backups rápidos e seguros, o SOKO isola mídias dos dados brutos.
* **BLOBs não permitidos:** O mecanismo de banco de dados salva estritamente caminhos de texto (`image_path: TEXT`) e rejeita o armazenamento direto de arquivos pesados (BLOBs) dentro das tabelas relacionais.
* **Exportações criptografadas:** Ao gerar um backup, o sistema une com segurança o arquivo de banco de dados criptografado e a pasta local de imagens em um arquivo `.zip` portátil, tornando simples e segura a migração dos dados do seu showroom entre dispositivos.

<br>
<hr>
<br>

## 📢 Relatando uma vulnerabilidade

Se você descobrir uma vulnerabilidade de segurança no SOKO (por exemplo, um exploit na renderização de janelas do Electron, um problema que contorne o PIN do SQLite ou um vazamento inesperado de dados), **NÃO** abra uma issue pública.

Em vez disso, relate-a de forma privada à nossa equipe para que possamos resolvê-la com responsabilidade:

1. Envie suas descobertas por e-mail para: **[kyroshop.exe@gmail.com](mailto:kyroshop.exe@gmail.com)**
2. Inclua uma descrição detalhada da vulnerabilidade.
3. Forneça etapas para reproduzir o problema (logs, versão do sistema operacional ou capturas de tela são muito apreciados).

Levamos todos os relatos de segurança a sério e responderemos o mais rápido possível para coordenar uma correção antes da divulgação pública.

<br>

### 🗃️ Versões compatíveis
Atualmente, como o SOKO está em seus estágios iniciais de desenvolvimento, apenas o branch `main` e as versões de pré-lançamento mais recentes recebem atualizações de segurança.

<div align=center>

| Versão | Compatível         |
| ------- | ------------------ |
| 1.0.x   | ✅ Ativa           |
| < 1.0   | ❌ Não compatível  |

</div>
