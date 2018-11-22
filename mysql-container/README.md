Mysql容器化
---

### 基本信息

> OS Version

```
bash-4.2$ cat /etc/redhat-release
CentOS Linux release 7.5.1804 (Core)
```
> Mysql Version

```
bash-4.2$ mysql -V
mysql  Ver 14.14 Distrib 5.7.21, for Linux (x86_64) using  EditLine wrapper
```

> Mysql 存储引擎

```
mysql> show variables like '%storage_engine%';
+----------------------------------+--------+
| Variable_name                    | Value  |
+----------------------------------+--------+
| default_storage_engine           | InnoDB |
| default_tmp_storage_engine       | InnoDB |
| disabled_storage_engines         |        |
| internal_tmp_disk_storage_engine | InnoDB |
+----------------------------------+--------+

```
### 镜像

> master

```
cd mysql-container/custom-master
docker build . -t mysql-master:5.7

docker run -d  -e MYSQL_USER=repl -e MYSQL_PASSWORD=repl1234  -e MYSQL_DATABASE=test  -p 3306:3306  mysql-master:5.7
```

> slave

```
cd mysql-container/custom-slave
docker build . -t mysql-slave:5.7

docker run -d  -e MYSQL_USER=repl -e MYSQL_PASSWORD=repl1234  -e MYSQL_DATABASE=test  -p 3306:3306  mysql-slave:5.7
```

### Master的特殊性


1. 默认会创建用户repl(密码是:repl1234)作为主从复制复制用户


### 参考资料

> 镜像相关资料

- [Centos官方hub.docker-Centos7-Mysql-5.7](https://hub.docker.com/r/centos/mysql-57-centos7/)
- [Centos官方Mysql的Dockerfile](https://github.com/sclorg/mysql-container)
- [Centos官方hub.docker](https://hub.docker.com/u/centos/)

> 部署相关资料

- [张磊Sts第20节](https://time.geekbang.org/column/article/41217)
- [张磊Sts第二节所用到的yaml](https://github.com/oracle/kubernetes-website/blob/master/docs/tasks/run-application/mysql-statefulset.yaml)
- [mysql主从配置指定端口](https://blog.csdn.net/zwj2008881946/article/details/79479800)
- [MySQL在一台db服务器上面如何启动多个实例](https://blog.csdn.net/mchdba/article/details/11162037)
- [mysql多端口实现多个实例以及mysqld_multi管理](http://www.webyang.net/Html/web/article_311.html)
- [xtrabackup备份](http://www.zsythink.net/archives/1469)

### 常用的启动命令
```
docker run -d  -e MYSQL_USER=mysql -e MYSQL_PASSWORD=pass -e MYSQL_DATABASE=db   -p 3306:3306 yulibaozi/mysql-master7:5.7
```

50-my-tuning.cnf
```
[mysqld]
key_buffer_size = ${MYSQL_KEY_BUFFER_SIZE}
max_allowed_packet = ${MYSQL_MAX_ALLOWED_PACKET}
table_open_cache = ${MYSQL_TABLE_OPEN_CACHE}
sort_buffer_size = ${MYSQL_SORT_BUFFER_SIZE}
read_buffer_size = ${MYSQL_READ_BUFFER_SIZE}
read_rnd_buffer_size = 256K
net_buffer_length = 2K
thread_stack = 256K
myisam_sort_buffer_size = 2M

# It is recommended that innodb_buffer_pool_size is configured to 50 to 75 percent of system memory.
innodb_buffer_pool_size = ${MYSQL_INNODB_BUFFER_POOL_SIZE}
# Set .._log_file_size to 25 % of buffer pool size
innodb_log_file_size = ${MYSQL_INNODB_LOG_FILE_SIZE}
innodb_log_buffer_size = ${MYSQL_INNODB_LOG_BUFFER_SIZE}

[mysqldump]
quick
max_allowed_packet = 16M

[mysql]
no-auto-rehash

[myisamchk]
key_buffer_size = 8M
sort_buffer_size = 8M
```