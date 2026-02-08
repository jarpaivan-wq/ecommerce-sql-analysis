-- =====================================================
-- Script: 03_queries.sql
-- Description: Business analysis queries
-- Project: E-commerce SQL Analysis
-- =====================================================

USE ecommerce_ropa;

-- =====================================================
-- Query 1: Top 10 Best-Selling Products
-- =====================================================
-- Goal: Identify star products by volume of units sold
-- Use: Inventory planning and marketing strategies

SELECT
    p.nombre_producto AS product_name,
    p.categoria AS product_category,
    SUM(dv.cantidad) AS total_units_sold
FROM productos p
INNER JOIN detalle_ventas dv ON p.producto_id = dv.producto_id
GROUP BY p.nombre_producto, p.categoria
ORDER BY total_units_sold DESC
LIMIT 10;


-- =====================================================
-- Query 2: Total Sales by Month
-- =====================================================
-- Goal: Analyze revenue evolution during August-October 2024
-- Use: Detect seasonal trends and high/low demand periods

SELECT
    CASE MONTH(v.fecha_venta)
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
    END AS sale_month,
    YEAR(v.fecha_venta) AS sale_year,
    SUM(v.total) AS total_sales_usd
FROM ventas v
GROUP BY sale_month, sale_year
ORDER BY
    CASE sale_month
        WHEN 'August' THEN 1
        WHEN 'September' THEN 2
        WHEN 'October' THEN 3
        ELSE 99
    END;


-- =====================================================
-- Query 3: Frequent Customers (more than 3 purchases)
-- =====================================================
-- Goal: Identify loyal customers who have made more than 3 purchases
-- Use: Foundation for loyalty programs and retention strategies

SELECT
    c.nombre AS customer_name,
    c.email AS customer_email,
    COUNT(v.venta_id) AS purchase_count,
    SUM(v.total) AS total_spent_usd
FROM clientes c
INNER JOIN ventas v ON c.cliente_id = v.cliente_id
GROUP BY customer_name, customer_email
HAVING COUNT(v.venta_id) > 3
ORDER BY purchase_count DESC;


-- =====================================================
-- Query 4: Critical Products for Restocking
-- =====================================================
-- Goal: Detect products with low stock (<50) but high demand (>5 sold)
-- Use: Prevent stockouts on profitable products

SELECT
    p.nombre_producto AS product_name,
    p.stock_actual AS current_stock,
    SUM(dv.cantidad) AS total_units_sold,
    p.precio AS price
FROM productos p
INNER JOIN detalle_ventas dv ON p.producto_id = dv.producto_id
WHERE p.stock_actual < 50
GROUP BY p.nombre_producto, p.stock_actual, p.precio
HAVING SUM(dv.cantidad) > 5
ORDER BY total_units_sold DESC;


-- =====================================================
-- Query 5: Average Ticket per Customer
-- =====================================================
-- Goal: Calculate average purchase value per recurring customer
-- Use: Customer segmentation and upselling strategies

SELECT
    c.nombre AS customer_name,
    COUNT(v.venta_id) AS purchase_count,
    SUM(v.total) AS total_spent,
    AVG(v.total) AS average_purchase
FROM clientes c
INNER JOIN ventas v ON c.cliente_id = v.cliente_id
GROUP BY customer_name
HAVING purchase_count >= 2
ORDER BY total_spent DESC;


-- =====================================================
-- Bonus Queries
-- =====================================================

-- Best-selling product category
SELECT
    p.categoria AS category,
    COUNT(DISTINCT dv.venta_id) AS number_of_sales,
    SUM(dv.cantidad) AS units_sold,
    SUM(dv.cantidad * dv.precio_unitario) AS total_revenue
FROM productos p
INNER JOIN detalle_ventas dv ON p.producto_id = dv.producto_id
GROUP BY p.categoria
ORDER BY total_revenue DESC;

-- Products with no sales (require marketing action)
SELECT
    p.producto_id AS product_id,
    p.nombre_producto AS product_name,
    p.categoria AS category,
    p.precio AS price,
    p.stock_actual AS current_stock
FROM productos p
LEFT JOIN detalle_ventas dv ON p.producto_id = dv.producto_id
WHERE dv.producto_id IS NULL;
