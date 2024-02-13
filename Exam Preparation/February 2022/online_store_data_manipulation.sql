USE online_store;

# Query 2. Insert
INSERT INTO reviews (content, rating, picture_url, published_at)
SELECT LEFT(p.description, 15),
       p.price / 8,
       REVERSE(p.name),
       DATE('2010-10-10')
FROM products p
WHERE p.id >= 5;

# Query 3. Update
UPDATE products
SET quantity_in_stock = quantity_in_stock - 5
WHERE quantity_in_stock BETWEEN 60 AND 70;

# Query 4. Delete
DELETE
FROM customers
WHERE id NOT IN (SELECT customer_id FROM orders);