USE restaurant_db;

# Query 5. Select Clients
SELECT *
FROM clients
ORDER BY birthdate DESC, id DESC;

# Query 6. Select By Birthdate
SELECT first_name, last_name, birthdate, review
FROM clients
WHERE card IS NULL
  AND YEAR(birthdate) BETWEEN 1978 AND 1993
ORDER BY last_name DESC, id
LIMIT 5;

# Query 7. Select Accounts
SELECT CONCAT(last_name, first_name, CHARACTER_LENGTH(first_name), 'Restaurant') AS username,
       REVERSE(SUBSTRING(email, 2, 12))                                          AS password
FROM waiters
WHERE salary IS NOT NULL
ORDER BY `password` DESC;

# Query 8. Top from menu
SELECT product_id,
       p.name,
       (SELECT COUNT(*)
        FROM orders_products op1
        WHERE op1.product_id = op.product_id) AS `count`
FROM orders_products op
         JOIN products p
              ON p.id = op.product_id
GROUP BY product_id, p.name
HAVING `count` >= 5
ORDER BY `count` DESC, p.name;

# Query 9. Availability
SELECT t.id,
       capacity,
       COUNT(oc.client_id) AS count_clients,
       (CASE
            WHEN capacity > COUNT(oc.client_id)
                THEN 'Free seats'
            WHEN capacity = COUNT(oc.client_id)
                THEN 'Full'
            ELSE 'Extra seats'
           END)            AS availability
FROM tables t
         JOIN orders o
             ON t.id = o.table_id
         JOIN orders_clients oc
             ON o.id = oc.order_id
WHERE t.floor = 1
GROUP BY t.id
ORDER BY t.id DESC;