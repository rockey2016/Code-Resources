--创建用户
CREATE USER dsmart WITH PASSWORD 'dsmart'

--创建角色
CREATE ROLE test

--修改用户权限 
ALTER ROLE dsmart WITH privileges;
--常见数据库
CREATE DATABASE test OWNER dsmart;

--将test数据库的权限赋予给test角色
GRANT ALL PRIVILEGES ON DATABASE test to test

SHOW ALL;