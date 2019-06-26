# see:
### https://onekeyes.iteye.com/blog/2316533
### https://www.oschina.net/question/35243_168206
### http://www.ha97.com/4070.html

# keyword: 保持SSH服务器长期链接
# Titile:
# Linux下设置SSH Server保持长时间连接

怎样让服务器和一定时间没有任何操作的终端自动断开连接？ # vi /etc/profile 增加： TMOUT=1800 这样30分钟没操作就自动LOGOUT

 

OpenSSH基于安全的理由，如果用户连线到SSH Server后闲置一段时间，SSH Server会在超过特定时间后自动终止SSH连线。本人习惯长时间连接，需要做如下修改：

## 1、打开ssh配置文件：# vim /etc/ssh/sshd_config
加入如下两个参数保存就可以：

    TCPKeepAlive yes
    ClientAliveCountMax 360

注：前一个参数表示要保持TCP连接，后一个参数表示客户端的SSH连线闲置多长时间后自动终止连线的数值，单位为分钟。

## 2、重启sshd生效：
   >~~/etc/init.d/sshd restart~~
   
   上面的命令不能用，在ubuntu 19.04 Lts *reboot 暂时代替*

注：此法适用于所有Linux发行版的OpenSSH

 

## ubuntu设置

如何让ssh连接服务器或者sshtunnel保持连接呢?

　　其实也很方便,只要在/etc/ssh/ssh_config文件里加两个参数就行了

　　1TCPKeepAliveyes

　　2ServerAliveInterval300

　　前一个参数是说要保持连接,后一个参数表示每过5分钟发一个数据包到服务器表示"我还活着"

　　如果你没有root权限,修改或者创建~/.ssh/ssh_config也是可以的
  



