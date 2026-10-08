INSERT INTO categoria (id_categoria, nombre, descripcion, estado)
SELECT 1, 'Polos', 'Polos para hombre y mujer', 'ACTIVA'
WHERE NOT EXISTS (
    SELECT 1 FROM categoria WHERE id_categoria = 1
);

INSERT INTO categoria (id_categoria, nombre, descripcion, estado)
SELECT 2, 'Pantalones', 'Pantalones y jeans', 'ACTIVA'
WHERE NOT EXISTS (
    SELECT 1 FROM categoria WHERE id_categoria = 2
);

INSERT INTO categoria (id_categoria, nombre, descripcion, estado)
SELECT 3, 'Casacas', 'Casacas', 'ACTIVA'
WHERE NOT EXISTS (
    SELECT 1 FROM categoria WHERE id_categoria = 3
);

-- Datos de demostracion para las graficas de ventas.
-- Se usa un producto inactivo para no mostrarlo en la tienda.
INSERT INTO producto (nombre, descripcion, id_categoria, precio, stock, estado)
SELECT 'Producto de muestra para metricas', 'Producto usado para registrar ventas de ejemplo',
       id_categoria, 50.00, 0, 'INACTIVO'
FROM categoria
WHERE nombre = 'Polos'
  AND NOT EXISTS (SELECT 1 FROM producto WHERE nombre = 'Producto de muestra para metricas');

-- Ventas de ejemplo de los ultimos ocho meses.
-- Venta de ejemplo 1.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -7, CURRENT_DATE)) AS TIMESTAMP))), 150.00, 0.00, 150.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -7, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 150.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 3, 50.00, 150.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -7, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 150.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -7, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 150.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 2.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -7, CURRENT_DATE)) AS TIMESTAMP))), 250.00, 0.00, 250.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -7, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 250.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 5, 50.00, 250.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -7, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 250.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -7, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 250.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 3.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -6, CURRENT_DATE)) AS TIMESTAMP))), 100.00, 0.00, 100.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -6, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 100.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 2, 50.00, 100.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -6, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 100.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -6, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 100.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 4.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -6, CURRENT_DATE)) AS TIMESTAMP))), 300.00, 0.00, 300.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -6, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 300.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 6, 50.00, 300.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -6, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 300.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -6, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 300.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 5.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -5, CURRENT_DATE)) AS TIMESTAMP))), 200.00, 0.00, 200.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -5, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 200.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 4, 50.00, 200.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -5, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 200.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -5, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 200.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 6.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -5, CURRENT_DATE)) AS TIMESTAMP))), 350.00, 0.00, 350.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -5, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 350.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 7, 50.00, 350.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -5, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 350.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -5, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 350.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 7.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -4, CURRENT_DATE)) AS TIMESTAMP))), 250.00, 0.00, 250.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -4, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 250.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 5, 50.00, 250.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -4, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 250.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -4, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 250.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 8.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -4, CURRENT_DATE)) AS TIMESTAMP))), 150.00, 0.00, 150.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -4, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 150.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 3, 50.00, 150.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -4, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 150.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -4, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 150.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 9.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -3, CURRENT_DATE)) AS TIMESTAMP))), 400.00, 0.00, 400.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -3, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 400.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 8, 50.00, 400.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -3, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 400.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -3, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 400.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 10.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -3, CURRENT_DATE)) AS TIMESTAMP))), 200.00, 0.00, 200.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -3, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 200.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 4, 50.00, 200.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -3, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 200.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -3, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 200.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 11.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -2, CURRENT_DATE)) AS TIMESTAMP))), 250.00, 0.00, 250.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -2, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 250.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 5, 50.00, 250.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -2, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 250.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -2, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 250.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 12.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -2, CURRENT_DATE)) AS TIMESTAMP))), 350.00, 0.00, 350.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -2, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 350.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 7, 50.00, 350.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -2, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 350.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -2, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 350.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 13.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -1, CURRENT_DATE)) AS TIMESTAMP))), 500.00, 0.00, 500.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -1, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 500.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 10, 50.00, 500.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -1, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 500.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 7, DATEADD('HOUR', 10, CAST(DATEADD('DAY', -5, DATEADD('MONTH', -1, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 500.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 14.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -1, CURRENT_DATE)) AS TIMESTAMP))), 150.00, 0.00, 150.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -1, CURRENT_DATE)) AS TIMESTAMP)))
                    AND v.total = 150.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 3, 50.00, 150.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -1, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 150.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 4, DATEADD('HOUR', 15, CAST(DATEADD('DAY', -2, DATEADD('MONTH', -1, CURRENT_DATE)) AS TIMESTAMP))) AND v.total = 150.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 15.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 12, DATEADD('HOUR', 9, CAST(DATEADD('DAY', -5, CURRENT_DATE) AS TIMESTAMP))), 100.00, 0.00, 100.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 12, DATEADD('HOUR', 9, CAST(DATEADD('DAY', -5, CURRENT_DATE) AS TIMESTAMP)))
                    AND v.total = 100.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 2, 50.00, 100.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 12, DATEADD('HOUR', 9, CAST(DATEADD('DAY', -5, CURRENT_DATE) AS TIMESTAMP))) AND v.total = 100.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 12, DATEADD('HOUR', 9, CAST(DATEADD('DAY', -5, CURRENT_DATE) AS TIMESTAMP))) AND v.total = 100.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 16.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 24, DATEADD('HOUR', 11, CAST(DATEADD('DAY', -3, CURRENT_DATE) AS TIMESTAMP))), 200.00, 0.00, 200.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 24, DATEADD('HOUR', 11, CAST(DATEADD('DAY', -3, CURRENT_DATE) AS TIMESTAMP)))
                    AND v.total = 200.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 4, 50.00, 200.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 24, DATEADD('HOUR', 11, CAST(DATEADD('DAY', -3, CURRENT_DATE) AS TIMESTAMP))) AND v.total = 200.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 24, DATEADD('HOUR', 11, CAST(DATEADD('DAY', -3, CURRENT_DATE) AS TIMESTAMP))) AND v.total = 200.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 17.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 36, DATEADD('HOUR', 14, CAST(DATEADD('DAY', -1, CURRENT_DATE) AS TIMESTAMP))), 150.00, 0.00, 150.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 36, DATEADD('HOUR', 14, CAST(DATEADD('DAY', -1, CURRENT_DATE) AS TIMESTAMP)))
                    AND v.total = 150.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 3, 50.00, 150.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 36, DATEADD('HOUR', 14, CAST(DATEADD('DAY', -1, CURRENT_DATE) AS TIMESTAMP))) AND v.total = 150.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 36, DATEADD('HOUR', 14, CAST(DATEADD('DAY', -1, CURRENT_DATE) AS TIMESTAMP))) AND v.total = 150.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);

