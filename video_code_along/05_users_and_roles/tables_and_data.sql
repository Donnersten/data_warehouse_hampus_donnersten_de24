USE ROLE ICE_CREAM_WRITER;

USE WAREHOUSE dev_wh;

USE SCHEMA ice_cream_db.public;


USE ROLE SYSADMIN;
REVOKE INSERT ON ALL TABLES IN SCHEMA ice_cream_db.public FROM ROLE ICE_CREAM_READER;
REVOKE INSERT ON FUTURE TABLES IN SCHEMA ice_cream_db.public FROM ROLE ICE_CREAM_READER;


DROP TABLE CUSTOMERS;

DROP TABLE FLAVORS;


SELECT CURRENT_ROLE();

USE ROLE ICE_CREAM_WRITER;

CREATE TABLE flavors (
    flavor_id INT AUTOINCREMENT,
    flavor_name STRING,
    price DECIMAL(5, 2),
    PRIMARY KEY (flavor_id)
);

CREATE TABLE customers (
    customer_id INT AUTOINCREMENT,
    customer_name STRING,
    email STRING,
    PRIMARY KEY (customer_id)
);


CREATE TABLE transactions (
    transaction_id INT AUTOINCREMENT,
    customer_id INT,
    flavor_id INT,
    quantity INT,
    transaction_date TIMESTAMP,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (flavor_id) REFERENCES flavors (flavor_id)
);

INSERT INTO flavors (flavor_name, price) VALUES
('Vanilla', 2.50),
('Chocolate', 2.75),
('Strawberry', 2.50),
('Mint Chocolate Chip', 3.00),
('Cookie Dough', 3.25);

INSERT INTO customers (customer_name, email) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Alice Johnson', 'alice.johnson@example.com');

INSERT INTO transactions (
    customer_id, flavor_id, quantity, transaction_date
) VALUES
(1, 1, 2, CURRENT_TIMESTAMP),
(2, 2, 1, CURRENT_TIMESTAMP),
(3, 3, 3, CURRENT_TIMESTAMP),
(1, 4, 1, CURRENT_TIMESTAMP),
(2, 5, 2, CURRENT_TIMESTAMP);

SELECT * FROM flavors;

SELECT * FROM customers;

SELECT * FROM transactions;

USE ROLE ICE_CREAM_READER;

SELECT * FROM flavors;

INSERT INTO customers (customer_name, email) VALUES
('John Doe2', 'john.doe@example.com');

DELETE FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    ORDER BY customer_id DESC
    LIMIT 1
);

SELECT * FROM customers;

SHOW GRANTS TO USER DONNERSTEN;

SHOW GRANTS TO ROLE ICE_CREAM_READER;

SHOW GRANTS OF ROLE ICE_CREAM_READER;

SHOW GRANTS TO USER DONNERSTEN;