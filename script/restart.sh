
APP_NAME=newbee-mall-api-3.0.0-SNAPSHOT


pkill -f $APP_NAME.jar
# 指定配置文件，启动Jar，控制台默认输出到nohup.out文件
#
nohup java -jar target/$APP_NAME.jar   &

