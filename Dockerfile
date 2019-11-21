# 基于itxq/bt镜像
FROM itxq/bt:latest

# 镜像作者信息
MAINTAINER IT小强xqitw.cn <mail@xqitw.cn>

# 设置时区为上海
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone

# 安装PHP
RUN bash /www/server/panel/install/install_soft.sh 0 install php 7.3
RUN echo '# 启动PHP' >> /itxq/shell/shell.sh
RUN echo '/etc/init.d/php-fpm-73 start' >> /itxq/shell/shell.sh

# 安装Nginx
RUN bash /www/server/panel/install/install_soft.sh 0 install nginx 1.17
RUN echo '# 启动Nginx' >> /itxq/shell/shell.sh
RUN echo '/etc/init.d/nginx restart' >> /itxq/shell/shell.sh

# 安装MySQL
RUN bash /www/server/panel/install/install_soft.sh 0 install mysql 8.0
RUN cp -a -p /www/server/data/* /www/mysql/
RUN echo '# 启动MySQL' >> /itxq/shell/shell.sh
RUN echo 'if [ ! -d "/www/server/data/mysql" ];then' >> /itxq/shell/shell.sh
RUN echo '  cp -a -p /www/mysql/* /www/server/data/' >> /itxq/shell/shell.sh
RUN echo '  echo "数据库data目录初始化完成！"' >> /itxq/shell/shell.sh
RUN echo 'else' >> /itxq/shell/shell.sh
RUN echo '  echo "数据库data目录已存在!"' >> /itxq/shell/shell.sh
RUN echo 'fi' >> /itxq/shell/shell.sh
RUN echo '/etc/init.d/mysqld start' >> /itxq/shell/shell.sh

# 安装Redis
RUN bash /www/server/panel/install/install_soft.sh 0 install redis 5.0
RUN echo '# 启动Redis' >> /itxq/shell/shell.sh
RUN echo '/etc/init.d/redis restart' >> /itxq/shell/shell.sh

# 安装FTP
RUN bash /www/server/panel/install/install_soft.sh 0 install pureftpd 1.0
RUN echo '# 启动FTP' >> /itxq/shell/shell.sh
RUN echo '/etc/init.d/pure-ftpd restart' >> /itxq/shell/shell.sh

# 安装PM2
RUN bash /www/server/panel/install/install_soft.sh 0 install pm2 4.2

# 安装Supervisor
RUN bash /www/server/panel/install/install_soft.sh 0 install supervisor 1

# 安装PHP守护进程
RUN bash /www/server/panel/install/install_soft.sh 0 install phpguard 1

# 添加软件到宝塔首页
RUN echo '["nginx", "mysql","php-7.3", "redis", "pm2", "pureftpd", "supervisor"]' > /www/server/panel/config/index.json

# 镜像信息
LABEL org.label-schema.schema-version="1.0.0" \
    org.label-schema.name="Docker Bt Panel Full" \
    org.label-schema.vendor="IT小强xqitw.cn" \
    org.label-schema.license="Apache Licence 2.0" \
    org.label-schema.build-date="20191121"

# 开放端口
EXPOSE 39000-40000 8888 8080 6379 3360 888 443 80 22 21 20

# 启动命令
CMD ["run-bt"]