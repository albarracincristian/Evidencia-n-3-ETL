-- DDL básico y consultas ejemplo para MariaDB/MySQL
CREATE DATABASE IF NOT EXISTS etl_ventas;
USE etl_ventas;

-- Tabla destino (ajuste tipos según su CSV)
DROP TABLE IF EXISTS ventas_clientes_clean;
CREATE TABLE ventas_clientes_clean (
    customer_id        VARCHAR(64),
    age                INT,
    age_group          VARCHAR(16),
    gender             VARCHAR(16),
    payment_method     VARCHAR(32),
    order_id           VARCHAR(64),
    order_date         DATETIME,
    product_id         VARCHAR(64),
    product_name       VARCHAR(128),
    category           VARCHAR(64),
    quantity           INT,
    price              DECIMAL(18,2),
    unit_price         DECIMAL(18,2),
    amount             DECIMAL(18,2),
    total              DECIMAL(18,2)
);

-- Consultas solicitadas
-- 1) Modo de pago más frecuente (global y por género)
SELECT payment_method, COUNT(*) AS conteo
FROM ventas_clientes_clean
GROUP BY payment_method
ORDER BY conteo DESC
LIMIT 1;

SELECT gender, payment_method, COUNT(*) AS conteo
FROM ventas_clientes_clean
GROUP BY gender, payment_method
ORDER BY gender, conteo DESC;

-- 2) Métodos de pago para 25–35 años
SELECT payment_method, COUNT(*) AS conteo
FROM ventas_clientes_clean
WHERE age BETWEEN 25 AND 35
GROUP BY payment_method
ORDER BY conteo DESC;

-- 3) Métodos de pago más utilizados por mujeres
SELECT payment_method, COUNT(*) AS conteo
FROM ventas_clientes_clean
WHERE LOWER(gender)='female'
GROUP BY payment_method
ORDER BY conteo DESC;

-- 4) Precios por categoría de productos
SELECT category,
       COUNT(*) AS n,
       MIN(price) AS min_p,
       MAX(price) AS max_p,
       AVG(price) AS avg_p
FROM ventas_clientes_clean
GROUP BY category
ORDER BY category;
