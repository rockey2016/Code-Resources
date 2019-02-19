# Postgresql10-3安装

## 编译

./configure --prefix=/home/postgresq10 --with-wal-segsize=256 --with-blocksize=16

yum -y install gcc expect zlib-devel libffi-devel openssl-devel readline-devel libaio lsof sysstat unzip

make -j4 && make install

## 添加root环境变量

PATH=/home/postgresq10/bin:$PATH
export PATH

MANPATH=/home/postgresq10/share:$MANPATH
export MANPATH

## 添加用户与组

```
groupadd postgres
groupadd dba
useradd -g postgres -G dba postgres
```

## 修改配置

```
export PGPORT=5432
export PGDATA=/home/postgres/data
export LANG=en_US.utf8
export PGHOME=/home/postgres
export LD_LIBRARY_PATH=$PGHOME/lib:/lib64:/usr/lib64:/usr/local/lib64:/lib:/usr/lib:/usr/local/lib:$LD_LIBRARY_PATH
export DATE=`date +"%Y%m%d%H%M"`
export PATH=$PGHOME/bin:$PATH:.
export MANPATH=$PGHOME/share/man:$MANPATH
export PGUSER=postgres
#export PGHOST=$PGDATA
#export PGDATABASE=postgre
```

将配置内容添加到/home/postgres/.bashrc中

```
 source /home/postgres/.bashrc
```





# 数据库

## 术语，概念

### 数据库 Schema

每当我们创建一个新的数据库时，PostgreSQL都会为我们自动创建该模式。

当登录到该数据库时，如果没有特殊的指定，我们将以该模式(public)的形式操作各种数据对象



## 初始化数据库

### 创建存储目录

```
mkdir -p /home/postgres/data
initdb -D /home/postgres/data

```

### 启动数据库

```
pg_ctl -D /home/postgres/data -l logfile start #后台启动pg并且输出到logfile文件中
##下面命令通用可以
 postgres -D /home/postgres/data  >logfile 2>&1 &
 
 ##重启
 pg_ctl restart
```

可以将下面命令加入到init.rc中，系统启动后就可以启动数据库。

==必须切换到postgres用户，不要以root或其他用户启动。==

```
su postgres -c 'pg_ctl start -D /home/postgres/data -l serverlog'
```



使用systemd,创建文件/etc/systemd/system/postgresql.service。

 `Type=notify` requires that the server binary was built with `configure --with-systemd`

```
[Unit]
Description=PostgreSQL database server
Documentation=man:postgres(1)

[Service]
Type=notify
User=postgres
ExecStart=/home/postgres/bin/postgres -D /home/postgres/data
ExecReload=/bin/kill -HUP $MAINPID
KillMode=mixed
KillSignal=SIGINT
TimeoutSec=0

[Install]
WantedBy=multi-user.target
```

## 数据库管理

### 用户与角色

数据库角色在概念上与操作系统用户完全分离。

数据库角色是跨数据库集群安装的全局角色(而不是每个数据库)。使用create role SQL命令创建角色:

```pgs
--查询数据库角色
SELECT rolname FROM pg_roles;
```

区别：

角色就相当于岗位：角色可以是经理，助理。
用户就是具体的人：比如陈XX经理，朱XX助理，王XX助理。
在PostgreSQL 里没有区分用户和角色的概念，"CREATE USER" 为 "CREATE ROLE" 的别名，这两个命令几乎是完全相同的，唯一的区别是"CREATE USER" 命令创建的用户默认带有LOGIN属性，而"CREATE ROLE" 命令创建的用户默认不带LOGIN属性。

```
postgres=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of 
-----------+------------------------------------------------------------+-----------
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 
postgres=# SELECT *  FROM pg_roles;       
       rolname        | rolsuper | rolinherit | rolcreaterole | rolcreatedb | rolcanlogin | rolreplication | rolconnlimit | rolpassword | rolvaliduntil | rolbypassrls | rolconfig | oid  
----------------------+----------+------------+---------------+-------------+-------------+----------------+--------------+-------------+---------------+--------------+-----------+------
 pg_signal_backend    | f        | t          | f             | f           | f           | f              |           -1 | ********    |               | f            |           | 4200
 postgres             | t        | t          | t             | t           | t           | t              |           -1 | ********    |               | t            |           |   10
 pg_read_all_stats    | f        | t          | f             | f           | f           | f              |           -1 | ********    |               | f            |           | 3375
 pg_monitor           | f        | t          | f             | f           | f           | f              |           -1 | ********    |               | f            |           | 3373
 pg_read_all_settings | f        | t          | f             | f           | f           | f              |           -1 | ********    |               | f            |           | 3374
 pg_stat_scan_tables  | f        | t          | f             | f           | f           | f              |           -1 | ********    |               | f            |           | 3377
(6 rows)

postgres=# SELECT usename from pg_user;
 usename  
----------
 postgres
(1 row)
```

**角色属性**：

| 属性        | 说明                                                         |
| ----------- | ------------------------------------------------------------ |
| login       | 只有具有 LOGIN 属性的角色可以用做数据库连接的初始角色名。    |
| superuser   | 数据库超级用户                                               |
| createdb    | 创建数据库权限                                               |
| createrole  | 允许其创建或删除其他普通的用户角色(超级用户除外)             |
| replication | 做流复制的时候用到的一个用户属性，一般单独设定。             |
| password    | 在登录时要求指定密码时才会起作用，比如md5或者password模式，跟客户端的连接认证方式有关 |
| inherit     | 用户组对组员的一个继承标志，成员可以继承用户组的权限特性     |

**创建角色：**

==创建角色没有登录权限==

