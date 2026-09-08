<div align="center">
    <h1>📦 SOKO</h1>
    <h2>Gestión Inteligente y Multi-Inventario para Marcas de Indumentaria</h2>
</div>

<div align="center">
    <img src="https://img.shields.io/badge/Status-En%20Desarrollo-orange?style=for-the-badge" alt="Status">
    <img src="https://img.shields.io/badge/Database-SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white" alt="SQLite">
    <img src="https://img.shields.io/badge/Architecture-Offline_First-111111?style=for-the-badge" alt="Offline First">
    <img src="https://img.shields.io/badge/Ecosystem-Kyro-8A2BE2?style=for-the-badge" alt="Ecosistema Kyro">
</div>

> **"El caos del stock tradicional termina aquí."** SOKO es un software de escritorio integral diseñado para marcas emergentes de estilos *alternativos*, showrooms y emprendedores textiles que manejan lanzamientos limitados o *drops*. Permite controlar el ciclo de vida completo de cada prenda mediante un sistema avanzado de variantes, gestionando en tiempo real depósitos, locales y eventos temporales sin perder una sola unidad.

## 📑 Tabla de Contenidos
- [🚀 Core Features](#-core-features)
- [🏗️ Arquitectura y Tecnologías](#️-arquitectura-y-tecnologías)
- [🔗 El Ecosistema Modular Kyro](#-el-ecosistema-modular-kyro)
- [🗺️ Roadmap y Progreso](#️-roadmap-y-progreso)
- [⚙️ Instalación y Uso](#️-instalación-y-uso)

## 🚀 Core Features

- **🌐 Multi-Inventario Dinámico:** Crea espacios de stock independientes (Local Fijo, Depósito Central, Ferias de fin de semana). Transfiere prendas entre ubicaciones de forma segura mediante transacciones relacionales y, al archivar un evento temporal, devuelve automáticamente los sobrantes al stock central.
- **🧬 Sistema de Variantes (Multi-Nivel):** Configura un "Producto Padre" y desglosa el inventario para cada combinación de *Talle* y *Color* con control de stock individual y preciso.
- **🏷️ Generador de Etiquetas:** Asignación automatizada de SKU por variante y exportación de plantillas PDF listas para imprimir etiquetas físicas con sus respectivos códigos de barras y precios.
- **⚡ Acciones Masivas de Catálogo:** Selecciona múltiples variantes simultáneamente para aplicar aumentos porcentuales de precio o alterar estados operativos (ej. de *En Producción* a *Disponible*) con un solo clic.
- **📒 Directorio de Proveedores Integrado:** Agenda interna vinculada a la ficha técnica para guardar los contactos exactos de los talleres de confección y serigrafía correspondientes a cada lote, vital para agilizar la repetición de producciones exitosas.
- **📉 Reporte de "Stock Estancado" (Dead Stock):** Panel analítico inteligente que detecta prendas inmovilizadas en inventario por más de 60 días, proporcionando la métrica indispensable para planificar liquidaciones o promociones especiales.

---

## 🏗️ Arquitectura y Tecnologías

SOKO está concebido bajo una arquitectura **Offline-First**, priorizando el rendimiento nativo, la portabilidad total (para operar fluidamente en ferias sin conexión a internet) y la privacidad absoluta de los datos locales.

### 💻 Stack Tecnológico

| Capa | Tecnología | Descripción |
| :--- | :--- | :--- |
| **🎨 Frontend (UI/UX)** | HTML5, CSS3, JS | Interfaz estructurada en cuadrículas (*grids*). Diseño *Dark Mode* nativo con estética técnica, limpia y *cyber*. |
| **⚙️ Backend** | *A definir (Tauri/Electron)* | Empaquetado de aplicación de escritorio híbrida, asegurando alto rendimiento y acceso profundo al sistema de archivos local. |
| **💾 Base de Datos** | SQLite | Motor relacional local (archivo único) *serverless*. Soporta transacciones ACID seguras. |

### 📂 Flujo de Datos y Almacenamiento
1. **Normalización Relacional:** Separación estricta entre la identidad de la prenda (el catálogo general) y su ubicación física (los inventarios) utilizando tablas puente transaccionales (*Inventory_Stock*), eliminando por completo la duplicación de datos.
2. **Gestión Multimedia Optimizada:** Está terminantemente prohibido almacenar imágenes pesadas (BLOB) en la base de datos. Las fotografías se copian de forma transparente a un directorio local y SQLite únicamente registra las rutas relativas. Esto garantiza que la base de datos mantenga un peso ultra-ligero (inferior a 15 MB), garantizando tiempos de respuesta de milisegundos.

---

## 🔗 El Ecosistema Modular Kyro

SOKO está diseñado con una arquitectura modular para posicionarse como el núcleo de un entorno de trabajo escalable y a medida, adaptándose al crecimiento operativo y financiero del emprendedor:

- **📦 SOKO (Core):** El motor principal para la administración integral del catálogo, la logística multi-espacio y el control exhaustivo de variantes.
- **🛒 SOKO POS (Extensión de Caja - Próximamente):** Un módulo opcional, independiente y ultraligero diseñado exclusivamente para el uso en mostrador. Integra soporte para escáneres láser de código de barras y cálculo ágil de totales. Actúa como un "cliente ligero" que se conecta a la misma base de datos local SQLite para descontar stock en tiempo real, sin requerir abrir la aplicación principal de administración.
- **📊 KURA (Finanzas - Próximamente):** Plataforma financiera de alto nivel que se sincroniza para recibir automáticamente los ingresos monetarios de las ventas registradas por SOKO/POS, consolidando el control operativo y económico bajo un único flujo automatizado.

---

## 🗺️ Roadmap y Progreso

### 📌 Fases de Planificación y Estructura
- [x] Definición de Arquitectura y Base de Datos relacional (SQLite).
- [x] Especificación de Requisitos, Flujos de usuario y Multi-Inventario.
- [x] Guía de Diseño UI/UX y Paleta de colores (*Dark Mode* / *Cyber tech*).
- [x] Diseño arquitectónico del Ecosistema Modular Kyro (SOKO, POS y KURA).

### 🎨 Fases de Desarrollo Frontend
- [ ] Maquetación del Dashboard Principal (HTML/CSS).
- [ ] Desarrollo de componentes visuales (Grids, Tablas de datos y Panel de Alertas).
- [ ] Integración de la interfaz con los controladores lógicos.

### ⚙️ Fases de Desarrollo Backend y Lógica
- [ ] Inicialización del archivo de Base de Datos local y migración de tablas principales (*Products_Variants*, *Inventories*, *Inventory_Stock*).
- [ ] Creación del módulo CRUD para "Producto Padre" y el desglose de sus Variantes.
- [ ] Desarrollo del motor transaccional seguro para las transferencias de stock.
- [ ] Implementación de Módulos Auxiliares: Generación de Etiquetas, Acciones Masivas y Detección de Dead Stock.

---

## ⚙️ Instalación y Uso

Sigue estos pasos para levantar el entorno de SOKO en tu máquina local y comenzar a aportar al desarrollo.

```bash
# 1. Clonar el repositorio oficial
git clone [https://github.com/eldomiinus/SOKO.git](https://github.com/eldomiinus/SOKO.git)

# 2. Acceder al directorio raíz del proyecto
cd SOKO

# 3. Instalar las dependencias del proyecto (Ejemplo basado en entorno Node.js)
npm install

# 4. Inicializar y migrar la base de datos local SQLite
npm run db:init

# 5. Ejecutar la aplicación en modo desarrollo
npm run dev
```

---

<div align="center">
    <h2>Gracias por su atención! <3</h2>
</div>