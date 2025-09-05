SHOW ROLES;

USE ROLE job_ads_dlt_role;

USE SCHEMA job_ads.staging;

SHOW TABLES;

DESC TABLE data_field_job_ads;

use warehouse dev_wh;

SELECT * FROM data_field_job_ads;

SELECT 
    relevance, WORKPLACE_ADDRESS__STREET_ADDRESS, WORKPLACE_ADDRESS__POSTCODE, publication_date, webpage_url, source_type
FROM data_field_job_ads
LIMIT 5;

SELECT
    SCOPE_OF_WORK__MIN, SCOPE_OF_WORK__MAX, employer__name, salary_type__label, salary_description, duration__label, logo_url, employer__workplace, employer__url
FROM data_field_job_ads;

SELECT DISTINCT(salary_description) as different_salary_descriptions
FROM data_field_job_ads;