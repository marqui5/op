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
select distinct name from students where name not in (select name from students where score <= 80);
--备份
mysqldump -u root -ppasswd dbname >/home/dbname.sql     	 --备份库
mysqldump -u root -ppasswd dbname tablename>/home/tablename.sql  --备份表
mysqldump -u root -ppasswd --all-databases >/home/full.sql    	 --备份全库
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
--如果设置log_slave_updates，slave可以是其它slave的master，从而扩散master的更新
log-slave-updates=YES
--按表复制
replicate_wild_do_table=table_name.%
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
mysqldump -uroot -ppasswd --all-databases > /root/db.sql
--按库导出
mysqldump -uroot -ppasswd database_name >database_name.sql
--解锁主库
UNLOCK TABLES;
--导入主库数据到从库
mysql -uroot -p < db.sql
--按库导入
create database database_name;
use database_name;
source database_name.sql;
--登录
mysql -u root -padmin
--设置主从复制
change master to master_host='172.16.123.130',master_user='root',master_password='admin',master_log_file='master-bin.000002',master_log_pos= 245;
--开启主从复制
START SLAVE;
--查看从库状态
show slave status\G
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 172.16.123.130
                  Master_User: root
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: master-bin.000011
          Read_Master_Log_Pos: 465
               Relay_Log_File: relay-bin.000014
                Relay_Log_Pos: 750
        Relay_Master_Log_File: master-bin.000011
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 465
              Relay_Log_Space: 1323
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 130
1 row in set (0.00 sec)
