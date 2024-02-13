USE online_store;

# Query 10. Function Extract client cards count
CREATE FUNCTION udf_customer_products_count(name VARCHAR(30)) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (SELECT COUNT(product_id)
            FROM orders_products op
                     JOIN orders o
                          ON o.id = op.order_id
                     JOIN customers c
                          ON c.id = o.customer_id
            WHERE c.first_name LIKE name);
END;

SELECT c.first_name,
       c.last_name,
       udf_customer_products_count('Shirley') AS `total_products`
FROM customers c
WHERE c.first_name = 'Shirley';


# Query 11.	Procedure Reduce price
CREATE PROCEDURE udp_reduce_price(category_name VARCHAR(50))
BEGIN
    DECLARE current_category_id INT;
    SET current_category_id = (SELECT id
                               FROM categories
                               WHERE name = category_name);

    UPDATE products p
        JOIN reviews r
            ON r.id = p.review_id
        JOIN categories c
            ON c.id = p.category_id
    SET p.price = p.price - p.price * 0.3
    WHERE r.rating < 4
      AND category_id = current_category_id;
END;

CALL udp_reduce_price ('Phones and tablets');