-- Create Monitor User in MySQL
-- This user is used by ProxySQL to monitor MySQL backend health

-- Connect to MySQL and run this script:
-- mysql -h localhost -P 3306 -u root -proot < monitor-user.sql

USE mysql;

-- Create monitor user
CREATE USER IF NOT EXISTS 'monitor'@'%' IDENTIFIED BY 'monitor';

-- Grant necessary privileges
GRANT SELECT, REPLICATION CLIENT ON *.* TO 'monitor'@'%';

-- Apply changes
FLUSH PRIVILEGES;

SELECT 'Monitor user created successfully!' AS status;
