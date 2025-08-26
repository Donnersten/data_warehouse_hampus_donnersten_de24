SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS demo_db;
USE DATABASE demo_db;

SHOW SCHEMAS;

CREATE SCHEMA IF NOT EXISTS demo_db.staging;

SHOW SCHEMAS IN demo_db ;

CREATE TABLE IF NOT EXISTS customer (
    customer_id INT PRIMARY KEY,
    age INT,
    email VARCHAR(50)
);

SHOW TABLES;

SELECT * FROM customer;

USE WAREHOUSE COMPUTE_WH;

INSERT INTO customer (customer_id, age, email) VALUES
(1, 25, 'test@mail.com'),
(2, 30, '123@mail.com');

SELECT * FROM customer;

DROP DATABASE demo_db;

SHOW DATABASES;