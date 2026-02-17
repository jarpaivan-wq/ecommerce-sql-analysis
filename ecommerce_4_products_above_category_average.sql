-- ============================================================
-- QUERY 11: Products Above Category Average Sales
-- ============================================================
-- Database: ecommerce_ropa
-- Author: Ivan Jarpa
-- Date: February 2026
-- Complexity Level: ⭐⭐⭐⭐ Advanced
-- ============================================================

-- BUSINESS QUESTION:
-- Which products are selling above their category's average?
-- Show ranking within each category.

-- KEY CONCEPTS:
-- ✓ Multiple CTEs (3 levels)
-- ✓ JOINs between CTEs
-- ✓ Window functions (RANK with PARTITION BY)
-- ✓ Aggregations (SUM, AVG)
-- ✓ Complex filtering logic

-- ============================================================
-- SOLUTION
-- ============================================================

USE ecommerce_ropa;

WITH tabla_total_vendido AS (
    -- CTE1: Calculate total units sold per product
    SELECT
        producto_id,
        SUM(cantidad) AS total_vendido
    FROM detalle_ventas
    GROUP BY producto_id
),
tabla_promedio_categoria AS (
    -- CTE2: Calculate average sales per category
    SELECT
        pro.categoria,
        AVG(ttv.total_vendido) AS promedio_categoria
    FROM productos pro
    INNER JOIN tabla_total_vendido ttv
        ON pro.producto_id = ttv.producto_id
    GROUP BY pro.categoria
)
-- Final query: Products above category average with ranking
SELECT
    pro.categoria,
    pro.nombre_producto,
    ttv.total_vendido,
    tpc.promedio_categoria,
    RANK() OVER(
        PARTITION BY pro.categoria 
        ORDER BY ttv.total_vendido DESC
    ) AS ranking_en_categoria
FROM productos pro
INNER JOIN tabla_total_vendido ttv
    ON pro.producto_id = ttv.producto_id
INNER JOIN tabla_promedio_categoria tpc
    ON pro.categoria = tpc.categoria
WHERE ttv.total_vendido > tpc.promedio_categoria
ORDER BY pro.categoria DESC, ranking_en_categoria ASC;

-- ============================================================
-- EXPECTED OUTPUT COLUMNS:
-- ============================================================
-- categoria: Product category
-- nombre_producto: Product name
-- total_vendido: Total units sold
-- promedio_categoria: Category average sales
-- ranking_en_categoria: Rank within category (1 = top seller)

-- ============================================================
-- BUSINESS VALUE:
-- ============================================================
-- Identifies star products within each category that perform
-- above their category's baseline. Useful for:
-- - Inventory optimization
-- - Marketing focus
-- - Product recommendations
-- - Performance benchmarking
