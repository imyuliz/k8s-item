> cat /etc/my.cnf

[mysqld]

# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links = 0

# http://www.percona.com/blog/2008/05/31/dns-achilles-heel-mysql-installation/
skip_name_resolve

!includedir /etc/my.cnf.d

> /etc/my.cnf.d/10-mysql57.cnf
/etc/my.cnf.d/10-mysql57.cnf

[mysqld]

# http://www.chriscalender.com/ignoring-the-lostfound-directory-in-your-datadir/
ignore-db-dir=lost+found


> /etc/my.cnf.d/cat 40-paas.cnf
/etc/my.cnf.d/cat 40-paas.cnf
[mysqld]
#
# Settings configured by the user
#

# Sets how the table names are stored and compared. Default: 0
lower_case_table_names = 1

# Sets whether queries should be logged
general_log      = 0
general_log_file = /var/lib/mysql/data/mysql-query.log

# The maximum permitted number of simultaneous client connections. Default: 151
max_connections = 2000

# The minimum/maximum lengths of the word to be included in a FULLTEXT index. Default: 4/20
ft_min_word_len = 4
ft_max_word_len = 20

# In case the native AIO is broken. Default: 1
# See http://help.directadmin.com/item.php?id=529
innodb_use_native_aio = 1

[myisamchk]
# The minimum/maximum lengths of the word to be included in a FULLTEXT index. Default: 4/20
#
# To ensure that myisamchk and the server use the same values for full-text
# parameters, we placed them in both sections.
ft_min_word_len = 4
ft_max_word_len = 20

> 50-my-tuning.cnf
bash-4.2$ cat 50-my-tuning.cnf

[mysqld]
key_buffer_size = 32M
max_allowed_packet = 200M
table_open_cache = 400
sort_buffer_size = 256K
read_buffer_size = 8M
read_rnd_buffer_size = 256K
net_buffer_length = 2K
thread_stack = 256K
myisam_sort_buffer_size = 2M

# It is recommended that innodb_buffer_pool_size is configured to 50 to 75 percent of system memory.
innodb_buffer_pool_size = 32M
# Set .._log_file_size to 25 % of buffer pool size
innodb_log_file_size = 8M
innodb_log_buffer_size = 8M

[mysqldump]
quick
max_allowed_packet = 16M

[mysql]
no-auto-rehash

[myisamchk]
key_buffer_size = 8M
sort_buffer_size = 8M

> base.cnf
bash-4.2$ cat base.cnf

[mysqld]
datadir = /var/lib/mysql/data
basedir = /opt/rh/rh-mysql57/root/usr
plugin-dir = /opt/rh/rh-mysql57/root/usr/lib64/mysql/plugin