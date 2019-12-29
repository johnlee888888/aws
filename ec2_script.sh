#!/bin/bash
# 安装python3
yum install -y python36 python36-virtualenv python36-pip git
ln -s /usr/bin/pip-3.6 /usr/bin/pip3

# 激活ssh root密码登录
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config
sed -i "s/UsePAM yes/UsePAM no/g" /etc/ssh/sshd_config
> ~/.ssh/authorized_keys
sudo sh -c 'echo root:Cisc0123 | chpasswd'
service sshd restart

# git下载项目
cd /
yum install -y git
git clone https://gitee.com/qytang/AWS.git

# 安装python 模块
pip3 install boto3
pip3 install flask

# 设置aws的region
mkdir ~/.aws/
echo '[default]' > ~/.aws/config
echo 'region=ap-northeast-2' >> ~/.aws/config

# 使用python脚本创建数据库表
python3 /AWS/insert_db_1_create_table.py
# 使用python脚本向数据库接入数据
python3 /AWS/insert_db_2_insert.py
# 使用python脚本上传静态文件(图片)到webapp-aws[名字有严格要求,需要提前创建]的s3存储
python3 /AWS/upload_files.py

# 安装与配置uwsgi
yum install -y gcc
pip3 install uwsgi
cp /AWS/uwsgi.conf /etc/init/uwsgi.conf
start uwsgi

# 安装与配置NGINX
yum install -y nginx
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf-bak
cp /AWS/nginx.conf /etc/nginx/nginx.conf
service nginx start
chkconfig nginx on