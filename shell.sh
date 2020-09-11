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
# 克隆远程仓库到本地,先有远程库
git clone git@github.com:coldly/Operations.git
# 在当前目录新建一个Git代码库，先有本地库
$ git init
# 为刚刚新建的代码库添加远程仓库
git remote add origin git@github.com:coldly/Operations.git
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

# git server
# 创建无家目录的git用户指定git-shell
useradd -M -s /usr/bin/git-shell git
# 导入git用户的公钥文件
vim /home/git/.ssh/authorized_keys
# 创建git裸库
su git
git init --bare /git/test.git
# 克隆裸库
git clone git@192.168.1.106:9922/git/test.git
# 创建已有项目的备份裸库
git init --bare project.git
# 为已有的项目添加自建远程仓库
git remote add gitserver git@192.168.1.106:9922/git/project.git
# 提交代码到自建远程仓库
git push gitserver master

# git http server
# 创建http用户认证文件
htpasswd - c /etc/httpd/conf.d/git.auth git
# 编辑Apache虚拟主机配置文件
vim /etc/httpd/conf.d/vhosts.conf
<VirtualHost *:80>

    ServerName git.com

    ServerAdmin git@git.com

    SetEnv GIT_PROJECT_ROOT /git

    SetEnv GIT_HTTP_EXPORT_ALL

    ScriptAlias / /usr/local/git/libexec/git-core/git-http-backend/

    <Location />

        AuthType Basic

        AuthName "git"

        AuthUserFile /etc/httpd/conf.d/git.auth

        Require valid-user

    </Location>

</VirtualHost>
# 使用http协议克隆代码
git clone http://git.com/project.git

# gitweb
# 编辑Apache虚拟主机文件开通网页版git服务
vim /etc/httpd/conf.d/vhosts.conf
<VirtualHost *:81>

    ServerName git.com

    ServerAdmin git@git.com

    <Location />

        AuthType Basic

        AuthName "git"

        AuthUserFile /etc/httpd/conf.d/git.auth

        Require valid-user

    </Location>

    DocumentRoot /var/www/gitweb

    <Directory /var/www/gitweb>

        Options +ExecCGI +FollowSymLinks +SymLinksIfOwnerMatch

        AllowOverride All

        order allow,deny

        Allow from all

        AddHandler cgi-script cgi

        DirectoryIndex gitweb.cgi

    </Directory>

