--登录
mysql
--带密码登录
mysql -u root -h 127.0.0.1 -p password
--查询当前用户
select user();
--显示所有数据库
show databases;
--切换数据库
use mysql;
--显示所有数据表
show tables;
--查看表结构
describe user;
--查询
select * from user;
