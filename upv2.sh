# File name : upv2.sh
# data: 2019.4.28

#---------------------
# Help
#----------------------
#nano /etc/crontab
#cat /etc/crontab
# Edit /etc/crontab ,append this item.
# 8 4    * * *   root    /root/upv2.sh
# than, system atuorun this shell script every day at 4:08

#Check this script run ok or no?
# Just check system uptime equ  docerk container uptime or no?
# type command top,htop in command line for see system uptime
# type docker ps -a in command line for see docker container uptime

#---------------------
#
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
apt-get autoremove

echo
echo ---05 clean---
apt-get clean

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
# please create three config file youself.
docker run -d  --restart unless-stopped --name v2ray1 -v /etc/v2ray:/etc/v2ray  -p 2000:2000 v2ray/official  v2ray -config=/etc/v2ray/svr_config_1.json

docker run -d  --restart unless-stopped --name v2ray2 -v /etc/v2ray:/etc/v2ray -p 2000:2000/udp v2ray/official  v2ray -config=/etc/v2ray/svr_config_2.json

docker run -d  --restart unless-stopped --name v2ray3 -v /etc/v2ray:/etc/v2ray -p 2100:2100/udp v2ray/official  v2ray -config=/etc/v2ray/svr_config_3.json

echo
echo ---- 24. docker  containers list
docker  ps -a

echo
echo ---- 25. docker images list
docker images
echo

# ---- reboot ---
shutdown -r  +5

