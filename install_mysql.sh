#!/bin/sh
# filename: install_mysql.sh
set -x 
#yum -y install gcc-c++  gdb  cmake  ncurses-devel  bison bison-devel  perl  perl-devel
if [ -d /roobo/server/mysql ];
then
	rm -rf /roobo/server/mysql
else
	mkdir -p /roobo/server/
fi


if [ -d /roobo/mysqldata/database ]
then
	rm -rf /roobo/mysqldata/database
else
	mkdir -p /roobo/mysqldata/
fi


mkdir -p /roobo/logs
mkdir -p /roobo/logs/mysql

cp -rf mysql /roobo/server
cp -rf mysqldata /roobo

rm -f /etc/my.cnf
ln -s /roobo/server/mysql/my.cnf /etc/my.cnf

rm -f /etc/init.d/mysqld
#ln -s /roobo/server/mysql/scripts/mysql.server /etc/init.d/mysqld
cp /roobo/server/mysql/support-files/mysql.server /etc/init.d/mysqld
chmod + x /etc/init.d/mysqld

mkdir /var/lib/mysql

MYSQL=`cat /etc/profile.d/mysql.sh | grep /roobo/server/mysql/bin`
if [ -z "$MYSQL" ]; then
  echo 'export PATH=$PATH:/roobo/server/mysql/bin'>>/etc/profile.d/mysql.sh
  source /etc/profile.d/mysql.sh
fi

if [ -z `grep mysql /etc/group` ]; then
  groupadd mysql
fi

if [ -z `grep mysql /etc/passwd` ]; then
  useradd -g mysql -s /sbin/nologin -d /roobo/mysqldata/database mysql
fi

chown mysql:mysql -R /roobo/server/mysql
chown mysql:mysql -R /roobo/mysqldata
chown mysql:mysql -R /roobo/logs/mysql
chown -R mysql.mysql /var/lib/mysql/
source /etc/profile.d/mysql.sh
. /etc/profile.d/mysql.sh
/roobo/server/mysql/scripts/mysql_install_db --basedir=/roobo/server/mysql --datadir=/roobo/mysqldata/database --user=mysql 

kill -9 mysqld
service mysqld restart
chkconfig mysqld on
