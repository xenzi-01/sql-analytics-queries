-- Tables
CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  city TEXT NOT NULL
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  price INTEGER NOT NULL
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date TEXT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE order_items (
  item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders (order_id),
  FOREIGN KEY (product_id) REFERENCES products (product_id)
);

-- Sample data
INSERT INTO customers VALUES (1, 'Ade', 'Ilorin');
INSERT INTO customers VALUES (2, 'Bola', 'Lagos');
INSERT INTO customers VALUES (3, 'Chika', 'Abuja');
INSERT INTO customers VALUES (4, 'Dayo', 'Ilorin');
INSERT INTO customers VALUES (5, 'Efe', 'Lagos');
INSERT INTO customers VALUES (6, 'Fatima', 'Kano');

INSERT INTO products VALUES (1, 'Notebook', 'Stationery', 500);
INSERT INTO products VALUES (2, 'Pen Pack', 'Stationery', 300);
INSERT INTO products VALUES (3, 'Backpack', 'Bags', 8000);
INSERT INTO products VALUES (4, 'Phone Case', 'Accessories', 1500);
INSERT INTO products VALUES (5, 'Earphones', 'Electronics', 4500);
INSERT INTO products VALUES (6, 'Power Bank', 'Electronics', 9000);
INSERT INTO products VALUES (7, 'Desk Lamp', 'Home', 6000);
INSERT INTO products VALUES (8, 'Water Bottle', 'Home', 2500);

INSERT INTO orders VALUES (1, 1, '2026-01-05');
INSERT INTO orders VALUES (2, 2, '2026-01-12');
INSERT INTO orders VALUES (3, 1, '2026-02-03');
INSERT INTO orders VALUES (4, 3, '2026-02-14');
INSERT INTO orders VALUES (5, 4, '2026-02-20');
INSERT INTO orders VALUES (6, 2, '2026-03-02');
INSERT INTO orders VALUES (7, 5, '2026-03-09');
INSERT INTO orders VALUES (8, 1, '2026-03-15');
INSERT INTO orders VALUES (9, 3, '2026-04-01');
INSERT INTO orders VALUES (10, 4, '2026-04-10');
INSERT INTO orders VALUES (11, 2, '2026-04-22');
INSERT INTO orders VALUES (12, 1, '2026-05-06');

INSERT INTO order_items VALUES (1, 1, 1, 4);
INSERT INTO order_items VALUES (2, 1, 2, 2);
INSERT INTO order_items VALUES (3, 2, 3, 1);
INSERT INTO order_items VALUES (4, 2, 4, 2);
INSERT INTO order_items VALUES (5, 3, 5, 1);
INSERT INTO order_items VALUES (6, 4, 6, 1);
INSERT INTO order_items VALUES (7, 4, 1, 3);
INSERT INTO order_items VALUES (8, 5, 7, 1);
INSERT INTO order_items VALUES (9, 6, 5, 2);
INSERT INTO order_items VALUES (10, 7, 3, 1);
INSERT INTO order_items VALUES (11, 7, 2, 5);
INSERT INTO order_items VALUES (12, 8, 6, 1);
INSERT INTO order_items VALUES (13, 9, 4, 3);
INSERT INTO order_items VALUES (14, 10, 7, 2);
INSERT INTO order_items VALUES (15, 10, 1, 2);
INSERT INTO order_items VALUES (16, 11, 5, 1);
INSERT INTO order_items VALUES (17, 11, 4, 1);
INSERT INTO order_items VALUES (18, 12, 3, 1);
INSERT INTO order_items VALUES (19, 12, 6, 1);
