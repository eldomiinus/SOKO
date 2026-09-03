# SOKO 📦
> **Dynamic inventory manager for textile products.**

SOKO es un software de escritorio híbrido diseñado para revolucionar la gestión de inventario en marcas de indumentaria independientes, showrooms y emprendedores textiles. Permite un control absoluto del ciclo de vida del producto a través de un sistema avanzado de variantes y gestión multi-inventario.

---

## ⚡ Core Features

* **Gestión Multi-Inventario Dinámica:** Crea y administra múltiples espacios de stock (Local Fijo, Depósito, Ferias o Pop-ups). Transfiere mercadería entre ubicaciones sin duplicar datos mediante transacciones seguras (ACID).
* **Catálogo por Variantes (Multi-nivel):** Olvídate del caos de las planillas. Define un "Producto Padre" y administra el stock individual de sus combinaciones de Talle y Color de forma visual.
* **Máquina de Estados de Producto:** Seguimiento en tiempo real: *En Producción ➔ Disponible ➔ Reservado ➔ Vendido*.
* **Fichas Técnicas Integradas:** Almacena metadatos cruciales de fabricación (tipo de tejido, técnica de estampa, proveedor).
* **Ecosistema Preparado:** Diseñado con una arquitectura lista para integrarse a futuro con **KURA** (Software de Gestión Financiera).

## 🛠️ Stack Tecnológico

El proyecto está diseñado para funcionar como una aplicación de escritorio nativa, priorizando la privacidad de los datos locales (Offline-first) y el alto rendimiento.

* **Frontend / UI:** HTML5, CSS3 (Arquitectura Dark Mode nativa inspirada en estética técnica/cyber).
* **Backend / Lógica:** *[A definir: Python / Rust (Tauri) / Node.js (Electron)]*
* **Base de Datos:** SQLite (Relacional). Archivo local único y encriptable.

## 📂 Estructura del Proyecto (Roadmap)

- [x] Definición de Arquitectura y Base de Datos relacional.
- [x] Especificación de Requisitos y Flujos de usuario.
- [x] Guía de Diseño UI/UX y Paleta de colores.
- [ ] Maquetación del Dashboard Principal (Frontend).
- [ ] Inicialización de Base de Datos SQLite.
- [ ] Desarrollo de módulo de transferencia de stock.

## 💻 Instalación y Uso (Desarrollo)

*(Instrucciones de instalación del entorno de desarrollo próximamente)*

```bash
# Clonar el repositorio
git clone [https://github.com/eldomiinus/SOKO.git](https://github.com/eldomiinus/SOKO.git)

# Entrar al directorio
cd SOKO