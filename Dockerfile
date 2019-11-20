# 基于itxq/bt镜像
FROM itxq/bt:latest

# 添加shell脚本
COPY ./shell/shell.sh /itxq/shell/shell.sh

# 安装PHP
RUN bash /www/server/panel/install/install_soft.sh 0 install php 7.3
# 安装Nginx
RUN bash /www/server/panel/install/install_soft.sh 0 install nginx 1.17
# 安装MySQL
RUN bash /www/server/panel/install/install_soft.sh 0 install mysql 8.0
# 安装Redis
RUN bash /www/server/panel/install/install_soft.sh 0 install redis 5.0
