
USE ROLE USERADMIN;
CREATE ROLE IF NOT EXISTS marketing_dlt_role;

-- grant role to user
USE ROLE SECURITYADMIN;


GRANT USAGE ON WAREHOUSE marketing_wh TO ROLE marketing_dlt_role;
GRANT USAGE ON DATABASE ifood TO ROLE marketing_dlt_role;
GRANT USAGE ON SCHEMA ifood.staging TO ROLE marketing_dlt_role;

GRANT ROLE marketing_dlt_role TO USER extract_loader_ifood;

SHOW GRANTS ON SCHEMA ifood.staging;

GRANT CREATE TABLE ON SCHEMA ifood.staging TO ROLE marketing_dlt_role;
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA ifood.staging TO ROLE marketing_dlt_role;
GRANT INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA ifood.staging TO ROLE marketing_dlt_role;


USE ROLE useradmin;
CREATE ROLE IF NOT EXISTS ifood_reader;

USE ROLE securityadmin;

GRANT USAGE ON WAREHOUSE marketing_wh TO ROLE ifood_reader;
GRANT USAGE ON DATABASE ifood TO ROLE ifood_reader;
GRANT USAGE ON SCHEMA ifood.staging TO ROLE ifood_reader;

GRANT SELECT ON ALL TABLES IN SCHEMA ifood.staging TO ROLE ifood_reader;
GRANT SELECT ON FUTURE TABLES IN DATABASE ifood TO ROLE ifood_reader;

GRANT ROLE ifood_reader TO USER DONNERSTEN;