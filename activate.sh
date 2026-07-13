#!/bin/bash


# 尽量加载常见的环境（根据你自己的情况选择性保留）
# ~/.bashrc、~/.bash_profile 通常含 bash 专属语法（如 shopt），只能在 bash 下加载，
# 否则用 sh/dash 运行时会报 "shopt: not found"
if [ -n "$BASH_VERSION" ]; then
    [ -f ~/.bashrc ] && . ~/.bashrc
    [ -f ~/.bash_profile ] && . ~/.bash_profile
fi
[ -f ~/.profile ] && . ~/.profile

# bun 的路径（非常重要）
export PATH="/root/.bun/bin:$PATH"

# 工作目录与日志文件
DIR="/opt/git/cron-do-something-actiave-glm4.7"
LOG_FILE="$DIR/fuck5hours.md"

# 确保之前手工在这个目录下启动过一次
# 在第一次运行时，会做交互式安全确认
cd "$DIR" || exit 1

# 带时间戳的日志输出
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "开始激活..."

# 使用 bunx claude 执行简单任务以激活5小时有效期
# 执行一个非常简单的任务：计算 1+1
# 针对 API 529 (overloaded_error / 该模型当前访问量过大) 等异常自动重试，最多重试 20 次
MAX_RETRIES=20
RETRY_DELAY=30  # 每次重试间隔（秒）

SUCCESS=0
for attempt in $(seq 1 $((MAX_RETRIES + 1))); do
    OUTPUT=$(/root/.bun/bin/bunx claude --print "1+1等于几？" 2>&1)
    EXIT_CODE=$?

    # 成功条件：退出码为 0 且输出中不含 "API Error"
    if [ $EXIT_CODE -eq 0 ] && ! echo "$OUTPUT" | grep -q "API Error"; then
        echo "$OUTPUT" >> "$LOG_FILE"
        SUCCESS=1
        break
    fi

    # 失败：记录错误输出
    echo "$OUTPUT" >> "$LOG_FILE"

    # 若仍有重试机会，等待后重试
    if [ $attempt -le $MAX_RETRIES ]; then
        log "调用失败，第 $attempt/$MAX_RETRIES 次重试（${RETRY_DELAY} 秒后）..."
        sleep "$RETRY_DELAY"
    fi
done

if [ $SUCCESS -eq 1 ]; then
    log "激活成功"
else
    log "激活失败：已达最大重试次数 $MAX_RETRIES"
fi

log "激活完成"
echo "---" >> "$LOG_FILE"

exit 0
