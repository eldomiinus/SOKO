<div align="center">
    <h1>🛠️ Contribuindo com o SOKO</h1>
    <b>Junte-se a nós para construir o gerenciador de inventário definitivo para marcas de vestuário.</b>
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

> Antes de tudo, agradecemos por considerar contribuir com o **SOKO**! São desenvolvedores, designers e proprietários de marcas como você que tornam a comunidade de código aberto um lugar tão incrível para aprender e construir.

<br>

## 🚀 Como você pode contribuir?

* **Relatar bugs:** Encontrou um problema com a lógica de multi-inventário ou a UI? Abra uma issue e forneça o máximo de contexto possível (logs, capturas de tela, versão do sistema operacional).
* **Sugerir recursos:** Tem ideias para o gerador de etiquetas ou o ecossistema Kyro? Abra uma discussão ou uma issue com o rótulo `enhancement`.
* **Enviar código:** Escolha qualquer issue aberta com o rótulo `good first issue` ou `help wanted`, faça fork do repositório e comece a programar.

## 🛠️ Configuração de desenvolvimento

Para executar o SOKO localmente, certifique-se de respeitar nossa arquitetura **Offline-First** baseada em **Node.js, Electron e SQLite 3**:

1. Faça fork e clone o repositório.
2. Execute `npm install` para obter todas as dependências básicas.
3. Execute `npm run rebuild sqlite3` (crucial para a compilação binária nativa).
4. Inicie o ambiente de desenvolvimento com `npm start`.

## 🌿 Processo de Pull Request

* **Crie uma branch:** Parta de `main` com um nome descritivo (por exemplo, `feature/dark-mode-tweaks` ou `fix/stock-transfer`).
* **Entenda o núcleo:** Leia nossos arquivos `AGENTS.md` e `AI_CONTEXT.md` para compreender plenamente a lógica de negócio, as diretrizes de UI e o rigor do banco de dados antes de escrever código.
* **Faça commits limpos:** Escreva mensagens de commit claras e concisas.
* **Abra uma PR:** Descreva as alterações feitas, o problema que ela resolve e vincule quaisquer issues relacionadas. Aguarde a revisão dos mantenedores.

## 🎨 Guias de estilo e convenções

* **Estética de UI/UX:** Qualquer adição visual deve respeitar o *Dark Mode* nativo e a estética *cyber/tech* orientada ao streetwear.
* **Integridade do banco de dados:** Armazenar imagens pesadas (BLOBs) no banco de dados é estritamente proibido; use caminhos de arquivos locais. Respeite sempre os limites relacionais e `PRAGMA foreign_keys = ON`.
* **Qualidade do código:** Mantenha as funções modulares, comente suas decisões estruturais e preserve uma indentação limpa.
