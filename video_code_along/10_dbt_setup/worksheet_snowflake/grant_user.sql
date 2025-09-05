USE ROLE USERADMIN;

CREATE ROLE if not exists job_ads_dbt_role;

GRANT ROLE job_ads_dbt_role TO USER transformer;
GRANT ROLE job_ads_dbt_role TO USER donnersten;