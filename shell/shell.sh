#!/bin/bash
# 启动 crond
/usr/sbin/crond start
# 启动Redis
/etc/init.d/redis restart
# 启动PHP
/etc/init.d/php-fpm-73 start
# 启动MySQL
/etc/init.d/mysqld start
# 启动Nginx
/etc/init.d/nginx restart