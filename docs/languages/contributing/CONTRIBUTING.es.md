<div align="center">
    <h1>🛠️ Contribuir a SOKO</h1>
    <b>Únete a nosotros para construir el gestor de inventario definitivo para marcas de indumentaria.</b>
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

> Antes que nada, ¡gracias por considerar contribuir a **SOKO**! Son desarrolladores, diseñadores y propietarios de marcas como tú quienes hacen de la comunidad de código abierto un lugar tan increíble para aprender y construir.

<br>

## 🚀 ¿Cómo puedes contribuir?

* **Reportar errores:** ¿Encontraste un problema con la lógica de multiinventario o la UI? Abre un issue y proporciona todo el contexto posible (registros, capturas de pantalla, versión del SO).
* **Sugerir funcionalidades:** ¿Tienes ideas para el generador de etiquetas o el ecosistema Kyro? Abre una discusión o un issue con la etiqueta `enhancement`.
* **Enviar código:** Elige cualquier issue abierto con la etiqueta `good first issue` o `help wanted`, haz fork del repositorio y comienza a programar.

## 🛠️ Configuración de desarrollo

Para ejecutar SOKO localmente, asegúrate de respetar nuestra arquitectura **Offline-First** impulsada por **Node.js, Electron y SQLite 3**:

1. Haz fork y clona el repositorio.
2. Ejecuta `npm install` para obtener todas las dependencias base.
3. Ejecuta `npm run rebuild sqlite3` (crucial para la compilación binaria nativa).
4. Inicia el entorno de desarrollo con `npm start`.

## 🌿 Proceso de Pull Request

* **Crea una rama:** Parte de `main` con un nombre descriptivo (p. ej., `feature/dark-mode-tweaks` o `fix/stock-transfer`).
* **Comprende el núcleo:** Lee nuestros archivos `AGENTS.md` y `AI_CONTEXT.md` para comprender plenamente la lógica de negocio, las pautas de UI y la rigurosidad de la base de datos antes de escribir código.
* **Haz commits limpios:** Escribe mensajes de commit claros y concisos.
* **Abre una PR:** Describe los cambios realizados, el problema que resuelve y enlaza cualquier issue relacionado. Espera a que los mantenedores la revisen.

## 🎨 Guías de estilo y convenciones

* **Estética de UI/UX:** Cualquier adición visual debe respetar el *Dark Mode* nativo y la estética *cyber/tech* orientada al streetwear.
* **Integridad de la base de datos:** Está estrictamente prohibido almacenar imágenes pesadas (BLOBs) en la base de datos; usa rutas de archivos locales. Respeta siempre los límites relacionales y `PRAGMA foreign_keys = ON`.
* **Calidad del código:** Mantén las funciones modulares, comenta tus decisiones estructurales y conserva una indentación limpia.
