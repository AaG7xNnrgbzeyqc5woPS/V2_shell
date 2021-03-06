# File name : upv2.sh
# title: This script auto install and update v2ray server with docker methond 
# data: 2019.4.28
# 

#---------------------
# Help
#----------------------
#nano /etc/crontab
#cat /etc/crontab
# Edit /etc/crontab ,append this item.
# 8 4    * * *   root    /root/upv2.sh
# than, system atuorun this shell script every day at 4:08
# server time zero is UTC
# Now My time zero is CST = UTC+8, UTC=CST-8,
# if CST=4, then UTC=CST-8=4+24-8=20

#Check this script run ok or no?
# Just check system uptime equ  docerk container uptime or no?
# type command top,htop in command line for see system uptime
# type docker ps -a in command line for see docker container uptime

# see: 
# https://www.v2ray.com/
# https://toutyrater.github.io
# https://toutyrater.github.io/app/docker-deploy-v2ray.html

# https://www.v2ray.com/chapter_00/start.html
# Notice everybody:
# 1,please create your config.json file, 
# 2,fixed port map. this script only for sample. 

#---------------------------------------------------------------------
#use method:
#---------------------------------------------------------------------
# wget https://raw.githubusercontent.com/AaG7xNnrgbzeyqc5woPS/V2_shell/master/upv2.sh
# ls -l
# chmod +x upv2.sh
# ls -l
# ./upv2.sh
# shutdown -c

# install docker, 下面两个方法之一
# 1, snap install docker     # version 18.06.1-ce, or
# 2, apt  install docker.io  # version 18.09.5-0ubuntu1
# 注释：在ubuntu命令行直接输入 docker 命令,如果没有安装 docker回有提示！
# 下面三个命令检查 docker是否安装成功
# docker --version
# docker info
# docker run library/hello-world
# 这个难度更大的命令，进入容器内
# docker run -it ubuntu bash


#---------------------
# main scription
#-------------------

echo ---1, Hello,Now upgrade GNU/Linux----
echo ---01 update -----
apt-get update

echo
echo ---02 upgrade----
apt-get upgrade -y

echo
echo ---03 dist-upgrade---
apt-get dist-upgrade -y

echo
echo ---04 atuoremove---
apt-get autoremove -y

echo
echo ---05 clean---
apt-get clean -y

echo
echo
echo
echo -----------------------------------------
echo ---- 02 docker v2ray upgrade  ----------
echo -----------------------------------------
echo


echo
echo ---- 21. docker stop all v2ray
docker stop v2ray1 v2ray2 v2ray3

echo
echo ----- 22. docker rm  all v2ray
docker rm v2ray1 v2ray2 v2ray3

echo
echo ----- 23. docker rm all images
docker rmi v2ray/official

echo --- 24. docker pull v2ray/official----
docker pull v2ray/official

echo
echo ----- 24. docker run all v2ray

# port map only for demo, please fix it for your mind.
# please create three config file yourself.
docker run -d  --restart unless-stopped --name v2ray1 -v /etc/v2ray:/etc/v2ray  -p 2000:2000 v2ray/official  v2ray -config=/etc/v2ray/svr_config_1.json

docker run -d  --restart unless-stopped --name v2ray2 -v /etc/v2ray:/etc/v2ray -p 2000:2000/udp v2ray/official  v2ray -config=/etc/v2ray/svr_config_2.json

docker run -d  --restart unless-stopped --name v2ray3 -v /etc/v2ray:/etc/v2ray -p 2100:2100/udp v2ray/official  v2ray -config=/etc/v2ray/svr_config_3.json

# if you want some log, please add other parametric:
# -v /var/log/v2ray:/var/log/v2ray

echo
echo ---- 24. docker  containers list
docker  ps -a

echo
echo ---- 25. docker images list
docker images
echo

# ---- reboot ---
shutdown -r  +5


