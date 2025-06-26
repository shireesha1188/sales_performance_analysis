--1.top 10 highest revenue generating products

SELECT TOP 10 product_id,category,SUM(sale_price) AS sales FROM orders
GROUP BY product_id,category
ORDER BY sales DESC;

--2.top 5 highest selling products in each region
WITH top_products AS (
    SELECT 
        product_id, 
        region, 
        SUM(sale_price) AS sales,
        RANK() OVER (PARTITION BY region ORDER BY SUM(sale_price) DESC) AS rank
    FROM orders
    GROUP BY region, product_id
) 
SELECT * 
FROM top_products
WHERE rank <= 5;

--total yearly analysis of sales trends
SELECT 
    FORMAT(order_date, 'MMM') AS month,
    SUM(sale_price) AS total_sales, 
    SUM(quantity) AS total_quantity,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / SUM(total_cost)) * 100,2) AS profit_percent
FROM orders
WHERE YEAR(order_date) = 2022
GROUP BY FORMAT(order_date, 'MMM'),MONTH(order_date)
ORDER BY MONTH(order_date);

--4.find every month total sales and growth comparison during 2022 and 2023

WITH CTE AS (
    SELECT 
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS month_number,
        DATENAME(MONTH, order_date) AS month,
        SUM(sale_price) AS sales 
    FROM orders
    GROUP BY YEAR(order_date), MONTH(order_date), DATENAME(MONTH, order_date)
)
SELECT 
    month,
    SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
    SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023,
    ROUND(SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) - 
          SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END), 2) AS sales_diff,
    ROUND(
        CASE 
            WHEN SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) = 0 THEN NULL
            ELSE 
                (SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) - 
                 SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END)) * 100.0 / 
                SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END)
        END, 2
    ) AS percent_change,
    CASE 
        WHEN SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) > 
             SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) THEN 'Increase'
        WHEN SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) < 
             SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) THEN 'Decrease'
        ELSE 'No Change'
    END AS status
FROM CTE
GROUP BY month, month_number
ORDER BY month_number;



--5.category wise monthly sales
WITH CTE AS (
SELECT category,FORMAT(order_date,'yyyyMM') AS order_year_month
, SUM(sale_price) AS sales 
FROM orders
GROUP BY category,FORMAT(order_date,'yyyyMM')

)
SELECT * FROM (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY category ORDER BY sales DESC) AS rn
FROM CTE
) a
WHERE rn = 1;

--6.total profit of every month in both years
SELECT 
    DATENAME(MONTH, order_date) AS month,
    SUM(CASE WHEN YEAR(order_date) = 2022 THEN profit ELSE 0 END) AS profit_2022,
    SUM(CASE WHEN YEAR(order_date) = 2023 THEN profit ELSE 0 END) AS profit_2023
FROM orders
WHERE YEAR(order_date) IN (2022, 2023)
GROUP BY MONTH(order_date), DATENAME(MONTH, order_date)
ORDER BY MONTH(order_date);
