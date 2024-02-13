USE online_store;

# Query 5. Select Categories
SELECT *
FROM categories
ORDER BY name DESC;

# Query 6. Select Quantity
SELECT id,
       brand_id,
       name,
       quantity_in_stock
FROM products
WHERE price > 1000
  AND quantity_in_stock < 30
ORDER BY quantity_in_stock, id;

# Query 7. Review
SELECT id,
       content,
       rating,
       picture_url,
       published_at
FROM reviews
WHERE content LIKE 'My%'
  AND CHAR_LENGTH(content) > 61
ORDER BY rating DESC;

# Query 8. First customers
SELECT CONCAT_WS(' ', c.first_name, c.last_name) AS full_name,
       c.address,
       order_datetime
FROM customers c
         JOIN orders o
              ON c.id = o.customer_id
WHERE year(o.order_datetime) <= 2018
ORDER BY full_name DESC;

# Query 9. Best categories
SELECT COUNT(p.category_id)     AS items_count,
       c.name,
       SUM(p.quantity_in_stock) AS total_quantity
FROM products p
         JOIN categories c ON c.id = p.category_id
GROUP BY p.category_id
ORDER BY items_count DESC, total_quantity
LIMIT 5;