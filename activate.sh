#!/bin/bash


# 尽量加载常见的环境（根据你自己的情况选择性保留）
[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.bash_profile ] && source ~/.bash_profile
[ -f ~/.profile ] && source ~/.profile

# bun 的路径（非常重要）
export PATH="/root/.bun/bin:$PATH"


# 确保之前手工在这个目录下启动过一次
# 在第一次运行时，会做交互式安全确认
cd /opt/git/cron-do-something-actiave-glm4.7/

# 获取当前时间和日期
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')

# 写入到 fuck5hours.md
echo "[$CURRENT_TIME] 开始激活..." >> /opt/git/cron-do-something-actiave-glm4.7/fuck5hours.md

# 使用 bunx claude 执行简单任务以激活5小时有效期
# 执行一个非常简单的任务：计算 1+1
/root/.bun/bin/bunx claude --print "1+1等于几？" >> /opt/git/cron-do-something-actiave-glm4.7/fuck5hours.md 2>&1

echo "[$CURRENT_TIME] 激活完成" >> /opt/git/cron-do-something-actiave-glm4.7/fuck5hours.md
echo "---" >> /opt/git/cron-do-something-actiave-glm4.7/fuck5hours.md

exit 0
