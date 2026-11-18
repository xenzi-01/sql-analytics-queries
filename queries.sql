-- 1. Revenue per product (JOIN + GROUP BY)
SELECT p.name, SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY revenue DESC;

-- 2. All products, including ones that never sold (LEFT JOIN)
SELECT p.name, COALESCE(SUM(oi.quantity), 0) AS units_sold
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY units_sold DESC;

-- 3. Categories with revenue above 10,000 (HAVING)
SELECT p.category, SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.category
HAVING SUM(oi.quantity * p.price) > 10000
ORDER BY revenue DESC;

-- 4. Monthly revenue
SELECT SUBSTR(o.order_date, 1, 7) AS month,
       SUM(oi.quantity * p.price) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY SUBSTR(o.order_date, 1, 7)
ORDER BY month;

-- 5. Top 3 customers by total spending
SELECT c.name, SUM(oi.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 3;

-- 6. Customers who have never ordered (LEFT JOIN + IS NULL)
SELECT c.name
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

-- 7. Revenue by city
SELECT c.city, SUM(oi.quantity * p.price) AS revenue
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY c.city
ORDER BY revenue DESC;

-- 8. Rank products by revenue (window function: RANK)
WITH product_revenue AS (
  SELECT p.name, p.category, SUM(oi.quantity * p.price) AS revenue
  FROM order_items oi
  JOIN products p ON p.product_id = oi.product_id
  GROUP BY p.name, p.category
)
SELECT name, revenue,
       RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM product_revenue;

-- 9. Rank products inside each category (PARTITION BY)
WITH product_revenue AS (
  SELECT p.name, p.category, SUM(oi.quantity * p.price) AS revenue
  FROM order_items oi
  JOIN products p ON p.product_id = oi.product_id
  GROUP BY p.name, p.category
)
SELECT category, name, revenue,
       RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rank_in_category
FROM product_revenue
ORDER BY category, rank_in_category;

-- 10. Running total of monthly revenue (SUM OVER)
WITH monthly AS (
  SELECT SUBSTR(o.order_date, 1, 7) AS month,
         SUM(oi.quantity * p.price) AS revenue
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p ON p.product_id = oi.product_id
  GROUP BY SUBSTR(o.order_date, 1, 7)
)
SELECT month, revenue,
       SUM(revenue) OVER (ORDER BY month) AS running_total
FROM monthly;

-- 11. Change from the previous month (LAG)
WITH monthly AS (
  SELECT SUBSTR(o.order_date, 1, 7) AS month,
         SUM(oi.quantity * p.price) AS revenue
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p ON p.product_id = oi.product_id
  GROUP BY SUBSTR(o.order_date, 1, 7)
)
SELECT month, revenue,
       LAG(revenue) OVER (ORDER BY month) AS previous_month,
       revenue - LAG(revenue) OVER (ORDER BY month) AS change
FROM monthly;

-- 12. Orders worth more than the average order (subquery)
WITH order_totals AS (
  SELECT o.order_id, SUM(oi.quantity * p.price) AS total
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p ON p.product_id = oi.product_id
  GROUP BY o.order_id
)
SELECT order_id, total
FROM order_totals
WHERE total > (SELECT AVG(total) FROM order_totals)
ORDER BY total DESC;
