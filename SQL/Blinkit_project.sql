-- CREATE DATABASE blinkit_project;
USE blinkit_project;
SELECT * FROM orders LIMIT 5;
SELECT * FROM order_items LIMIT 5;
SELECT * FROM Products LIMIT 5;
-- Total Revenue
SELECT 
SUM(total_sales) AS total_revenue
FROM order_items;

 -- Top 10 Products By Revenue
SELECT
product_name,
ROUND(SUM(Total_Sales),2) AS total_revenue
FROM order_items
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Catagory Revenue

SELECT
category,
ROUND(SUM(total_sales),2) AS total_revenue
FROM order_items
GROUP BY category
ORDER BY total_revenue DESC;


-- Most Ordered Products

SELECT 
product_name,
SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 10;

-- Brand/Supplier Performance

SELECT 
brand,
SUM(total_sales) AS revenue
FROM order_items
GROUP BY brand
ORDER BY revenue DESC
LIMIT 10;

-- Product Join
SELECT 
oi.order_id,
p.product_name,
p.category,
oi.quantity,
oi.total_sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
ORDER BY total_sales DESC;

-- Revenue Contribution %

SELECT 
category,
ROUND(SUM(total_sales),2) AS revenue,
ROUND(
SUM(total_sales)*100/
(SELECT SUM(total_sales) FROM order_items),2
) AS contribution_percentage
FROM order_items
GROUP BY category
ORDER BY contribution_percentage DESC;
SELECT VERSION();

-- Monthly Revenue
SELECT
    Month,
    ROUND(SUM(total_sales), 2) AS revenue
FROM order_items
GROUP BY Month
ORDER BY Month;

-- Average Order Value
SELECT
ROUND(
SUM(total_sales)/COUNT(DISTINCT order_id),2
) AS average_order_value
FROM order_items;

-- Top Product in Each Category (Window Function)
WITH ProductSales AS
(
SELECT
category,
product_name,
ROUND(SUM(total_sales),2) AS revenue,
DENSE_RANK() OVER
(
PARTITION BY category
ORDER BY ROUND(SUM(total_sales),2) DESC
) AS rn
FROM order_items
GROUP BY category,product_name
)

SELECT category, product_name, revenue
FROM ProductSales
WHERE rn=1
ORDER BY revenue DESC;

-- Revenue Classification
SELECT
product_name,
total_sales,
CASE
WHEN total_sales>=1000 THEN 'High Revenue'
WHEN total_sales>=500 THEN 'Medium Revenue'
ELSE 'Low Revenue'
END AS sales_category
FROM order_items;

-- Top 5 Brands
SELECT
Brand,
ROUND(SUM(total_sales),2) revenue
FROM order_items
GROUP BY Brand
ORDER BY revenue DESC
LIMIT 5;
















