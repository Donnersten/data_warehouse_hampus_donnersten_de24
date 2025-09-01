
USE ROLE ifood_reader;

USE DATABASE ifood;

SHOW SCHEMAS;

USE SCHEMA staging;

SHOW TABLES;

USE WAREHOUSE marketing_wh;

SELECT * FROM ifood.staging.ifood_marketing LIMIT 10;