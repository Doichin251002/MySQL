USE soft_uni;

# Query 8. Find Full Name
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
    SELECT CONCAT_WS(' ', first_name, last_name) AS full_name
    FROM account_holders
    ORDER BY full_name, id;
END;

CALL usp_get_holders_full_name();

# Query 9. People with Balance Higher Than
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(salary DECIMAL(19, 4))
BEGIN
    SELECT first_name, last_name
    FROM account_holders ah
             JOIN accounts a ON ah.id = a.account_holder_id
    GROUP BY account_holder_id
    HAVING SUM(a.balance) > salary
    ORDER BY account_holder_id;
END;

SET @salary_limit = 7000;
CALL usp_get_holders_with_balance_higher_than(@salary_limit);

# Query 10. Future Value Function
CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19, 4), yearly_interest_rate DECIMAL(4, 2), years INT) RETURNS DECIMAL(19, 4)
    DETERMINISTIC
BEGIN
    RETURN sum * (POW((1 + yearly_interest_rate), years));
END;

SET @initial_sum = 1000;
SET @yearly_interest_rate = 0.5;
SET @years = 5;

SELECT ufn_calculate_future_value(@initial_sum, @yearly_interest_rate, @years);

# Query 11. Calculating Interest
CREATE PROCEDURE usp_calculate_future_value_for_account(account_id INT, interest_rate DECIMAL(19, 4))
BEGIN
    SELECT a.id,
           ah.first_name,
           ah.last_name,
           a.balance AS currency_balance,
           (SELECT ufn_calculate_future_value(a.balance, interest_rate, 5)) AS balance_in_5_years
    FROM account_holders AS ah
             JOIN accounts a ON ah.id = a.account_holder_id
    WHERE a.id = account_id;
END;

SET @account_id_1 = 1;
SET @yearly_interest_rate = 0.1;

CALL usp_calculate_future_value_for_account(@account_id_1, @yearly_interest_rate);

# Query 12. Deposit Money
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
    START TRANSACTION;
    IF (money_amount <= 0) THEN
        ROLLBACK;
    ELSE
        UPDATE accounts
        SET balance = balance + money_amount
        WHERE id = account_id;
    END IF;
END;

SET @money_amount = 10;

CALL usp_deposit_money(@account_id_1, @money_amount);

SELECT *
FROM accounts
WHERE id = @account_id_1;

# Query 13. Withdraw Money
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
    START TRANSACTION;
    IF ((SELECT (balance - money_amount)
         FROM accounts
         WHERE id = account_id) < 0)
        OR (money_amount <= 0) THEN
        ROLLBACK;
    ELSE
        UPDATE accounts
        SET balance = balance - money_amount
        WHERE id = account_id;
    END IF;
END;

CALL usp_withdraw_money(@account_id_1, @money_amount);

SELECT *
FROM accounts
WHERE id = @account_id_1;

# Query 14. Money Transfer
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, money_amount DECIMAL(19, 4))
BEGIN
    START TRANSACTION;
    IF (from_account_id NOT IN (SELECT id FROM accounts)) OR (to_account_id NOT IN (SELECT id FROM accounts)) OR
       ((SELECT (balance - money_amount)
         FROM accounts
         WHERE id = from_account_id) < 0)
           OR (money_amount <= 0) THEN
        ROLLBACK;
    ELSE
        UPDATE accounts
        SET balance = balance - money_amount
        WHERE id = from_account_id;

        UPDATE accounts
        SET balance = balance + money_amount
        WHERE id = to_account_id;
    END IF;
END;

SET @account_id_2 = 2;

CALL usp_transfer_money(@account_id_1, @account_id_2, @money_amount);

SELECT *
FROM accounts
WHERE id IN (1, 2);

# Query 15. Log Accounts Trigger
CREATE TABLE logs
(
    log_id     INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    old_sum    DECIMAL(19, 4),
    new_sum    DECIMAL(19, 4)
);

CREATE TRIGGER tr_balance_updated
    AFTER UPDATE
    ON accounts
    FOR EACH ROW
BEGIN
    IF (old.balance <> new.balance) THEN
        INSERT logs(account_id, old_sum, new_sum)
            VALUE (old.id, old.balance, new.balance);
    END IF;
END;

CALL usp_transfer_money(1, 2, 10);
CALL usp_transfer_money(2, 1, 10);

SELECT *
FROM logs;

# Query 16. Emails Trigger
CREATE TABLE notification_emails
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT,
    subject   TEXT,
    body      TEXT
);

CREATE TRIGGER tr_notification_emails
    AFTER INSERT
    ON logs
    FOR EACH ROW
BEGIN
    INSERT INTO notification_emails(recipient, subject, body)
    VALUES (new.account_id,
            CONCAT('Balance change for account: ', new.account_id),
            CONCAT_WS(' ', 'On', DATE_FORMAT(NOW(), '%b %d %y at %r'),
                      'your balance was changed from', new.old_sum, 'to', new.new_sum));
END;

SELECT *
FROM notification_emails;