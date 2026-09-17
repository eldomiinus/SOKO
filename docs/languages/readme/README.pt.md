<div align="center">
	<h1>📦 SOKO</h1>
	<b>Gestão Inteligente e Multi-Inventário para Marcas de Vestuário</b>
</div>

<div align="center">
	<sub>
		<a href="../../../README.md">English</a> · <a href="README.es.md">Español</a> · <a href="README.ru.md">Русский</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.pt.md">Português</a> · <a href="README.fr.md">Français</a> · <a href="README.it.md">Italiano</a>
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

> **"O caos do estoque tradicional termina aqui."** SOKO é um software desktop completo projetado para marcas emergentes de estilos *alternativos*, showrooms e empreendedores têxteis que trabalham com lançamentos limitados ou *drops*. Permite controlar o ciclo de vida completo de cada peça por meio de um sistema avançado de variantes, gerenciando em tempo real depósitos, lojas e eventos temporários sem perder uma única unidade.

## 📑 Índice
- [🚀 Principais características](#-principais-características)
- [🏗️ Arquitetura e Tecnologias](#️-arquitetura-e-tecnologias)
- [🔗 O Ecossistema Modular Kyro](#-o-ecossistema-modular-kyro)
- [🗺️ Desenvolvimento e Progresso](#️-desenvolvimento-e-progresso)
- [⚙️ Instalação](#️-instalação)
- [📈 Estatísticas](#-estatísticas)

<br>

## 🚀 Principais características

- **🌐 Multi-Inventário Dinâmico:** Crie espaços de estoque independentes (Loja Fixa, Depósito Central, Feiras de fim de semana). Transfira peças entre locais com segurança por meio de transações relacionais e, ao arquivar um evento temporário, devolva automaticamente os excedentes ao estoque central.
- **🧬 Sistema de Variantes (Multi-Nível):** Configure um "Produto Pai" e divida o inventário para cada combinação de *Tamanho* e *Cor* com controle de estoque individual e preciso.
- **🏷️ Gerador de Etiquetas:** Atribuição automatizada de SKU por variante e exportação de modelos PDF prontos para imprimir etiquetas físicas com seus respectivos códigos de barras e preços.
- **⚡ Ações em Massa do Catálogo:** Selecione várias variantes simultaneamente para aplicar aumentos percentuais de preço ou alterar estados operacionais (ex.: de *Em Produção* para *Disponível*) com um único clique.
- **📒 Diretório de Fornecedores Integrado:** Agenda interna vinculada à ficha técnica para armazenar os contatos exatos das oficinas de confecção e serigrafia correspondentes a cada lote, vital para agilizar a repetição de produções bem-sucedidas.
- **📉 Relatório de "Estoque Parado" (Dead Stock):** Painel analítico inteligente que detecta peças paradas no inventário por mais de 60 dias, fornecendo a métrica indispensável para planejar liquidações ou promoções especiais.

<br>

## 🏗️ Arquitetura e Tecnologias

> [!NOTE]
> SOKO foi concebido sob uma arquitetura **Offline-First**, priorizando o desempenho nativo, a portabilidade total (para operar perfeitamente em feiras sem conexão com a internet) e a privacidade absoluta dos dados locais.

### 💻 Stack Tecnológico

<div align=center>

| Camada | Tecnologia | Descrição |
| :--- | :--- | :--- |
| **🎨 Frontend (UI/UX)** | HTML5, CSS3, Vanilla JS | Interface estruturada por meio de CSS Grid. Design *Dark Mode* nativo (estética *cyber/tech*), janela sem moldura (frameless) e painéis dinâmicos recolhíveis. |
| **⚙️ Backend** | Node.js + Electron | Empacotamento de aplicação desktop nativa, garantindo alto desempenho, gerenciamento seguro de janelas e acesso profundo ao sistema de arquivos local. |
| **💾 Base de Dados** | SQLite3 | Motor relacional local (arquivo único) hospedado em `userData`. Suporta transações ACID seguras e garante portabilidade. |

</div>

### 📂 Fluxo de Dados e Armazenamento
1. **Normalização Relacional:** Separação rigorosa entre a identidade da peça (o catálogo geral) e sua localização física (os estoques), utilizando tabelas intermediárias transacionais (*Inventory_Stock*), eliminando completamente a duplicação de dados.
2. **Gestão Multimídia Otimizada:** É terminantemente proibido armazenar imagens pesadas (BLOB) no banco de dados. As fotografias são copiadas de forma transparente para um diretório local e o SQLite registra apenas os caminhos relativos. Isso garante que o banco de dados mantenha um tamanho ultraleve, garantindo tempos de resposta de milissegundos.

<br>

## 🔗 O Ecossistema Modular Kyro

SOKO foi projetado com uma arquitetura modular para se posicionar como o núcleo de um ambiente de trabalho escalável e sob medida, adaptando-se ao crescimento operacional e financeiro do empreendedor:

- **📦 SOKO (Core):** O motor principal para a administração integral do catálogo, da logística multi-espaço e do controle exaustivo de variantes.
- **🛒 SOKO POS (Extensão de Caixa - Em breve):** Um módulo opcional, independente e ultraleve projetado exclusivamente para uso no balcão. Integra suporte para leitores a laser de código de barras e cálculo ágil de totais. Atua como um "cliente leve" que se conecta ao mesmo banco de dados local SQLite para descontar o estoque em tempo real, sem exigir a abertura da aplicação principal de administração.
- **📊 KURA (Finanças - Em breve):** Plataforma financeira de alto nível que se sincroniza para receber automaticamente as receitas monetárias das vendas registradas pelo SOKO/POS, consolidando o controle operacional e econômico sob um único fluxo automatizado.

<br>

## 🗺️ Desenvolvimento e Progresso

### 📌 Fases de Planejamento e Estrutura
- [x] Definição da Arquitetura e do Banco de Dados relacional ([`SQLite`](https://www.sqlite.org/index.html)).
- [x] Especificação de Requisitos, Fluxos de usuário e Multi-Inventário.
- [x] Guia de Design UI/UX e Paleta de cores (*Dark Mode* / *Cyber tech*).
- [x] Projeto arquitetônico do Ecossistema Modular Kyro (SOKO, POS e KURA).

### 🎨 Fases de Desenvolvimento Frontend
- [x] Estruturação da arquitetura UI base (CSS Grid, 4 zonas funcionais).
- [x] Implementação do comportamento nativo (Janela Frameless e Top Bar arrastável).
- [x] Desenvolvimento da Sidebar recolhível e do Painel de Detalhes dinâmico (Mockup interativo).
- [ ] Conexão do frontend com o motor de modelos/dados do SQLite.

### 💼 Fases de Desenvolvimento Backend e Lógica
- [x] Configuração do ambiente Node.js e das dependências do Electron.
- [x] Compilação de binários nativos e exclusão de `node_modules` no Git.
- [x] Inicialização automática do banco de dados local (`soko.db`) no diretório do usuário.
- [ ] Criação do módulo CRUD para "Produto Pai" e a divisão de suas Variantes.
- [ ] Desenvolvimento do motor transacional seguro para as transferências de estoque.
- [ ] Implementação de Módulos Auxiliares: Geração de Etiquetas, Ações em Massa e Detecção de Dead Stock.

<br>

## ⚙️ Instalação

Siga estas etapas para configurar o ambiente do SOKO em sua máquina local e começar a contribuir para o desenvolvimento.

```bash
# 1. Clonar o repositório oficial
git clone https://github.com/eldomiinus/soko.git

# 2. Acessar o diretório raiz do projeto
cd soko

# 3. Instalar as dependências do projeto
npm install

# 4. Garantir a compilação correta dos módulos nativos (SQLite3)
npm rebuild sqlite3

# 5. Executar a aplicação em modo de desenvolvimento
npm start
```

<br>

## 📈 Estatísticas

<div align=center>
<a href="https://www.star-history.com/?repos=eldomiinus%2Fsoko&type=date&legend=bottom-right">
	<picture>
		<source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&theme=dark&legend=top-left" />
		<source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
		<img alt="Gráfico do histórico de estrelas" src="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
	</picture>
</a>
</div>

<br>

<div align="center">

<h2>¡Obrigado pela atenção! <3</h2>

[![GitHub License - Static](https://img.shields.io/badge/MIT-License?style=for-the-badge&logo=GitBook&label=License&labelColor=101418&color=BBBBDD)](https://github.com/eldomiinus/SOKO?tab=License-1-ov-file)

</div>
