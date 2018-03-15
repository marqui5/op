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
--建库
create database aaa;
--建表
create table students(
    name varchar(60),
    course varchar(120),
    score int(3)
    );
--插入数据
insert into students (name, course, score) values ('ada', 'math', 86);
--查询
select * from students;
--查询出每门课程的成绩都大于80的学生姓名
select distinct name frome students where name not in (select name from students where score <= 80);

--配置主从复制
--修改主服务器配置文件
vim /etc/my.cnf
[mysqld]
innodb_file_per_table=NO
log-bin=/var/lib/mysql/master-bin
binlog_format=mixed
server-id=130
--修改从服务器配置文件
[mysqld]
innodb_file_per_table=NO
server-id=131
relay-log=/var/lib/mysql/relay-bin
--重启mariadb
systemctl restart mariadb
--登录主服务器
mysql -u root -padmin
--创建帐号并赋予replication的权限
GRANT REPLICATION SLAVE ON *.* TO 'root'@'172.16.123.131' IDENTIFIED BY 'admin';
--备份主数据库数据，用于导入到从数据库中
--加锁
FLUSH TABLES WITH READ LOCK;
--备份主库
mysqldump -uroot -p --all-databases > /root/db.sql
--导入主库数据到从库

