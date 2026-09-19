<div align="center">
    <h1>⚙️ Arquitectura de SOKO</h1>
    <b>La base técnica de nuestro ecosistema Offline-First.</b>
</div>

<div align="center">
    <sub>
        <a href="../../ARCHITECTURE.md">English</a> · <a href="ARCHITECTURE.es.md">Español</a> · <a href="ARCHITECTURE.ru.md">Русский</a> · <a href="ARCHITECTURE.ja.md">日本語</a> · <a href="ARCHITECTURE.ko.md">한국어</a> · <a href="ARCHITECTURE.pt.md">Português</a> · <a href="ARCHITECTURE.fr.md">Français</a> · <a href="ARCHITECTURE.it.md">Italiano</a>
    </sub>
</div>

<br>

<div align="center">

[![Offline First - Static](https://img.shields.io/badge/Architecture-Offline_First?style=for-the-badge&logo=Databricks&label=Architecture&labelColor=101418&color=99CCFF)](#)
[![IPC Bridge - Static](https://img.shields.io/badge/Electron-IPC_Bridge?style=for-the-badge&logo=Electron&label=Communication&labelColor=101418&color=BBBBDD)](#)

</div>

> **SOKO** está construido como una aplicación de escritorio nativa diseñada para garantizar rendimiento nativo, privacidad absoluta de los datos y operatividad plena durante ferias temporales sin depender de una conexión a internet. Este documento describe cómo interactúan el Frontend, el Backend y la Base de datos dentro de este entorno.

<br>

## 🖥️ 1. El modelo de comunicación IPC de Electron

Debido a que SOKO está empaquetado con **Electron**, mantenemos una estricta separación de responsabilidades entre la interfaz de usuario y los recursos del sistema para lograr seguridad y rendimiento:

* **Frontend (proceso Renderer):** Construido con HTML5, CSS3 (Grid) y Vanilla JS. Gestiona la UI/UX, las animaciones y captura las entradas del usuario. **Nunca accede directamente a la base de datos.**
* **Puente IPC (Context Bridge):** Usamos el `preload.js` de Electron para exponer una API segura al frontend.
* **Backend (proceso Main):** Se ejecuta en Node.js. Escucha los canales IPC enviados por el Frontend, ejecuta las operaciones lógicas pesadas, lee/escribe en el sistema de archivos local y consulta la base de datos SQLite.

## 💾 2. Motor de base de datos y sistema de archivos

El núcleo de nuestro almacenamiento de datos se basa en un modelo relacional que utiliza **SQLite 3**. Aplicamos reglas técnicas estrictas para mantener la aplicación extremadamente rápida:

### La regla de «sin BLOBs»
Está estrictamente prohibido usar campos BLOB para almacenar imágenes dentro de la base de datos. Guardar archivos multimedia pesados directamente en SQLite causa una grave hinchazón de la base de datos y degradación del rendimiento.
* **Cómo lo gestionamos:** El backend guarda los archivos de imagen físicos en un árbol de directorios local (p. ej., `/assets/images/catalog/`).
* La base de datos solo guarda la cadena de texto de la ruta local (`image_path: TEXT`) que apunta a ese archivo.

### Integridad y configuración de datos
* **Relaciones estrictas:** Aplicamos explícitamente `PRAGMA foreign_keys = ON;` en cada conexión para garantizar la integridad de los datos entre proveedores, productos e inventarios.
* **Configuración de la aplicación:** Las preferencias del sistema (como el estado del modo oscuro o la fecha de la última copia de seguridad) se aíslan en una tabla `App_Settings` independiente para evitar saturar los datos transaccionales del inventario.

## 📦 3. Lógica de multiinventario (el puente)

La característica que define a SOKO es su capacidad para gestionar múltiples ubicaciones físicas simultáneamente (p. ej., almacén central, tiendas emergentes, ferias). 

Las ubicaciones se categorizan por su naturaleza (`type`): *Fijo* (Fixed), *Temporal* (Temporary) o *Transito* (In-Transit).

### El puente transaccional

Evitamos entradas de productos duplicadas mediante una tabla puente llamada `Inventory_Stock`. 
* Cuando se traslada stock a una feria de fin de semana, el sistema deduce de forma nativa las unidades del «almacén central» y las asigna al inventario de la «feria» mediante transacciones SQL seguras. 
* Una vez finalizada la feria, el stock restante se transfiere de regreso.
* **La seguridad primero:** Utilizamos restricciones `CHECK` a nivel de base de datos para garantizar que el stock físico **nunca** pueda ser negativo.

## 🔗 4. El ecosistema modular

SOKO actúa como el motor central de un entorno escalable. Su arquitectura de base de datos está preparada para ser consumida por futuras extensiones:

1. **SOKO POS:** Una futura extensión de punto de venta para que los cajeros escaneen códigos de barras y descuenten stock sin problemas en tiempo real.
2. **Integración con KURA:** Un futuro módulo donde cada artículo marcado como «Vendido» en SOKO activará automáticamente un registro de ingresos monetarios en el sistema financiero KURA, unificando el control operativo y económico.
