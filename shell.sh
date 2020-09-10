# 编写shell脚本循环创建100个用户（user_[0-99])
#!/bin/bash
for((i = 0; i < 100; i++));
do
useradd user_$i;
done
# 统计shell.sh文件的行数
wc -l shell.sh
# 查看版本信息
uname -a
cat /proc/version
lsb_release -a
ls /boot
# 统计cpu占用前十的进程
ps aux | sort -k3 | head -10
# 查看物理CPU个数
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l
# 查看每个物理CPU中core的个数(即核数)
cat /proc/cpuinfo| grep "cpu cores"| uniq
# 查看逻辑CPU的个数
cat /proc/cpuinfo| grep "processor"| wc -l
# 查看CPU型号
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
# 查看内存条数
dmidecode | grep -A16 "Memory Device$"
# 内存使用情况
free -h
# 将所有正在内存中的缓冲区写到磁盘中
sync
# 释放页缓存
echo 1 > /proc/sys/vm/drop_caches
# 释放dentries和inodes
echo 2 > /proc/sys/vm/drop_caches
# 释放所有缓存
echo 3 > /proc/sys/vm/drop_caches
# 让操作系统重新分配内存
echo 0 > /proc/sys/vm/drop_caches
# 开机启动mysql
chkconfig mysqld on
# centos7
systemctl enable mariadb
# 查看磁盘空间
df -h
# 查看22端口现在运行的情况
lsof -i :22
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
ssh     4169 root    3u  IPv4 127672      0t0  TCP 172.16.123.1:52650->172.16.123.128:ssh (ESTABLISHED)
ssh     4172 root    3u  IPv4 130231      0t0  TCP 172.16.123.1:59818->172.16.123.129:ssh (ESTABLISHED)
# 配置防火墙只允许远程主机访问本机的80端口
/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/etc/rc.d/init.d/iptables save
/etc/init.d/iptables status
# centos7 firewall
1、firewalld的基本使用
启动： systemctl start firewalld
查看状态： systemctl status firewalld
停止： systemctl disable firewalld
禁用： systemctl stop firewalld

2.systemctl是CentOS7的服务管理工具中主要的工具，它融合之前service和chkconfig的功能于一体。
启动一个服务：systemctl start firewalld.service
关闭一个服务：systemctl stop firewalld.service
重启一个服务：systemctl restart firewalld.service
显示一个服务的状态：systemctl status firewalld.service
在开机时启用一个服务：systemctl enable firewalld.service
在开机时禁用一个服务：systemctl disable firewalld.service
查看服务是否开机启动：systemctl is-enabled firewalld.service
查看已启动的服务列表：systemctl list-unit-files|grep enabled
查看启动失败的服务列表：systemctl --failed

3.配置firewalld-cmd
查看版本： firewall-cmd --version
查看帮助： firewall-cmd --help
显示状态： firewall-cmd --state
查看所有打开的端口： firewall-cmd --zone=public --list-ports
更新防火墙规则： firewall-cmd --reload
查看区域信息:  firewall-cmd --get-active-zones
查看指定接口所属区域： firewall-cmd --get-zone-of-interface=eth0
拒绝所有包：firewall-cmd --panic-on
取消拒绝状态： firewall-cmd --panic-off
查看是否拒绝： firewall-cmd --query-panic
那怎么开启一个端口呢
添加
firewall-cmd --zone=public --add-port=80/tcp --permanent    （--permanent永久生效，没有此参数重启后失效）
重新载入
firewall-cmd --reload
查看
firewall-cmd --zone= public --query-port=80/tcp
删除
firewall-cmd --zone= public --remove-port=80/tcp --permanent

# 将/opt目录下包含'hellohhhhh'的文件替换成'hi'
sed -i 's/hellohhhhh/hi/g' `grep -rl 'hellohhhhh' /opt`
# 将shell.sh中/var/log 替换成/usr/local
sed -i 's/\/var\/log/\/usr\/local/g' shell.sh
# 替换网址，将需要下载的文件链接替换成本地文件链接，用于离线编译tensorflow
sed -i 's/^http.*\//http:\/\/localhost\//g' `grep -rl 'urls\ =\ \[' ./`
# awk
awk 'BEGIN{for(i=1; i<=10; i++) print i}'
# kill某个用户的所有进程
pkill -u user
killall -u user
pgrep -u user | xargs kill -9
# xargs用法，将管道符前命令的所有结果依次作为xargs后命令的参数
ls | xargs ls
# 计划任务：分 时 日 月 周
crontab -l
crontab -e
vim /etc/crontab