-- Venta de ejemplo 18.
INSERT INTO venta (id_usuario, fecha_venta, subtotal, descuento, total, estado)
SELECT u.id_usuario, DATEADD('MINUTE', 48, DATEADD('HOUR', 16, CAST(DATEADD('DAY', 0, CURRENT_DATE) AS TIMESTAMP))), 300.00, 0.00, 300.00, 'PAGADA'
FROM usuario u
WHERE u.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND NOT EXISTS (SELECT 1 FROM venta v
                  WHERE v.id_usuario = u.id_usuario
                    AND v.fecha_venta = DATEADD('MINUTE', 48, DATEADD('HOUR', 16, CAST(DATEADD('DAY', 0, CURRENT_DATE) AS TIMESTAMP)))
                    AND v.total = 300.00 AND v.estado = 'PAGADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
SELECT v.id_venta, p.id_producto, 6, 50.00, 300.00
FROM venta v JOIN producto p ON p.nombre = 'Producto de muestra para metricas'
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 48, DATEADD('HOUR', 16, CAST(DATEADD('DAY', 0, CURRENT_DATE) AS TIMESTAMP))) AND v.total = 300.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM detalle_venta d WHERE d.id_venta = v.id_venta);

INSERT INTO pago (id_venta, monto, metodo_pago, estado)
SELECT v.id_venta, v.total, 'Yape', 'APROBADO'
FROM venta v
WHERE v.id_usuario = (SELECT MIN(id_usuario) FROM usuario
                     WHERE tipo_usuario = 'CLIENTE' AND estado = 'ACTIVO')
  AND v.fecha_venta = DATEADD('MINUTE', 48, DATEADD('HOUR', 16, CAST(DATEADD('DAY', 0, CURRENT_DATE) AS TIMESTAMP))) AND v.total = 300.00 AND v.estado = 'PAGADA'
  AND NOT EXISTS (SELECT 1 FROM pago pg WHERE pg.id_venta = v.id_venta);
