#!/bin/bash
if [ -d /roobo/server/redis ]
	then
		rm -rf /roobo/server/redis
	else
		mkdir -p /roobo/server
fi
rm -f /etc/init.d/redis
cp -rf redis /roobo/server
cp /roobo/server/redis/redis.sh /etc/init.d/redis
chmod +x /etc/init.d/redis
chmod 755 /etc/init.d/redis 
chkconfig --add redis 
chkconfig --level 345 redis on 

