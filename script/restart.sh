
#!/bin/sh
#Jar包名称，注意：不要带有.jar
APP1_NAME=newbee-mall-api-3.0.0-SNAPSHOT

#启动服务前，如果服务依然在运行，找到服务的PID
#grep -v 只打印没有匹配的，而匹配的反而不打印
tpid1=`ps -ef|grep $APP1_NAME|grep -v grep|grep -v kill|awk '{print $2}'`

#如果服务存在，就杀掉
if [ $tpid1 ]; then
kill -9 $tpid1
fi

# 指定配置文件，启动Jar，控制台默认输出到nohup.out文件
#
nohup java -jar target/*.jar --spring.profiles.active=pro  &
disown
