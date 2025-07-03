# 📦 End-to-End Sales Data Analysis Project (Kaggle → Python → SQL Server → Power BI)

This project demonstrates a complete data analytics workflow — from raw data extraction and cleaning in Python, through advanced SQL-based analysis, to powerful visual storytelling using Power BI dashboards.

---

## 🧰 Tools & Technologies Used

- **Data Source**: [Kaggle](https://www.kaggle.com/datasets/ankitbansal06/retail-orders)
- **Data Cleaning & Transformation**: Python (Pandas)
- **Database**: SQL Server
- **Data Analysis**: T-SQL (Window Functions, CTEs, Aggregations, Pivots,sub_query)
- **Visualization**: Power BI

---

## 📌 Project Workflow

### 🔹 Step 1: Data Collection & Cleaning (Python)

- Imported raw sales data using `pandas`
- Handled:
  - Missing values
  - Incorrect data types (e.g., converting date columns)
  - Unifying inconsistent text values (e.g., `ship_mode`, `state`)
  - Generated new columns like `total_cost`, `profit_percent`,`sale_price`
  - Exported clean dataset to CSV and imported it into SQL Server

### 🔹 Step 2: SQL Analysis (SQL Server)

Performed comprehensive analysis using SQL queries, including:

#### ✅ Product & Category Insights
- Top 10 revenue-generating products
- Most expensive product in each category
- Best-selling sub-category by quantity per state

#### ✅ Region & State Performance
- Sales and profit trends by region
- State-wise profit margins for 2022 & 2023
- Regional sales by ship mode (pivot analysis)

#### ✅ Time-Series & Growth Trends
- Monthly sales and profit trends for 2022 & 2023
- Year-over-year growth comparisons
- Category-wise best sales months

#### ✅ Operational Metrics
- Total quantity sold by ship mode and region
- High-level trends using advanced SQL features (CTEs, window functions, pivot)

> 👉 Refer to [orders_1.sql] and [orders_2.sql] for complete query logic.

---

### 🔹 Step 3: Dashboarding in Power BI

Built an interactive Power BI dashboard to visualize insights:

- **Monthly Sales Trend Chart**
- **Profit % Comparison (2022 vs 2023)**
- **Top Products by Revenue**
- **Region-wise Ship Mode Usage**
- **State-wise Sales Heatmap**

> 📊 Power BI visuals allow dynamic filtering by year, region, month or category.

---

## 🔍 Key Insights

- 📈 Sales in 2023 showed a **notable increase** in the first half compared to 2022, indicating improved demand.
- 💸 Some states had **negative or very low profit margins**, possibly due to heavy discounts or less quantity.
- 🛍️ A few products generated **high revenue but low profit**, suggesting pricing strategy issues.
- 🚚 **Standard Class** was the most frequently used ship mode, while **Same Day** had minimal usage.
- 🌎 Certain regions consistently outperformed others in both **sales and profit**, recommending region-focused strategies.
- 🌎**East region** contributed the most to overall profit in 2023, while **South region** saw a decline in growth in both 2022,2023.


## 📁 Files in This Repository

| File Name        | Description |
|------------------|-------------|
| `orders.ipynb`   | Jupyter Notebook for initial data cleaning using Python |
| `orders_1.sql`   | SQL queries for product, category, and monthly trend analysis |
| `orders_2.sql`   | SQL queries for regional, state-wise, and operational analysis |
| `sales_overview.png`| Screenshot of exported report of final dashboard |
| `sales_summary.png`| Screenshot of exported report of final dashboard |
| `README.md`      | sales_performance_analysis overview |

---

## ✅ Conclusion

This project showcases end-to-end SQL-based analysis using real-world business metrics and industry-relevant tools . It demonstrates advanced querying skills, performance benchmarking, and valuable business intelligence insights. Visualizations in Power BI can further enhance this analysis with interactive dashboards.

-

**shireesha majji**  
_Data Analyst | SQL | Python | Power BI_  
[LinkedIn](#) | [GitHub](#) | [Portfolio](#)

