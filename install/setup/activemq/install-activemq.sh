#!/bin/bash
#Note: edit /etc/default/activemq to change Java memory parameters

echo "Create activemq user and create /opt/activemq directory"
useradd -m activemq -d /opt/activemq
cd /opt/activemq
echo "Download activemq and install"
wget http://ftp.wayne.edu/apache//activemq/5.13.3/apache-activemq-5.13.3-bin.tar.gz
tar -xvf apache-activemq-5.13.3-bin.tar.gz
rm -f apache-activemq-5.13.3-bin.tar.gz
ln -s apache-activemq-5.13.3 current

echo "Installing as a service"
# http://activemq.apache.org/unix-shell-script.html

chown -R activemq:users /opt/activemq
cp /opt/activemq/current/bin/env /etc/default/activemq
sed -i '~s/^ACTIVEMQ_USER=""/ACTIVEMQ_USER="activemq"/' /etc/default/activemq
chmod 644 /etc/default/activemq
ln -snf  /opt/activemq/current/bin/activemq /etc/init.d/activemq
chkconfig --add activemq
chkconfig activemq on
service activemq start
