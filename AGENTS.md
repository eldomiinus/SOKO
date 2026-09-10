# Contexto del Proyecto: SOKO

## 1. Visión General
* **Nombre del Proyecto:** SOKO.
* **Propósito:** Software de escritorio (o híbrido) diseñado para la gestión integral y "Multi-Inventario" de marcas de indumentaria independientes, showrooms y emprendedores textiles.
* **El Problema que Resuelve:** Elimina el caos de las planillas de cálculo al gestionar el ciclo de vida completo de las prendas a través de un sistema de variantes (talles y colores) y controlar el stock en múltiples espacios físicos simultáneamente.
* **El Ecosistema (Visión a futuro):** SOKO es el núcleo operativo[cite: 2]. A futuro, se integrará con **KURA** (software de gestión financiera, donde cada venta en SOKO impactará como ingreso monetario) y sumará el módulo **SOKO POS** (extensión de caja con lectura de códigos de barras).

## 2. Arquitectura y Stack Tecnológico
* **Arquitectura:** **Offline-First**. Se prioriza el rendimiento nativo, la operatividad total sin conexión a internet (vital para ferias temporales) y la privacidad absoluta de los datos locales del usuario.
* **Base de Datos:** SQLite 3.
* **Frontend (UI/UX):** HTML5, CSS3, JS. Diseño estructurado en cuadrículas (grids), ejecutado por defecto en **Modo Oscuro (Dark Mode)**, con una estética visual y limpia, orientada a la cultura alternativa/streetwear.
* **Backend:** Por definir (orientado a empaquetadores como Tauri o Electron para asegurar acceso profundo al sistema de archivos local).

## 3. Reglas Estrictas de Base de Datos y Lógica de Negocio
* **Gestión de Imágenes:** PROHIBIDO usar campos BLOB para imágenes. Para mantener la base de datos ligera, las imágenes se gestionan vía sistema de archivos locales y SQLite solo almacena la ruta en texto (`image_path`). Solo se requiere una imagen principal por variante.
* **Modelo Relacional Transaccional:** Separación estricta entre Catálogo y Ubicaciones. Se usa una tabla puente (`Inventory_Stock`) para conectar las variantes de producto (`Products_Variants`) con los depósitos/ferias (`Inventories`).
* **Restricciones y Seguridad:** Habilitar siempre `PRAGMA foreign_keys = ON;`. Configurar `ON DELETE CASCADE` o `SET NULL` según convenga. El stock físico NUNCA puede ser negativo (usar validaciones `CHECK` obligatoriamente).
* **Campos Críticos de Indumentaria:** Cada producto debe mantener metadatos vitales como `category` (Pantalón, Remera), `fit` (Baggy, Oversized), `fabric` (tipo de tela), `sku`, `cost_price` (para calcular márgenes) y `sale_price`.

## 4. Instrucciones para la IA (System Instructions)
1. **Trabajo Modular:** Este proyecto se desarrolla en partes. Antes de escribir código, pregúntale al usuario en qué módulo o archivo específico se van a enfocar en esta iteración para no saturar la memoria.
2. **Respetar la Arquitectura:** No sugieras tecnologías Cloud, bases de datos NoSQL ni servidores externos. SOKO es estrictamente Offline-First y usa SQLite.
3. **Consistencia UI/UX:** Cualquier componente visual generado (botones, tablas, modales) debe estar pensado para un entorno *Dark Mode*, ser sumamente ágil para el operador y mantener la estética técnica/cyber.
4. **Código Limpio:** Al generar código, prioriza la limpieza, buena indentación y proporciona comentarios breves explicando las decisiones estructurales.
5. **Código Organizado:** Ten en cuenta siempre la organizacion de los archivos y las carpetas dentro del proyecto, organiza archivos en carpetas sin dejar código esparcido por el repositorio, que sea facil de entender para cualquiera.
