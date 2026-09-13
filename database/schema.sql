-- ============================================================================
-- SOKO — Sistema de Gestión de Inventario Multi-Depósito para Indumentaria
-- Motor: SQLite 3
-- Arquitectura: Offline-First / Transaccional
-- Autor: Arquitecto de BD Senior
-- ============================================================================
-- Notas de diseño:
--   * No se usan BLOBs: las imágenes viven en el filesystem local, la BD solo
--     guarda la ruta (image_path).
--   * El stock físico nunca puede ser negativo (CHECK en Inventory_Stock).
--   * Products_Variants es el catálogo estático (identidad del producto);
--     Inventory_Stock es la tabla transaccional que mueve cantidades.
-- ============================================================================

PRAGMA foreign_keys = ON;
-- Recomendado en apps de escritorio offline-first para mejorar concurrencia
-- lectura/escritura (opcional, no interfiere con la integridad relacional):
-- PRAGMA journal_mode = WAL;


-- ============================================================================
-- 1) SUPPLIERS — Directorio de proveedores y talleres
--    Trazabilidad de quién fabricó tela, confeccionó o estampó cada lote.
-- ============================================================================
CREATE TABLE IF NOT EXISTS Suppliers (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    name            TEXT NOT NULL,
    contact_info    TEXT,
    service_type    TEXT,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================================
-- 2) PRODUCTS_VARIANTS — Catálogo central (identidad estática del producto)
--    Una fila = una combinación única de talle + color de una prenda.
--    NO guarda cantidades: el stock vive exclusivamente en Inventory_Stock.
-- ============================================================================
CREATE TABLE IF NOT EXISTS Products_Variants (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    sku             TEXT NOT NULL UNIQUE,
    parent_name     TEXT NOT NULL,
    category        TEXT NOT NULL,
    fit             TEXT,
    size            TEXT NOT NULL,
    color           TEXT NOT NULL,
    fabric          TEXT,
    supplier_id     INTEGER,
    status          TEXT NOT NULL DEFAULT 'AVAILABLE'
                        CHECK (status IN ('IN_PRODUCTION', 'AVAILABLE', 'RESERVED', 'ARCHIVED')),
    cost_price      DECIMAL(10,2) NOT NULL CHECK (cost_price >= 0),
    sale_price      DECIMAL(10,2) NOT NULL CHECK (sale_price >= 0),
    barcode         TEXT UNIQUE,
    image_path      TEXT,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- Si se borra un proveedor, el producto no desaparece (historial de venta
    -- y stock se preservan); simplemente pierde la referencia al proveedor.
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- ============================================================================
-- 3) INVENTORIES — Ubicaciones físicas/lógicas donde puede haber mercadería
--    (depósitos fijos, locales, ferias temporales, tránsito entre puntos)
-- ============================================================================
CREATE TABLE IF NOT EXISTS Inventories (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL,
    type        TEXT NOT NULL CHECK (type IN ('Fijo', 'Temporal', 'Transito')),
    is_active   BOOLEAN NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)),
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================================
-- 4) INVENTORY_STOCK — Tabla puente transaccional (Multi-Inventario)
--    Cuánto hay de cada variante en cada ubicación. La PK compuesta impide
--    que una misma variante tenga dos filas en la misma ubicación (en vez
--    de eso, se actualiza la cantidad existente vía UPSERT).
-- ============================================================================
CREATE TABLE IF NOT EXISTS Inventory_Stock (
    inventory_id    INTEGER NOT NULL,
    variant_id      INTEGER NOT NULL,
    quantity        INTEGER NOT NULL DEFAULT 0 CHECK (quantity >= 0), -- nunca negativo
    last_updated    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,     -- clave para "Dead Stock" (>60 días)

    PRIMARY KEY (inventory_id, variant_id),

    -- Si se elimina una ubicación o una variante, se limpia su rastro de stock.
    FOREIGN KEY (inventory_id) REFERENCES Inventories(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (variant_id) REFERENCES Products_Variants(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- ============================================================================
-- ÍNDICES — Aceleran los joins y filtros más frecuentes del sistema
-- ============================================================================
CREATE INDEX IF NOT EXISTS idx_variants_supplier   ON Products_Variants(supplier_id);
CREATE INDEX IF NOT EXISTS idx_variants_category   ON Products_Variants(category);
CREATE INDEX IF NOT EXISTS idx_variants_status     ON Products_Variants(status);
CREATE INDEX IF NOT EXISTS idx_stock_variant       ON Inventory_Stock(variant_id);
CREATE INDEX IF NOT EXISTS idx_stock_last_updated  ON Inventory_Stock(last_updated); -- reporte Dead Stock


-- ============================================================================
-- TRIGGER — Mantiene last_updated sincronizado cada vez que cambia quantity.
--    Se dispara solo ante cambios de "quantity" (no en otras columnas), y su
--    propia UPDATE toca únicamente "last_updated", por lo que no hay recursión.
-- ============================================================================
CREATE TRIGGER IF NOT EXISTS trg_inventory_stock_touch
AFTER UPDATE OF quantity ON Inventory_Stock
FOR EACH ROW
BEGIN
    UPDATE Inventory_Stock
    SET last_updated = CURRENT_TIMESTAMP
    WHERE inventory_id = NEW.inventory_id
        AND variant_id   = NEW.variant_id;
END;


-- ============================================================================
-- SEED DATA — Datos de prueba para validar el esquema en una BD nueva
-- ============================================================================
BEGIN TRANSACTION;

-- 1 proveedor
INSERT INTO Suppliers (name, contact_info, service_type)
VALUES ('Taller San Martín', 'contacto@tallersanmartin.com.ar / 11-4567-8901', 'Confección');

-- 1 inventario principal
INSERT INTO Inventories (name, type, is_active)
VALUES ('Depósito Central', 'Fijo', 1);

-- 2 prendas de prueba con estados distintos
--INSERT INTO Products_Variants
--    (sku, parent_name, category, fit, size, color, fabric, supplier_id, status, cost_price, sale_price, barcode, image_path)
--VALUES
--    ('PANT-BAGGY-38-BLU', 'Pantalón Parachute Y2K', 'Pantalones', 'Baggy', '38', 'Azul',
--    'Nylon Parachute', 1, 'AVAILABLE', 8500.00, 24999.00,
--    '7791234567890', '/assets/images/catalog/pant-baggy-38-blu.jpg'),
--    ('REM-OVER-M-NEG', 'Remera Oversized Basic', 'Remeras', 'Oversized', 'M', 'Negro',
--    'Jersey 24/1', 1, 'IN_PRODUCTION', 3200.00, 11999.00,
--    '7791234567891', '/assets/images/catalog/rem-over-m-neg.jpg');

-- Asignación de stock en la tabla puente
--INSERT INTO Inventory_Stock (inventory_id, variant_id, quantity)
--VALUES
--    (1, 1, 15),  -- Pantalón: ya disponible en Depósito Central
--    (1, 2, 0);   -- Remera: aún IN_PRODUCTION, sin stock físico todavía
--
--COMMIT;
