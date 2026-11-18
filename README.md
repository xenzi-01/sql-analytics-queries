
# SQL Analytics Queries

A small sales database with sample data and 12 queries that answer common business questions.

## Database
Four tables: `customers`, `products`, `orders` and `order_items`.

## What the queries cover
- JOINs across several tables
- LEFT JOIN to find missing data (unsold products, customers with no orders)
- GROUP BY and HAVING
- Monthly revenue
- Window functions: RANK, PARTITION BY, running total (SUM OVER) and LAG
- CTEs (WITH) and subqueries

## How to run
1. Open an online SQL editor such as sqliteonline.com, or use any SQLite, MySQL or PostgreSQL database
2. Run everything in `schema.sql` to create the tables and sample data
3. Run the queries in `queries.sql` one at a time

Window functions need SQLite 3.25 or newer, MySQL 8 or newer, or PostgreSQL.

## Files
- `schema.sql`: tables and sample data
- `queries.sql`: the 12 queries with comments

## Author
Abdullahi Lawal (xenzi-01)
