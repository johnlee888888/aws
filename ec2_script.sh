#!/bin/bash
yum groupinstall -y Development tools
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel gcc
yum install wget
wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz
xz -d Python-3.6.8.tar.xz
tar xvf Python-3.6.8.tar
cd Python-3.6.8
./configure --prefix=/usr/local
make && make install
ln -s /usr/local/bin/python3 /usr/bin/python3
ln -s /usr/local/bin/pip3 /usr/bin/pip3
cd /
git clone https://gitee.com/qytang/AWS.git
pip3 install boto3
pip3 install flask
mkdir ~/.aws/
echo '[default]' > ~/.aws/config
echo 'region=ap-northeast-2' >> ~/.aws/config
python3 /AWS/insert_db_1_create_table.py
python3 /AWS/insert_db_2_insert.py
python3 /AWS/upload_files.py
python3 /AWS/app.py &