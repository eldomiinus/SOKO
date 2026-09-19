<div align="center">
    <h1>⚙️ Arquitetura do SOKO</h1>
    <b>A base técnica do nosso ecossistema Offline-First.</b>
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

> **SOKO** é desenvolvido como um aplicativo de desktop nativo, projetado para garantir desempenho nativo, privacidade absoluta dos dados e plena operacionalidade durante feiras temporárias sem depender de uma conexão com a internet. Este documento descreve como o Frontend, o Backend e o Banco de Dados interagem nesse ambiente.

<br>

## 🖥️ 1. O modelo de comunicação IPC do Electron

Como o SOKO é empacotado com **Electron**, mantemos uma separação rigorosa de responsabilidades entre a interface do usuário e os recursos do sistema para segurança e desempenho:

* **Frontend (processo Renderer):** Construído com HTML5, CSS3 (Grid) e Vanilla JS. Ele lida com UI/UX, animações e captura entradas do usuário. **Ele nunca acessa o banco de dados diretamente.**
* **Ponte IPC (Context Bridge):** Usamos o `preload.js` do Electron para expor uma API segura ao frontend.
* **Backend (processo Main):** É executado no Node.js. Ele escuta os canais IPC enviados pelo Frontend, executa as operações lógicas pesadas, lê/grava no sistema de arquivos local e consulta o banco de dados SQLite.

## 💾 2. Mecanismo de banco de dados e sistema de arquivos

O núcleo do nosso armazenamento de dados depende de um modelo relacional usando **SQLite 3**. Aplicamos regras técnicas rigorosas para manter o aplicativo extremamente rápido:

### A regra «Sem BLOBs»
O uso de campos BLOB para armazenar imagens dentro do banco de dados é estritamente proibido. Armazenar mídia pesada diretamente no SQLite causa grande inchaço do banco de dados e degradação de desempenho.
* **Como lidamos com isso:** O backend salva os arquivos de imagem físicos em uma árvore de diretórios local (por exemplo, `/assets/images/catalog/`).
* O banco de dados armazena apenas a sequência de texto do caminho local (`image_path: TEXT`) que aponta para esse arquivo.

### Integridade e configurações dos dados
* **Relações rigorosas:** Aplicamos explicitamente `PRAGMA foreign_keys = ON;` em cada conexão para garantir a integridade dos dados entre fornecedores, produtos e inventários.
* **Configurações do aplicativo:** As preferências do sistema (como estado do modo escuro ou data do último backup) são isoladas em uma tabela `App_Settings` separada para evitar poluir os dados transacionais de inventário.

## 📦 3. Lógica de multi-inventário (a ponte)

O recurso definidor do SOKO é sua capacidade de gerenciar vários locais físicos simultaneamente (por exemplo, armazém central, lojas pop-up, feiras). 

Os locais são categorizados por sua natureza (`type`): *Fijo* (Fixed), *Temporal* (Temporary) ou *Transito* (In-Transit).

### A ponte transacional

Evitamos entradas duplicadas de produtos usando uma tabela de ponte chamada `Inventory_Stock`. 
* Quando o estoque é movido para uma feira de fim de semana, o sistema deduz nativamente as unidades do «armazém central» e as atribui ao inventário da «feira» por meio de transações SQL seguras. 
* Quando a feira termina, o estoque restante é transferido de volta.
* **Segurança em primeiro lugar:** Usamos restrições `CHECK` no nível do banco de dados para garantir que o estoque físico **nunca** seja negativo.

## 🔗 4. O ecossistema modular

O SOKO atua como o mecanismo central de um ambiente escalável. Sua arquitetura de banco de dados está preparada para ser consumida por futuras extensões:

1. **SOKO POS:** Uma futura extensão de checkout para que caixas escaneiem códigos de barras e deduzam o estoque de forma integrada em tempo real.
2. **Integração com KURA:** Um futuro módulo em que cada item marcado como «Sold» no SOKO acionará automaticamente um registro de receita monetária no sistema financeiro KURA, unificando o controle operacional e econômico.
