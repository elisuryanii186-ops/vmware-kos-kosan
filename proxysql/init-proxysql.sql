-- ProxySQL Initialization Script
-- Website Kos-Kosan - Cloud Computing Architecture
-- This script configures ProxySQL for the first time

-- ==========================================
-- 1. Configure MySQL Servers (Backend)
-- ==========================================

DELETE FROM mysql_servers;

INSERT INTO mysql_servers (hostgroup_id, hostname, port, weight, max_connections, comment)
VALUES 
    (0, 'mysql', 3306, 1, 200, 'MySQL Master Server - Koskosan DB');

-- Load to runtime and save to disk
LOAD MYSQL SERVERS TO RUNTIME;
SAVE MYSQL SERVERS TO DISK;

-- ==========================================
-- 2. Configure MySQL Users
-- ==========================================

DELETE FROM mysql_users;

-- Root user (for admin operations)
INSERT INTO mysql_users (username, password, default_hostgroup, max_connections, default_schema, active, comment)
VALUES 
    ('root', 'root', 0, 100, 'koskosan_db', 1, 'Root user for application'),
    ('koskosan_user', 'koskosan_pass', 0, 100, 'koskosan_db', 1, 'Application user');

-- Load to runtime and save to disk
LOAD MYSQL USERS TO RUNTIME;
SAVE MYSQL USERS TO DISK;

-- ==========================================
-- 3. Configure Query Rules
-- ==========================================

DELETE FROM mysql_query_rules;

-- Rule 1: SELECT FOR UPDATE to master (write operations)
INSERT INTO mysql_query_rules (rule_id, active, match_digest, destination_hostgroup, apply, comment)
VALUES 
    (1, 1, '^SELECT.*FOR UPDATE$', 0, 1, 'SELECT FOR UPDATE to master');

-- Rule 2: Regular SELECT queries
INSERT INTO mysql_query_rules (rule_id, active, match_pattern, destination_hostgroup, apply, comment)
VALUES 
    (2, 1, '^SELECT', 0, 1, 'Route SELECT queries to hostgroup 0');

-- Rule 3: INSERT queries to master
INSERT INTO mysql_query_rules (rule_id, active, match_pattern, destination_hostgroup, apply, comment)
VALUES 
    (3, 1, '^INSERT', 0, 1, 'Route INSERT to master');

-- Rule 4: UPDATE queries to master
INSERT INTO mysql_query_rules (rule_id, active, match_pattern, destination_hostgroup, apply, comment)
VALUES 
    (4, 1, '^UPDATE', 0, 1, 'Route UPDATE to master');

-- Rule 5: DELETE queries to master
INSERT INTO mysql_query_rules (rule_id, active, match_pattern, destination_hostgroup, apply, comment)
VALUES 
    (5, 1, '^DELETE', 0, 1, 'Route DELETE to master');

-- Rule 6: CREATE queries to master
INSERT INTO mysql_query_rules (rule_id, active, match_pattern, destination_hostgroup, apply, comment)
VALUES 
    (6, 1, '^CREATE', 0, 1, 'Route CREATE to master');

-- Rule 7: ALTER queries to master
INSERT INTO mysql_query_rules (rule_id, active, match_pattern, destination_hostgroup, apply, comment)
VALUES 
    (7, 1, '^ALTER', 0, 1, 'Route ALTER to master');

-- Rule 8: DROP queries to master
INSERT INTO mysql_query_rules (rule_id, active, match_pattern, destination_hostgroup, apply, comment)
VALUES 
    (8, 1, '^DROP', 0, 1, 'Route DROP to master');

-- Load to runtime and save to disk
LOAD MYSQL QUERY RULES TO RUNTIME;
SAVE MYSQL QUERY RULES TO DISK;

-- ==========================================
-- 4. Configure MySQL Variables (Optional)
-- ==========================================

UPDATE global_variables SET variable_value='monitor' WHERE variable_name='mysql-monitor_username';
UPDATE global_variables SET variable_value='monitor' WHERE variable_name='mysql-monitor_password';
UPDATE global_variables SET variable_value='2000' WHERE variable_name='mysql-monitor_history';
UPDATE global_variables SET variable_value='60000' WHERE variable_name='mysql-monitor_connect_interval';
UPDATE global_variables SET variable_value='10000' WHERE variable_name='mysql-monitor_ping_interval';
UPDATE global_variables SET variable_value='10' WHERE variable_name='mysql-connect_retries_on_failure';

LOAD MYSQL VARIABLES TO RUNTIME;
SAVE MYSQL VARIABLES TO DISK;

-- ==========================================
-- 5. Verify Configuration
-- ==========================================

SELECT * FROM mysql_servers;
SELECT username, default_hostgroup, max_connections, default_schema FROM mysql_users;
SELECT rule_id, active, match_pattern, destination_hostgroup, comment FROM mysql_query_rules ORDER BY rule_id;

-- ==========================================
-- Configuration Complete!
-- ==========================================
