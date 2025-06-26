--1.most expensive products in each category
SELECT product_id, category, list_price, rank
FROM (
    SELECT product_id, category, list_price,
           RANK() OVER (PARTITION BY category ORDER BY list_price DESC) AS rank
    FROM orders
) ranked
WHERE rank = 1;

--2.total sales and total profit by each region
select region,SUM(quantity) as total_quantity,sum(sale_price) as sales,sum(profit) as total_profit from orders 
group by region
ORDER BY total_profit DESC;

-- 3.sales trends according to each state in 2022
select state,SUM(sale_price) as total_sales,SUM(profit) as total_profit from orders
WHERE YEAR(order_date)=2022
GROUP BY state;

--4.total ship_mode sales of each region
  SELECT * FROM (
    SELECT 
        region, 
        ship_mode, 
        SUM(quantity) AS total_quantity
    FROM orders
    WHERE ship_mode IN ('Standard Class', 'Second Class', 'First Class', 'Same Day','unknown','Not Available')
    GROUP BY region, ship_mode
) AS source_table
PIVOT (
    SUM(total_quantity)
    FOR ship_mode IN ([Standard Class], [Second Class], [First Class], [Same Day],[unknown],[Not Available])
) AS pivot_table;

---5.top-selling sub-category in terms of quantity in each state 

WITH CTE AS(

SELECT state,sub_category,SUM(quantity) AS total_quantity ,
RANK() OVER(PARTITION BY state ORDER BY SUM(quantity) DESC) AS rank FROM orders
GROUP BY state,sub_category
)
SELECT * FROM CTE
WHERE rank=1

--6.profit percent of each state in 2022 & 2023
SELECT 
    state,
    ROUND(SUM(CASE WHEN YEAR(order_date) = 2022 THEN profit END) / NULLIF(SUM(CASE WHEN YEAR(order_date) = 2022 THEN total_cost END), 0) * 100, 2) AS profit_percent_2022,
    ROUND(SUM(CASE WHEN YEAR(order_date) = 2023 THEN profit END) / NULLIF(SUM(CASE WHEN YEAR(order_date) = 2023 THEN total_cost END), 0) * 100, 2) AS profit_percent_2023
FROM orders
WHERE YEAR(order_date) IN (2022, 2023)
GROUP BY state
ORDER BY state;

--7.Which state generated the highest sales revenue for each sub-category

WITH subcategory_state_sales AS (
    SELECT 
        sub_category,
        state,
        SUM(sale_price) AS total_sales
    FROM orders
    GROUP BY sub_category, state
),
ranked AS (
    SELECT 
        *,
        RANK() OVER (PARTITION BY sub_category ORDER BY total_sales DESC) AS rank
    FROM subcategory_state_sales
)
SELECT *
FROM ranked
WHERE rank = 1;
