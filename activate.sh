#!/bin/bash

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
