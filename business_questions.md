# 📋 Query Documentation - Business Questions

This document provides detailed explanations for each query developed for the e-commerce analysis.

---

## Query 1: Top 10 Best-Selling Products

### 🎯 Goal
Identify products that generate the highest sales volume in terms of units sold.

### 💼 Use Cases
- **Marketing**: Focus campaigns on successful products
- **Inventory**: Ensure sufficient stock of popular products
- **Pricing**: Evaluate pricing strategies on best-sellers

### 📊 Metrics Obtained
- Product name
- Category
- Total units sold

### 🔍 Technical Logic
```sql
SELECT
    p.nombre_producto AS product_name,
    p.categoria AS product_category,
    SUM(dv.cantidad) AS total_units_sold
FROM productos p
INNER JOIN detalle_ventas dv ON p.producto_id = dv.producto_id
GROUP BY p.nombre_producto, p.categoria
ORDER BY total_units_sold DESC
LIMIT 10;
```

**Step-by-step explanation:**
1. **JOIN**: Connect products with their detailed sales
2. **SUM**: Aggregate all units sold per product
3. **GROUP BY**: Group by unique product
4. **ORDER BY**: Sort from highest to lowest
5. **LIMIT**: Show only top 10

### 💡 Expected Insight
Best-selling products may not be the most profitable. Cross-reference with margin analysis for strategic decisions.

---

## Query 2: Total Sales by Month

### 🎯 Goal
Analyze the temporal evolution of sales during the August-October 2024 quarter.

### 💼 Use Cases
- **Finance**: Revenue projection and cash flow
- **Operations**: Resource planning based on demand
- **Strategy**: Identify business seasonality

### 📊 Metrics Obtained
- Sale month
- Year
- Total revenue in USD

### 🔍 Technical Logic
```sql
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
```

**Step-by-step explanation:**
1. **CASE MONTH**: Convert month numbers to readable names
2. **SUM(v.total)**: Sum total of all sales for the month
3. **GROUP BY**: Group by month and year
4. **ORDER BY CASE**: Sort chronologically using conditional logic

### 💡 Expected Insight
Significant variations between months indicate seasonality. Adjust inventory and promotions based on detected patterns.

---

## Query 3: Frequent Customers

### 🎯 Goal
Identify loyal customers who have made more than 3 purchases during the analyzed period.

### 💼 Use Cases
- **CRM**: Loyalty programs and rewards
- **Marketing**: Segmentation for personalized campaigns
- **Sales**: Customer service prioritization

### 📊 Metrics Obtained
- Customer name
- Contact email
- Number of purchases made
- Total accumulated spending

### 🔍 Technical Logic
```sql
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
```

**Step-by-step explanation:**
1. **JOIN**: Connect customers with their sales
2. **COUNT**: Count how many times each customer has purchased
3. **SUM**: Calculate total accumulated spending
4. **GROUP BY**: Group by unique customer
5. **HAVING**: Filter only customers with more than 3 purchases
6. **ORDER BY**: Sort by purchase frequency

### 💡 Expected Insight
Frequent customers represent the 20% that generates 80% of revenue (Pareto principle). Retaining them is more profitable than acquiring new ones.

---

## Query 4: Critical Products for Restocking

### 🎯 Goal
Alert about products with low stock but high demand to avoid lost sales.

### 💼 Use Cases
- **Inventory**: Prioritize urgent purchase orders
- **Operations**: Optimize supply chain
- **Finance**: Prevent revenue loss due to stockouts

### 📊 Metrics Obtained
- Product name
- Current stock
- Total units sold
- Unit price

### 🔍 Technical Logic
```sql
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
```

**Step-by-step explanation:**
1. **WHERE**: Filter products with less than 50 units in stock
2. **JOIN**: Connect with sales to see demand
3. **SUM**: Calculate total units sold
4. **GROUP BY**: Group by product
5. **HAVING**: Only show products with high demand (>5 sold)
6. **ORDER BY**: Prioritize by sales volume

### 💡 Expected Insight
A product with low stock and high sales is a missed opportunity. Immediate action: increase purchase order.

---

## Query 5: Average Ticket per Customer

### 🎯 Goal
Calculate the average purchase value of recurring customers for strategic segmentation.

### 💼 Use Cases
- **Marketing**: Upselling and cross-selling strategies
- **Pricing**: Offer adjustment based on behavior
- **CRM**: VIP vs. regular segmentation

### 📊 Metrics Obtained
- Customer name
- Number of purchases
- Total spent
- Average per purchase

### 🔍 Technical Logic
```sql
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
```

**Step-by-step explanation:**
1. **JOIN**: Connect customers with sales
2. **COUNT**: Count number of transactions
3. **SUM**: Calculate total spending
4. **AVG**: Calculate average ticket
5. **GROUP BY**: Group by customer
6. **HAVING**: Only customers with minimum 2 purchases
7. **ORDER BY**: Sort by total value

### 💡 Expected Insight
Customers with high ticket but low frequency need engagement. Customers with low ticket but high frequency are candidates for bundle offers.

---

## 📈 Additional Analysis Recommendations

After running these 5 main queries, consider:

1. **Margin analysis**: Cross sales with costs to identify most profitable products
2. **Churn analysis**: Detect customers who stopped buying
3. **Geographic analysis**: Sales by city for regional expansion
4. **Category analysis**: Performance by product category
5. **Cohort analysis**: Customer behavior by registration date

---

## 🔧 Query Maintenance

**Recommended update**: Monthly

**Suggested monitoring**:
- Query 4 should run weekly for stock alerts
- Query 2 run at the beginning of each month for reports
- Query 3 and 5 run quarterly for CRM strategies

---

**Last updated**: 2024  
**Author**: Your Name  
**Contact**: your-email@example.com
