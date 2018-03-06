# 统计cpu占用前十的进程
ps aux | sort -k3 | head -10

# git
# 生成公钥
ssh-keygen
# 查看并复制公钥
cat /root/.ssh/id_rsa.pub
# 克隆远程仓库到本地
git clone git@github.com:coldly/Operations.git
# 添加文件
git add shell.sh
# 提交修改
git commit -m "second commit"
# 第一次提交
git push -u origin master

