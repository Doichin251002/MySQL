USE restaurant_db;

# Query 10. Function Extract bill
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50))
    RETURNS DECIMAL(10, 2)
    DETERMINISTIC
BEGIN
    DECLARE current_client_id INT;
    SET current_client_id = ( SELECT id
                              FROM clients
                              WHERE CONCAT_WS(' ', first_name, last_name) = full_name );

    RETURN ( SELECT SUM(p.price)
             FROM orders_products op
                      JOIN products p
                          ON op.product_id = p.id
                      JOIN orders_clients oc
                          ON op.order_id = oc.order_id
             WHERE oc.client_id = current_client_id );
END;

SELECT c.first_name,
       c.last_name,
       udf_client_bill('Silvio Blyth') AS 'bill'
FROM clients c
WHERE c.first_name = 'Silvio'
  AND c.last_name= 'Blyth';

# Query 11. Procedure Happy Hour
CREATE PROCEDURE udp_happy_hour(type VARCHAR(50))
BEGIN
    DECLARE lower_limit_price DECIMAL(10, 2);
    SET lower_limit_price = 10;

    UPDATE products p
    SET price = price - price * 0.2
    WHERE p.type LIKE type
      AND price >= lower_limit_price;
END;

CALL udp_happy_hour ('Cognac');