DROP DATABASE IF EXISTS banking_records;

CREATE DATABASE banking_records;
USE banking_records;

CREATE TABLE bank_transactions (
    txn_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    branch_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    transaction_date DATE
);

ALTER TABLE bank_transactions
ADD account_no VARCHAR(20);

ALTER TABLE bank_transactions
MODIFY customer_name VARCHAR(100);

RENAME TABLE bank_transactions
TO customer_transactions;

TRUNCATE TABLE customer_transactions;

SELECT * FROM customer_transactions;

CREATE TABLE customer_transactions_backup AS
SELECT * FROM customer_transactions;

INSERT INTO customer_transactions
(txn_id, customer_name, branch_name, transaction_type, amount, transaction_date)
VALUES
(201, 'Arjun', 'Secunderabad', 'Deposit', 6500, '2024-02-03'),
(202, 'Meera', 'Warangal', 'Withdrawal', 2800, '2024-02-05'),
(203, 'Vikram', 'Hyderabad', 'Deposit', 14500, '2024-02-07'),
(204, 'Nisha', 'Karimnagar', 'Deposit', 9200, '2024-02-09'),
(205, 'Aditya', 'Secunderabad', 'Withdrawal', 4100, '2024-02-11'),
(206, 'Kavya', 'Warangal', 'Deposit', 16800, '2024-02-13'),
(207, 'Rohan', 'Hyderabad', 'Withdrawal', 1750, '2024-02-15'),
(208, 'Divya', 'Karimnagar', 'Deposit', 10500, '2024-02-17'),
(209, 'Aman', 'Secunderabad', 'Withdrawal', 4600, '2024-02-19'),
(210, 'Isha', 'Warangal', 'Deposit', 13200, '2024-02-21');

INSERT INTO customer_transactions
(txn_id, customer_name, branch_name, transaction_type, amount, transaction_date)
VALUES
(211, 'Varun', 'Hyderabad', 'Deposit', 7800, '2024-02-24');

UPDATE customer_transactions
SET amount = 5700
WHERE txn_id = 205;

DELETE FROM customer_transactions
WHERE txn_id = 211;

SELECT * FROM customer_transactions;

SELECT *
FROM customer_transactions
WHERE transaction_type = 'Deposit';

SELECT *
FROM customer_transactions
ORDER BY amount DESC;

CREATE USER IF NOT EXISTS 'BankAdmin'@'localhost'
IDENTIFIED BY 'bank456';

CREATE USER IF NOT EXISTS 'ReportViewer'@'localhost'
IDENTIFIED BY 'report456';

GRANT ALL PRIVILEGES
ON banking_records.customer_transactions
TO 'BankAdmin'@'localhost';

GRANT SELECT
ON banking_records.customer_transactions
TO 'ReportViewer'@'localhost';

REVOKE SELECT
ON banking_records.customer_transactions
FROM 'ReportViewer'@'localhost';

REVOKE ALL PRIVILEGES
ON banking_records.customer_transactions
FROM 'BankAdmin'@'localhost';

START TRANSACTION;

UPDATE customer_transactions
SET amount = 7200
WHERE txn_id = 201;

SAVEPOINT Before_Update;

UPDATE customer_transactions
SET amount = 88888
WHERE txn_id = 202;

ROLLBACK TO Before_Update;

UPDATE customer_transactions
SET amount = 7600
WHERE txn_id = 201;

SAVEPOINT SP1;

UPDATE customer_transactions
SET amount = 9500
WHERE txn_id = 202;

ROLLBACK TO SP1;

COMMIT;