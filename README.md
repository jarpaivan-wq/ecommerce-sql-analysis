# 📊 SQL Analysis - E-commerce Clothing Store

## 📝 Project Description

Sales data analysis for a clothing e-commerce business using SQL to provide insights for strategic business decisions.

## 🎯 Objective

Provide clear answers to key business questions through optimized SQL queries, enabling the management team to better understand sales behavior, customer patterns, and product performance.

## 🗄️ Database Structure

The `ecommerce_ropa` database contains 4 main tables:

### Tables

- **customers**: Registered customer information
  - `cliente_id` (PK)
  - `nombre` (name)
  - `email`
  - `fecha_registro` (registration date)
  - `ciudad` (city)

- **products**: Product catalog
  - `producto_id` (PK)
  - `nombre_producto` (product name)
  - `categoria` (category)
  - `precio` (price)
  - `stock_actual` (current stock)

- **sales**: Transaction records
  - `venta_id` (PK)
  - `cliente_id` (FK)
  - `fecha_venta` (sale date)
  - `total`

- **sale_details**: Items in each sale
  - `detalle_id` (PK)
  - `venta_id` (FK)
  - `producto_id` (FK)
  - `cantidad` (quantity)
  - `precio_unitario` (unit price)

### Relationship Diagram

```
customers (1) ----< (N) sales (1) ----< (N) sale_details (N) >---- (1) products
```

## 🔍 Business Questions Solved

### 1. Top 10 Best-Selling Products
**Goal**: Identify star products by volume of units sold.

**Insight**: Helps plan inventory and marketing strategies.

### 2. Total Sales by Month
**Goal**: Analyze revenue evolution during August-October 2024 period.

**Insight**: Detect seasonal trends and high/low demand periods.

### 3. Frequent Customers
**Goal**: Identify loyal customers who have made more than 3 purchases.

**Insight**: Foundation for loyalty programs and retention strategies.

### 4. Critical Products for Restocking
**Goal**: Detect products with low stock (<50 units) but high demand (>5 sold).

**Insight**: Prevent stockouts on profitable products.

### 5. Average Ticket per Customer
**Goal**: Calculate the average purchase value per recurring customer.

**Insight**: Customer segmentation and upselling strategies.

## 💻 Technologies Used

- **MySQL 8.0+**
- **DBeaver** (database management tool)

## 🚀 How to Use This Project

### Prerequisites
- MySQL installed (version 8.0 or higher)
- SQL client (DBeaver, MySQL Workbench, or command line)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/your-username/ecommerce-sql-analysis.git
cd ecommerce-sql-analysis
```

2. **Create the database**
```bash
mysql -u root -p < sql/01_schema.sql
```

3. **Load the data**
```bash
mysql -u root -p < sql/02_data.sql
```

4. **Run analysis queries**
```bash
mysql -u root -p < sql/03_queries.sql
```

### Manual Usage

Alternatively, you can copy and execute the SQL scripts directly in your favorite client:

1. Run `sql/01_schema.sql` to create tables
2. Run `sql/02_data.sql` to insert data
3. Run individual queries from `sql/03_queries.sql`

## 📂 Project Structure

```
ecommerce-sql-analysis/
│
├── README.md
├── sql/
│   ├── 01_schema.sql          # Table definitions
│   ├── 02_data.sql             # Sample data
│   └── 03_queries.sql          # Analysis queries
│
└── docs/
    └── business_questions.md   # Detailed documentation for each query
```

## 📈 Expected Results

By running the queries, you will get:

- List of best-selling products with their categories
- Monthly sales comparison
- VIP customer identification
- Restocking alerts
- Customer value metrics

## 🎓 Skills Demonstrated

- Complex SQL queries with multiple JOINs
- Data aggregation using GROUP BY and aggregate functions
- Conditional logic with CASE statements
- Data filtering with WHERE and HAVING
- Performance optimization with proper indexing
- Business analysis and insight generation

## 🤝 Contributing

This is a personal portfolio project. If you find improvements or suggestions, they are welcome.

## 📧 Contact

For inquiries or collaborations:
- GitHub: https://github.com/jarpaivan-wq
- Email: jarpa.ivan@gmail.com
- LinkedIn: https://www.linkedin.com/in/biexcel/

## 📄 License

This project is open source and available under the MIT License.

---

⭐ If you find this project useful, please consider giving it a star on GitHub.


## Appendix: Advanced Analytics Queries

# Advanced Query 11: Products Above Category Average

## 📊 Business Question
Which products are performing above their category's average sales? This analysis helps identify star products within each category for inventory and marketing optimization.

## 🎯 Technical Complexity
**Level:** ⭐⭐⭐⭐ Advanced

**Key Concepts Demonstrated:**
- Multiple CTEs (3 levels)
- JOINs between CTEs
- Window functions with PARTITION BY
- Complex filtering logic
- Aggregations (SUM, AVG)

## 💡 Query Structure

### CTE1: Total Sales by Product
Aggregates total units sold per product from order details.

### CTE2: Category Average
Calculates the average sales performance per category.

### Final Query
- Filters products selling above their category average
- Ranks products within each category using RANK()
- Orders by category and ranking

## 📈 Output Columns
- `categoria`: Product category
- `nombre_producto`: Product name
- `total_vendido`: Total units sold
- `promedio_categoria`: Category average sales
- `ranking_en_categoria`: Rank within category (1 = top performer)

## 🎓 Business Value
- **Inventory Management:** Focus stock on proven performers
- **Marketing Strategy:** Promote products that outperform their category
- **Product Development:** Understand what works in each segment
- **Performance Benchmarking:** Compare products against category baseline

## 🔗 File
`ecommerce_4_products_above_category_average.sql`