</VirtualHost>
cp -rap /usr/local/git/share/gitweb/* /var/www/gitweb/
vim /var/www/gitweb/gitweb.cgi
our $projectroot = "/data/git";
our $home_link_str = "Projects";

# git command 
# 一、新建代码库
# 在当前目录新建一个Git代码库
$ git init
# 新建一个目录，将其初始化为Git代码库
$ git init [project-name]
# 下载一个项目和它的整个代码历史
$ git clone [url]

# 二、配置
# 显示当前的Git配置
$ git config --list
# 编辑Git配置文件
$ git config -e [--global]
# 设置提交代码时的用户信息
$ git config [--global] user.name "[name]"
$ git config [--global] user.email "[email address]"

# 三、增加/删除文件
# 添加指定文件到暂存区
$ git add [file1] [file2] ...
# 添加指定目录到暂存区，包括子目录
$ git add [dir]
# 添加当前目录的所有文件到暂存区
$ git add .
# 添加每个变化前，都会要求确认
# 对于同一个文件的多处变化，可以实现分次提交
$ git add -p
# 删除工作区文件，并且将这次删除放入暂存区
$ git rm [file1] [file2] ...
# 停止追踪指定文件，但该文件会保留在工作区
$ git rm --cached [file]
# 改名文件，并且将这个改名放入暂存区
$ git mv [file-original] [file-renamed]

# 四、代码提交
# 提交暂存区到仓库区
$ git commit -m [message]
# 提交暂存区的指定文件到仓库区
$ git commit [file1] [file2] ... -m [message]
# 提交工作区自上次commit之后的变化，直接到仓库区
$ git commit -a
# 提交时显示所有diff信息
$ git commit -v
# 使用一次新的commit，替代上一次提交
# 如果代码没有任何新变化，则用来改写上一次commit的提交信息
$ git commit --amend -m [message]
# 重做上一次commit，并包括指定文件的新变化
$ git commit --amend [file1] [file2] ...

# 五、分支
# 列出所有本地分支
$ git branch
# 列出所有远程分支
$ git branch -r
# 列出所有本地分支和远程分支
$ git branch -a
# 新建一个分支，但依然停留在当前分支
$ git branch [branch-name]
# 新建一个分支，并切换到该分支
$ git checkout -b [branch]
# 新建一个分支，指向指定commit
$ git branch [branch] [commit]
# 新建一个分支，与指定的远程分支建立追踪关系
$ git branch --track [branch] [remote-branch]
# 切换到指定分支，并更新工作区
$ git checkout [branch-name]
# 切换到上一个分支
$ git checkout -
# 建立追踪关系，在现有分支与指定的远程分支之间
$ git branch --set-upstream [branch] [remote-branch]
# 合并指定分支到当前分支
$ git merge [branch]
# 选择一个commit，合并进当前分支
$ git cherry-pick [commit]
# 删除分支
$ git branch -d [branch-name]
# 删除远程分支
$ git push origin --delete [branch-name]
$ git branch -dr [remote/branch]

# 六、标签
# 列出所有tag
$ git tag
# 新建一个tag在当前commit
$ git tag [tag]
# 新建一个tag在指定commit
$ git tag [tag] [commit]
# 删除本地tag
$ git tag -d [tag]
# 删除远程tag
$ git push origin :refs/tags/[tagName]
# 查看tag信息
$ git show [tag]
# 提交指定tag
$ git push [remote] [tag]
# 提交所有tag
$ git push [remote] --tags
# 新建一个分支，指向某个tag
$ git checkout -b [branch] [tag]

# 七、查看信息
# 显示有变更的文件
$ git status
# 显示当前分支的版本历史
$ git log
# 显示commit历史，以及每次commit发生变更的文件
$ git log --stat
# 搜索提交历史，根据关键词
$ git log -S [keyword]
# 显示某个commit之后的所有变动，每个commit占据一行
$ git log [tag] HEAD --pretty=format:%s
# 显示某个commit之后的所有变动，其"提交说明"必须符合搜索条件
$ git log [tag] HEAD --grep feature
# 显示某个文件的版本历史，包括文件改名
$ git log --follow [file]
$ git whatchanged [file]
# 显示指定文件相关的每一次diff
$ git log -p [file]
# 显示过去5次提交
$ git log -5 --pretty --oneline
# 显示所有提交过的用户，按提交次数排序
$ git shortlog -sn
# 显示指定文件是什么人在什么时间修改过
$ git blame [file]
# 显示暂存区和工作区的差异
$ git diff
# 显示暂存区和上一个commit的差异
$ git diff --cached [file]
# 显示工作区与当前分支最新commit之间的差异
$ git diff HEAD
# 显示两次提交之间的差异
$ git diff [first-branch]...[second-branch]
# 显示今天你写了多少行代码
$ git diff --shortstat "@{0 day ago}"
# 显示某次提交的元数据和内容变化
$ git show [commit]
# 显示某次提交发生变化的文件
$ git show --name-only [commit]
# 显示某次提交时，某个文件的内容
$ git show [commit]:[filename]
# 显示当前分支的最近几次提交
$ git reflog

# 八、远程同步
# 下载远程仓库的所有变动
$ git fetch [remote]
# 显示所有远程仓库
$ git remote -v
# 显示某个远程仓库的信息
$ git remote show [remote]
# 增加一个新的远程仓库，并命名
$ git remote add [shortname] [url]
# 取回远程仓库的变化，并与本地分支合并
$ git pull [remote] [branch]
# 上传本地指定分支到远程仓库
$ git push [remote] [branch]
# 强行推送当前分支到远程仓库，即使有冲突
$ git push [remote] --force
# 推送所有分支到远程仓库
$ git push [remote] --all

# 九、撤销
# 恢复暂存区的指定文件到工作区
$ git checkout [file]
# 恢复某个commit的指定文件到暂存区和工作区
$ git checkout [commit] [file]
# 恢复暂存区的所有文件到工作区
$ git checkout .
# 重置暂存区的指定文件，与上一次commit保持一致，但工作区不变
$ git reset [file]
# 重置暂存区与工作区，与上一次commit保持一致
$ git reset --hard
# 重置当前分支的指针为指定commit，同时重置暂存区，但工作区不变
$ git reset [commit]
# 重置当前分支的HEAD为指定commit，同时重置暂存区和工作区，与指定commit一致
$ git reset --hard [commit]
# 重置当前HEAD为指定commit，但保持暂存区和工作区不变
$ git reset --keep [commit]
# 新建一个commit，用来撤销指定commit
# 后者的所有变化都将被前者抵消，并且应用到当前分支
$ git revert [commit]
# 暂时将未提交的变化移除，稍后再移入
$ git stash
$ git stash pop

# 十、其他
# 生成一个可供发布的压缩包
$ git archive

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

