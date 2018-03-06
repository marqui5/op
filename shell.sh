# 统计cpu占用前十的进程
ps aux | sort -k3 | head -10
# 将/opt目录下包含'hello'的文件替换成'hi'
sed -i 's/hellohhhhh/hi/g' `grep -rl 'hellohhhhh' /opt`
# awk

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