```
postgres=# create role test;
CREATE ROLE
postgres=# create user dsmart
postgres-# \du
                                   List of roles
 Role name |                         Attributes                         | Member of 
-----------+------------------------------------------------------------+-----------
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test      | Cannot login 
 
postgres=# CREATE USER dsmart;
CREATE ROLE
postgres=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of 
-----------+------------------------------------------------------------+-----------
 dsmart    |                                                            | {}
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test      | Cannot login                                               | {}
```

```
DROP USER dsmart
DROP ROLE test
```



### 数据库操作

**创建数据库**

```
CREATE DATABASE test

```



**删除数据库**

```
DROP DATABASE test
```



**查看数据库**

![1544584275932](D:\Code-Resources\DB\assets\1544584275932.png)



**删除数据库中所有对象**

```
drop schema public cascade;
```







### 备份和恢复

```
##恢复数据库
--首先创建数据库,进入psql:
create database test
psql test < init.sql
psql test < full.sql
执行import.sh
psql test < init2.sql

```

```sql
pg_dump dsmart_2018 > pg.dmp
```



**dsmart恢复**

将SQL文本中的数据恢复到某个指定的数据库test中，并使用用户dsmart

create database test

psql -U dsmart -d test -f init.sql

psql -U dsmart -d test --set ON_ERROR_STOP=ON -f init.sql



执行import.sh

![1544767334797](D:\Code-Resources\DB\assets\1544767334797.png)





备份

```
pg_dump dmsart -h 10.10.56.17 -p 5438 -U postgres > databak
```



```
create database dsamrt_2018
psql -d dsamrt_2018 < pg.dmp
```



### 约束

```
SELECT
     tc.constraint_name, tc.table_name, kcu.column_name, 
     ccu.table_name AS foreign_table_name,
     ccu.column_name AS foreign_column_name,
     tc.is_deferrable,tc.initially_deferred
 FROM 
     information_schema.table_constraints AS tc 
     JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
     JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_name = tc.constraint_name
 WHERE constraint_type = 'FOREIGN KEY' AND tc.table_name = 'your table name';

```



# PLSQL

## where 查询

postgreSQL中where子句执行顺序 - 多个and从左到右依次执行

```pgsq
SELECT ta.uid,ta.name,tb.record_time,tb.value FROM mgt_system as ta, mon_indexdata_his AS tb WHERE ta.use_flag  
    and ta.uid=tb.uid and tb.index_id in ('2184304') and record_time >= '2018-11-06 00:30' and  record_time < '2018-11-07 00:30'ORDER BY tb.uid
```

right join：右关联，生成的表来自right join表的行

```
select tc.record_time,tc.uid,tb.name,tc.index_id,tc.value FROM mgt_system 
    AS tb right join (select ta.record_time,ta.uid,ta.index_id,ta.value from 
    mon_indexdata_his AS ta where ta.index_id  in ('2184304') order by ta.record_time,
    ta.index_id ) as tc on tc.uid=tb.uid
```

语法说明：

```
select * from table1,table2 where table1.column1=table2.column1
```

等价语法：

```
select *from table1 [inner] join table2 on boolean_expression
```

单纯使用内连接：

```
table1 { [inner] | { left| right| full} [outer] } join table2 using ( join column list )
```

USING (a, b, c) 等效于 ON (table1.a = table2.a AND table1.b = table2.b AND table1.c = table2.c) ，结果中abc字段各仅一个。



## 子查询

在子查询中用到一些关键字，分别是“ANY、EXISTS、IN、SOME”，在这些关键字之前还可以添加“NOT”

```
EXISTS (subquery)
expression [NOT] IN (subquery)
row_constructor [NOT] IN (subquery)
expression operator ANY (subquery)
expression operator SOME (subquery)
row_constructor operator ANY (subquery)
row_constructor operator SOME (subquery)
```



半连接：对于“subquery”，使用IN、EXISTS等谓词表示存在即可，称之为半连接

```
SELECT * FROM D
WHERE EXISTS 
( SELECT * FROM E WHERE D.id= E.id
AND E.s > 2500) 
ORDER BY x
```



示例

```
SELECT
    a.id,
    a.thumbNail,
    a. NAME,
    a.marketPrice,
    a.memberPrice,
    a.personName,
    a. STATUS,
    a.recieveOrderDate,
    a.trackNumber,
    a.contact,
    a.reportSendDate,
    b.trackNumber,
    a.reportDownloadPath
FROM
    (
        SELECT
            od.id,
            ps.thumbNail,
            ps. NAME,
            od.marketPrice,
            od.memberPrice,
            od.personName,
            od. STATUS,
            od.recieveOrderDate,
            ol.trackNumber,
            ol.contact,
            od.reportSendDate,
            od.reportSendOrderLogisticId,
            od.reportDownloadPath
        FROM
            orders.order_detail od
        LEFT JOIN orders.order_logistics ol ON od.recieveOrderLogisticId = ol.id
        LEFT JOIN orders.product_snapshot ps ON od.productSnapShotId = ps.id
        WHERE
            od.valid = TRUE
        AND ol.valid = TRUE
        AND od.orderId =?
    ) a
LEFT JOIN (
    SELECT
        ol.trackNumber,
        od.id
    FROM
        orders.order_detail od
    LEFT JOIN orders.order_logistics ol ON od.reportSendOrderLogisticId = ol.id
    WHERE
        od.valid = TRUE
    AND ol.valid = TRUE
    AND od.orderId =?
) b ON a.id = b.id
```



sql优化

原sql:

select * from table_a where cid in(select cid from table_b where cname like '%aaaa%');

优化sql:

select a.* from table_a a,(select cid from table_b where cname like '%aaaa%') b where a.cid=b.cid