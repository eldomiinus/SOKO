<div align="center">
    <h1>🗄️ Esquema de banco de dados do SOKO</h1>
    <b>Arquitetura relacional, integridade de dados e regras de armazenamento local.</b>
</div>

<div align="center">
    <sub>
        <a href="../DATABASE.md">English</a> · <a href="DATABASE.es.md">Español</a> · <a href="DATABASE.ru.md">Русский</a> · <a href="DATABASE.ja.md">日本語</a> · <a href="DATABASE.ko.md">한국어</a> · <a href="DATABASE.pt.md">Português</a> · <a href="DATABASE.fr.md">Français</a> · <a href="DATABASE.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![SQLite - Static](https://img.shields.io/badge/SQLite_3-Database?style=for-the-badge&logo=SQLite&logoColor=FFFFFF&label=Engine&labelColor=101418&color=99CCFF)](#)
[![Integrity - Static](https://img.shields.io/badge/Strict-Integrity?style=for-the-badge&logo=Databricks&label=Relations&labelColor=101418&color=BBBBDD)](#)

</div>

> Este documento detalha a estrutura exata, as restrições e a lógica de negócio do banco de dados local do SOKO. Utilizamos um modelo estritamente relacional para garantir a consistência dos dados em vários inventários sem depender da sincronização em nuvem.

<br>

## ⚙️ Regras técnicas principais

Antes de interagir com o esquema ou modificá-lo, os desenvolvedores devem aderir aos seguintes princípios:

* **Chaves estrangeiras rigorosas:** Aplicamos explicitamente `PRAGMA foreign_keys = ON;` em cada conexão. Nenhum registro órfão é permitido.
* **BLOBs não permitidos:** Armazenar arquivos de mídia diretamente no banco de dados é estritamente proibido para manter velocidades de consulta em milissegundos. Salve imagens no sistema de arquivos local e armazene apenas o caminho de texto (`image_path`).
* **Sem estoque negativo:** O estoque físico não pode cair abaixo de zero. Consultas transacionais devem se basear em restrições `CHECK (quantity >= 0)` no nível do banco de dados.

<br>

## 📑 Dicionário de dados

### 1. `Suppliers` (diretório)
Registra fabricantes, fornecedores têxteis e oficinas de serigrafia para futuros reabastecimentos.

| Campo | Tipo | Regras e descrição |
| :--- | :--- | :--- |
| `id` | INTEGER | Chave primária. Auto-incremental. |
| `name` | TEXT | **NOT NULL.** Nome do fornecedor/oficina. |
| `contact_info` | TEXT | Telefone, e-mail ou endereço físico. |
| `service_type` | TEXT | Ex.: costura, serigrafia, fornecedor de tecidos. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 2. `Products_Variants` (catálogo central)
Define a identidade imutável de cada peça. **Não armazena quantidades de estoque.**

| Campo | Tipo | Regras e descrição |
| :--- | :--- | :--- |
| `id` | INTEGER | Chave primária. Auto-incremental. |
| `sku` | TEXT | **UNIQUE. NOT NULL.** Ex.: `PANT-BAGGY-38-BLU`. |
| `parent_name` | TEXT | **NOT NULL.** Nome do modelo-base (ex.: calças paraquedas). |
| `category` | TEXT | **NOT NULL.** Para filtragem (calças, camisetas, moletons). |
| `fit` | TEXT | Corte da peça (Baggy, Oversized, Slim, Regular). |
| `size` | TEXT | **NOT NULL.** Tamanho físico (S, M, L, XL, 38, 40). |
| `color` | TEXT | **NOT NULL.** Cor dominante ou variante de estampa. |
| `fabric` | TEXT | Composição têxtil (ex.: Denim 12oz). |
| `supplier_id` | INTEGER | **Chave estrangeira** vinculada a `Suppliers(id)`. |
| `status` | TEXT | `AVAILABLE`, `IN_PRODUCTION`, `RESERVED`, `ARCHIVED`. |
| `cost_price` | DECIMAL | Custo unitário de fabricação (crucial para módulos financeiros). |
| `sale_price` | DECIMAL | Preço final de varejo. |
| `barcode` | TEXT | **UNIQUE.** Código EAN/UPC para leitores a laser. |
| `image_path` | TEXT | Caminho local absoluto/relativo para o arquivo `.jpg/.png`. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 3. `Inventories` (localizações)
Gerencia os espaços físicos ou lógicos onde o SOKO armazena mercadorias.

| Campo | Tipo | Regras e descrição |
| :--- | :--- | :--- |
| `id` | INTEGER | Chave primária. Auto-incremental. |
| `name` | TEXT | **NOT NULL.** Ex.: armazém central, feira de Palermo. |
| `type` | TEXT | Natureza do espaço: `Fijo` (Fixed), `Temporal`, `Transito`. |
| `is_active` | BOOLEAN | `1` = Ativo, `0` = Arquivado/Fechado. |
| `created_at` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. |

### 4. `Inventory_Stock` (a ponte transacional)
A tabela central que habilita a lógica de multi-inventário. Ela vincula uma variante específica de produto a uma localização específica e acompanha sua quantidade em tempo real.

| Campo | Tipo | Regras e descrição |
| :--- | :--- | :--- |
| `inventory_id` | INTEGER | **Chave estrangeira** vinculada a `Inventories(id)`. |
| `variant_id` | INTEGER | **Chave estrangeira** vinculada a `Products_Variants(id)`. |
| `quantity` | INTEGER | **NOT NULL.** `DEFAULT 0`. Restrição: `CHECK (quantity >= 0)`. |
| `last_updated` | TIMESTAMP | `DEFAULT CURRENT_TIMESTAMP`. Crucial para relatórios de Dead Stock. |

> **Nota:** A chave primária de `Inventory_Stock` é composta por `(inventory_id, variant_id)` para impedir registros de variantes duplicados na mesma localização.

### 5. `App_Settings` (preferências do sistema)
Tabela isolada para preferências locais do aplicativo, mantendo-as estritamente separadas dos dados operacionais de inventário.

| Campo | Tipo | Regras e descrição |
| :--- | :--- | :--- |
| `id` | INTEGER | Chave primária. |
| `theme` | TEXT | Ex.: `dark`, `light`, `system`. |
| `last_backup` | TIMESTAMP | Registra a data e hora exatas da última exportação `.zip`. |
