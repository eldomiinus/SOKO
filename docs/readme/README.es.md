<div align="center">
    <h1>📦 SOKO</h1>
    <b>Gestión Inteligente y Multi-Inventario para Marcas de Indumentaria</b>
</div>

<div align="center">
    <sub>
        <a href="../../README.md">English</a> · <a href="docs/readme/README.es.md">Español</a> · <a href="docs/readme/README.ru.md">Русский</a> · <a href="docs/readme/README.ja.md">日本語</a> · <a href="docs/readme/README.ko.md">한국어</a> · <a href="docs/readme/README.pt.md">Português</a> · <a href="docs/readme/README.fr.md">Français</a> · <a href="docs/readme/README.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![GitHub last commit](https://img.shields.io/github/last-commit/eldomiinus/SOKO?style=for-the-badge&labelColor=101418&color=9ccbfb)](https://github.com/eldomiinus/SOKO/activity)
[![GitHub Repo Stars](https://img.shields.io/github/stars/eldomiinus/SOKO?style=for-the-badge&labelColor=101418&color=b9c8da)](https://github.com/eldomiinus/SOKO/stargazers)
[![GitHub Repo Size](https://img.shields.io/github/repo-size/eldomiinus/SOKO?style=for-the-badge&labelColor=101418&color=d3bfe6)](https://github.com/eldomiinus/SOKO)
[![Framework](https://img.shields.io/badge/Framework-Electron-101418?style=for-the-badge&logo=electron&logoColor=ffffff&label=Framework&labelColor=101418&color=90C7FF)](https://www.electronjs.org/)
[![DataBase](https://img.shields.io/badge/Database-SQLite_3-101418?style=for-the-badge&logo=Sqlite&logoColor=747474&label=DataBase&labelColor=101418&color=90C7FF)](https://www.sqlite.org/index.html)
[![Ko-Fi Donate](https://img.shields.io/badge/donate-kofi?style=for-the-badge&logo=ko-fi&logoColor=ffffff&label=ko-fi&labelColor=101418&color=f16061)](https://ko-fi.com/eldomiinus)

</div>

> **"El caos del stock tradicional termina aquí."** SOKO es un software de escritorio integral diseñado para marcas emergentes de estilos *alternativos*, showrooms y emprendedores textiles que manejan lanzamientos limitados o *drops*. Permite controlar el ciclo de vida completo de cada prenda mediante un sistema avanzado de variantes, gestionando en tiempo real depósitos, locales y eventos temporales sin perder una sola unidad.

## 📑 Tabla de Contenidos
- [🚀 Características principales](#-características-principales)
- [🏗️ Arquitectura y Tecnologías](#️-arquitectura-y-tecnologías)
- [🔗 El Ecosistema Modular Kyro](#-el-ecosistema-modular-kyro)
- [🗺️ Desarrollo y Progreso](#️-desarrollo-y-progreso)
- [⚙️ Instalación](#️-instalación)
- [📈 Estadísticas](#-estadísticas)

<br>

## 🚀 Características principales

- **🌐 Multi-Inventario Dinámico:** Crea espacios de stock independientes (Local Fijo, Depósito Central, Ferias de fin de semana). Transfiere prendas entre ubicaciones de forma segura mediante transacciones relacionales y, al archivar un evento temporal, devuelve automáticamente los sobrantes al stock central.
- **🧬 Sistema de Variantes (Multi-Nivel):** Configura un "Producto Padre" y desglosa el inventario para cada combinación de *Talle* y *Color* con control de stock individual y preciso.
- **🏷️ Generador de Etiquetas:** Asignación automatizada de SKU por variante y exportación de plantillas PDF listas para imprimir etiquetas físicas con sus respectivos códigos de barras y precios.
- **⚡ Acciones Masivas de Catálogo:** Selecciona múltiples variantes simultáneamente para aplicar aumentos porcentuales de precio o alterar estados operativos (ej. de *En Producción* a *Disponible*) con un solo clic.
- **📒 Directorio de Proveedores Integrado:** Agenda interna vinculada a la ficha técnica para guardar los contactos exactos de los talleres de confección y serigrafía correspondientes a cada lote, vital para agilizar la repetición de producciones exitosas.
- **📉 Reporte de "Stock Estancado" (Dead Stock):** Panel analítico inteligente que detecta prendas inmovilizadas en inventario por más de 60 días, proporcionando la métrica indispensable para planificar liquidaciones o promociones especiales.

<br>

## 🏗️ Arquitectura y Tecnologías

> [!NOTE]
> SOKO está concebido bajo una arquitectura **Offline-First**, priorizando el rendimiento nativo, la portabilidad total (para operar fluidamente en ferias sin conexión a internet) y la privacidad absoluta de los datos locales.

### 💻 Stack Tecnológico

<div align=center>

| Capa | Tecnología | Descripción |
| :--- | :--- | :--- |
| **🎨 Frontend (UI/UX)** | HTML5, CSS3, Vanilla JS | Interfaz estructurada mediante CSS Grid. Diseño *Dark Mode* nativo (estética *cyber/tech*), ventana sin marco (frameless) y paneles colapsables dinámicos. |
| **⚙️ Backend** | Node.js + Electron | Empaquetado de aplicación de escritorio nativa, asegurando alto rendimiento, manejo seguro de ventanas y acceso profundo al sistema de archivos local. |
| **💾 Base de Datos** | SQLite3 | Motor relacional local (archivo único) alojado en `userData`. Soporta transacciones ACID seguras y garantiza portabilidad. |

</div>

### 📂 Flujo de Datos y Almacenamiento
1. **Normalización Relacional:** Separación estricta entre la identidad de la prenda (el catálogo general) y su ubicación física (los inventarios) utilizando tablas puente transaccionales (*Inventory_Stock*), eliminando por completo la duplicación de datos.
2. **Gestión Multimedia Optimizada:** Está terminantemente prohibido almacenar imágenes pesadas (BLOB) en la base de datos. Las fotografías se copian de forma transparente a un directorio local y SQLite únicamente registra las rutas relativas. Esto garantiza que la base de datos mantenga un peso ultra-ligero, garantizando tiempos de respuesta de milisegundos.

<br>

## 🔗 El Ecosistema Modular Kyro

SOKO está diseñado con una arquitectura modular para posicionarse como el núcleo de un entorno de trabajo escalable y a medida, adaptándose al crecimiento operativo y financiero del emprendedor:

- **📦 SOKO (Core):** El motor principal para la administración integral del catálogo, la logística multi-espacio y el control exhaustivo de variantes.
- **🛒 SOKO POS (Extensión de Caja - Próximamente):** Un módulo opcional, independiente y ultraligero diseñado exclusivamente para el uso en mostrador. Integra soporte para escáneres láser de código de barras y cálculo ágil de totales. Actúa como un "cliente ligero" que se conecta a la misma base de datos local SQLite para descontar stock en tiempo real, sin requerir abrir la aplicación principal de administración.
- **📊 KURA (Finanzas - Próximamente):** Plataforma financiera de alto nivel que se sincroniza para recibir automáticamente los ingresos monetarios de las ventas registradas por SOKO/POS, consolidando el control operativo y económico bajo un único flujo automatizado.

<br>

## 🗺️ Desarrollo y Progreso

### 📌 Fases de Planificación y Estructura
- [x] Definición de Arquitectura y Base de Datos relacional ([`SQLite`](https://www.sqlite.org/index.html)).
- [x] Especificación de Requisitos, Flujos de usuario y Multi-Inventario.
- [x] Guía de Diseño UI/UX y Paleta de colores (*Dark Mode* / *Cyber tech*).
- [x] Diseño arquitectónico del Ecosistema Modular Kyro (SOKO, POS y KURA).

### 🎨 Fases de Desarrollo Frontend
- [x] Maquetación de la arquitectura UI base (CSS Grid, 4 zonas funcionales).
- [x] Implementación de comportamiento nativo (Ventana Frameless y Top Bar arrastrable).
- [x] Desarrollo de Sidebar colapsable y Panel de Detalles dinámico (Mockup interactivo).
- [ ] Conexión del frontend con el motor de plantillas/datos de SQLite.

### 💼 Fases de Desarrollo Backend y Lógica
- [x] Configuración del entorno Node.js y dependencias de Electron.
- [x] Compilación de binarios nativos y exclusión de `node_modules` en Git.
- [x] Inicialización automática de la base de datos local (`soko.db`) en el directorio de usuario.
- [ ] Creación del módulo CRUD para "Producto Padre" y el desglose de sus Variantes.
- [ ] Desarrollo del motor transaccional seguro para las transferencias de stock.
- [ ] Implementación de Módulos Auxiliares: Generación de Etiquetas, Acciones Masivas y Detección de Dead Stock.

<br>

## ⚙️ Instalación

Sigue estos pasos para levantar el entorno de SOKO en tu máquina local y comenzar a aportar al desarrollo.

```bash
# 1. Clonar el repositorio oficial
git clone https://github.com/eldomiinus/soko.git

# 2. Acceder al directorio raíz del proyecto
cd soko

# 3. Instalar las dependencias del proyecto
npm install

# 4. Asegurar la correcta compilación de los módulos nativos (SQLite3)
npm rebuild sqlite3

# 5. Ejecutar la aplicación en modo desarrollo
npm start
```

<br>

## 📈 Estadísticas

<a href="https://www.star-history.com/?repos=eldomiinus%2Fsoko&type=date&legend=bottom-right">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&theme=dark&legend=top-left" />
        <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
        <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=eldomiinus/soko&type=date&legend=top-left" />
    </picture>
</a>

<br>

<div align="center">
    <h2>¡Gracias por su atención! <3</h2>
</div>
