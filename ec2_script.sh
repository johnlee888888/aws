#!/bin/bash
yum install -y python36 python36-virtualenv python36-pip git
ln -s /usr/bin/pip-3.6 /usr/bin/pip3
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config
sed -i "s/UsePAM yes/UsePAM no/g" /etc/ssh/sshd_config
> ~/.ssh/authorized_keys
sudo sh -c 'echo root:Cisc0123 | chpasswd'
service sshd restart
cd /
yum install -y git
git clone https://gitee.com/qytang/AWS.git
pip3 install boto3
pip3 install flask
yum install -y gcc
pip3 install uwsgi
mkdir ~/.aws/
echo '[default]' > ~/.aws/config
echo 'region=ap-northeast-2' >> ~/.aws/config
python3 /AWS/insert_db_1_create_table.py
python3 /AWS/insert_db_2_insert.py
python3 /AWS/upload_files.py
cp /AWS/uwsgi.conf /etc/init/uwsgi.conf
start uwsgi
yum install -y nginx
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf-bak
cp /AWS/nginx.conf /etc/nginx/nginx.conf
service nginx start
chkconfig nginx on