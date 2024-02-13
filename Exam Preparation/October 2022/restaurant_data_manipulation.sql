USE restaurant_db;

# Query 2. Insert
INSERT INTO products(name, type, price)
    (SELECT CONCAT(last_name, ' specialty'),
            'Cocktail',
            CEILING(salary * 0.01)
     FROM waiters
     WHERE id > 6 );

# Query 3. Update
UPDATE orders
SET table_id = table_id - 1
WHERE id BETWEEN 12 AND 23;

# Query 4. Delete
DELETE
FROM waiters w
WHERE ( SELECT count(*)
        FROM orders o
        WHERE o.waiter_id = w.id) = 0;