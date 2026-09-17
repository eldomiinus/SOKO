<div align="center">
    <h1>🛡️ Política de seguridad de SOKO</h1>
    <b>Privacidad desde el diseño, arquitectura offline-first y control local de los datos.</b>
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

> **SOKO** trata la privacidad de los datos del usuario como una prioridad absoluta. Diseñado para marcas independientes y emprendedores, nuestro modelo de seguridad garantiza que tus datos te pertenecen. No rastreamos, recopilamos ni almacenamos de forma remota los datos de tu inventario sin tu consentimiento explícito.

<br>

## 🏗️ Arquitectura de seguridad y privacidad de datos

Nuestra seguridad se basa en una estricta arquitectura **Offline-First**. La base de datos SQLite local garantiza el control total y la privacidad absoluta de tu información sin depender de conexiones a internet.

### 🔐 Cifrado de base de datos (SQLCipher)
Para proteger los datos sensibles de tu negocio contra el acceso local no autorizado, SOKO implementa **SQLCipher**. 
* El archivo físico de SQLite (`soko.db`) está protegido contra intrusos mediante una contraseña o PIN. 
* Esta capa de cifrado funciona de forma transparente y no altera las reglas estructurales de la base de datos (como las restricciones `CHECK` diseñadas para evitar stock negativo).
* **PIN de conocimiento cero:** El PIN o contraseña maestra que desbloquea SQLCipher **nunca** se guarda dentro de la base de datos. Si un actor malicioso extrae el archivo `.db`, este permanece completamente ilegible sin tus credenciales.

### 📦 Copias de seguridad seguras y sistema de archivos
Para evitar la corrupción de datos y garantizar copias de seguridad rápidas y seguras, SOKO aísla los archivos multimedia de los datos sin procesar.
* **No se permiten BLOBs:** El motor de la base de datos guarda estrictamente rutas de texto (`image_path: TEXT`) y rechaza el almacenamiento directo de archivos pesados (BLOBs) dentro de las tablas relacionales.
* **Exportaciones cifradas:** Al generar una copia de seguridad, el sistema unifica de forma segura el archivo de base de datos cifrado y la carpeta local de imágenes en un archivo `.zip` portátil, lo que facilita y protege la migración de los datos de tu showroom entre dispositivos.

<br>
<hr>
<br>

## 📢 Reportar una vulnerabilidad

Si descubres una vulnerabilidad de seguridad dentro de SOKO (por ejemplo, un exploit en el renderizado de ventanas de Electron, un problema que evite el PIN de SQLite o una fuga de datos inesperada), **NO** abras un issue público.

En su lugar, repórtala de forma privada a nuestro equipo para que podamos abordarla de manera responsable:

1. Envía tus hallazgos por correo electrónico a: **[kyroshop.exe@gmail.com](mailto:kyroshop.exe@gmail.com)**
2. Incluye una descripción detallada de la vulnerabilidad.
3. Proporciona pasos para reproducir el problema (se agradecen mucho los registros, la versión del SO o las capturas de pantalla).

Tomamos en serio todos los reportes de seguridad y responderemos lo antes posible para coordinar un parche antes de la divulgación pública.

<br>

### 🗃️ Versiones compatibles
Actualmente, dado que SOKO se encuentra en sus primeras etapas de desarrollo, solo la rama `main` y las últimas versiones preliminares reciben actualizaciones de seguridad.

<div align=center>

| Versión | Compatible          |
| ------- | ------------------- |
| 1.0.x   | ✅ Activa           |
| < 1.0   | ❌ No compatible    |

</div>