# ssh端口转发
# 动态端口转发：将本机1080端口数据动态转发给远程主机ssh端口9922，远程主机代理所有经过本机1080端口的网络连接,本机地址加1080端口变成一个socks代理，-D 动态转发，即socks代理，被转发的流量可以访问目标地址的任意端口，比如：http:80,https:443,ftp:21，-f 在后台对用户名密码进行认证，-N 仅仅只用来转发，不用再弹回一个新的shell，如果不加-N命令行界面将登录到远程主机。
ssh -D 1080 -p 9922 -fN root@192.168.1.106
# 测试：curl使用本机1080端口socks4/4a或者socks5代理访问谷歌
curl --socks4a 127.0.0.1:1080 http://www.google.com
# 使用安全的ssh隧道加密本机到远程主机不安全的连接，将远程主机的vnc端口5901通过ssh加密隧道转发给本机的5901端口，vnc客户端连接本机5901端口等于连接远程主机的vnc服务，即使这项服务所有数据包括用户密码本来都是使用明文传输，也由于双方通信的所有流量都包裹在ssh加密隧道里，任何第三方即使监听截获，流量被抓包也是通过ssh加密后的数据包。-L 进行本地端口转发
ssh -p 9922 -fN -L 5901:localhost:5901 root@192.168.1.106

# git
# 生成公钥
ssh-keygen
# 查看并复制公钥
cat /root/.ssh/id_rsa.pub
# 克隆远程仓库到本地
git clone git@github.com:coldly/Operations.git
# 添加修改后的文件
git add shell.sh
# 提交修改
git commit -m "second commit"
# 第一次提交到远程仓库
git push -u origin master
# 后续提交远程仓库
git push origin
# 回退到上个版本
git reset --hard HEAD^
# 查询commit id
git reflog
# 解决冲突直接修改文件

# Docker
cat /etc/debian_version 
kali-rolling
vi /etc/debian_version
9.0

cat /etc/lsb-release
DISTRIB_ID=Kali
DISTRIB_RELEASE=kali-rolling
DISTRIB_CODENAME=kali-rolling
DISTRIB_DESCRIPTION="Kali GNU/Linux Rolling"
vi /etc/lsb-release
DISTRIB_ID=Debian
DISTRIB_RELEASE=9
DISTRIB_CODENAME=stretch
DISTRIB_DESCRIPTION="Debian GNU/Linux 9 (stretch)"

cat /etc/os-release
PRETTY_NAME="Kali GNU/Linux Rolling"
NAME="Kali GNU/Linux"
ID=kali
VERSION="2019.1"
VERSION_ID="2019.1"
ID_LIKE=debian
ANSI_COLOR="1;31"
HOME_URL="https://www.kali.org/"
SUPPORT_URL="https://forums.kali.org/"
BUG_REPORT_URL="https://bugs.kali.org/"
vi /etc/os-release
PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
NAME="Debian GNU/Linux"
ID=debian
VERSION="9 (stretch)"
VERSION_ID="9"
ID_LIKE=debian
ANSI_COLOR="1;31"
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"

apt-get remove docker docker-engine docker.io containerd runc
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88

pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
cat /etc/apt/sources.list   
deb-src [arch=amd64] https://download.docker.com/linux/debian stretch stable
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io
docker run hello-world

AI
# install tensorflow 1.5.0 
# upper than this version have Illegal instruction error
python3
>>> import pip._internal
>>> print(pip._internal.pep425tags.get_supported())
[('cp37', 'cp37m', 'manylinux1_x86_64'), ('cp37', 'cp37m', 'linux_x86_64'), ('cp37', 'abi3', 'manylinux1_x86_64'), ('cp37', 'abi3', 'linux_x86_64'), ('cp37', 'none', 'manylinux1_x86_64'), ('cp37', 'none', 'linux_x86_64'), ('cp36', 'abi3', 'manylinux1_x86_64'), ('cp36', 'abi3', 'linux_x86_64'), ('cp35', 'abi3', 'manylinux1_x86_64'), ('cp35', 'abi3', 'linux_x86_64'), ('cp34', 'abi3', 'manylinux1_x86_64'), ('cp34', 'abi3', 'linux_x86_64'), ('cp33', 'abi3', 'manylinux1_x86_64'), ('cp33', 'abi3', 'linux_x86_64'), ('cp32', 'abi3', 'manylinux1_x86_64'), ('cp32', 'abi3', 'linux_x86_64'), ('py3', 'none', 'manylinux1_x86_64'), ('py3', 'none', 'linux_x86_64'), ('cp37', 'none', 'any'), ('cp3', 'none', 'any'), ('py37', 'none', 'any'), ('py3', 'none', 'any'), ('py36', 'none', 'any'), ('py35', 'none', 'any'), ('py34', 'none', 'any'), ('py33', 'none', 'any'), ('py32', 'none', 'any'), ('py31', 'none', 'any'), ('py30', 'none', 'any')]    
>>> exit()
pip3 install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.5.0rc1-cp37-cp37m-linux_x86_64.whl

