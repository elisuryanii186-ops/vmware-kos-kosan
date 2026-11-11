-- Enable ProxySQL Web Interface
-- Run this if web stats not accessible at http://localhost:6080/stats

-- Set web_enabled to true
UPDATE global_variables SET variable_value='true' WHERE variable_name='admin-web_enabled';

-- Set web_port to 6080
UPDATE global_variables SET variable_value='6080' WHERE variable_name='admin-web_port';

-- Set stats credentials
UPDATE global_variables SET variable_value='stats:stats' WHERE variable_name='admin-stats_credentials';

-- Enable various stats
UPDATE global_variables SET variable_value='60' WHERE variable_name='admin-stats_mysql_connections';
UPDATE global_variables SET variable_value='60' WHERE variable_name='admin-stats_mysql_connection_pool';
UPDATE global_variables SET variable_value='60' WHERE variable_name='admin-stats_mysql_query_cache';

-- Load to runtime
LOAD ADMIN VARIABLES TO RUNTIME;

-- Save to disk
SAVE ADMIN VARIABLES TO DISK;

-- Verify settings
SELECT variable_name, variable_value 
FROM global_variables 
WHERE variable_name LIKE '%web%' OR variable_name LIKE '%stats%';

SELECT 'Web interface should now be accessible at http://localhost:6080/stats' AS message;
