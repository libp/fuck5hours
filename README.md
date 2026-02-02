# Claude 套餐自动激活工具

自动激活 Claude 套餐 5 小时有效期的定时任务工具。

## 背景

Claude 套餐有 5 小时的有效期限制。本工具通过 cron 定时任务，定期执行简单的 Claude 调用，确保有效期持续激活。

## 功能

- 自动调用 `bunx claude` 执行简单任务
- 激活 5 小时套餐有效期
- 记录激活日志到 `fuck5hours.md`
- 支持 cron 定时执行

## 文件说明

```
.
├── activate.sh       # 激活脚本
├── fuck5hours.md     # 激活日志
├── .claude/          # Claude 配置目录
└── README.md         # 本文件
```

## 使用方法

### 手动执行

```bash
./activate.sh
```

### 配置 cron 定时任务

编辑 crontab：

```bash
crontab -e
```

添加定时任务（每 4 小时执行一次）：

```cron
0 */4 * * * /opt/git/cron-do-something-actiave-glm4.7/activate.sh
```

### 查看激活日志

```bash
cat fuck5hours.md
```

## 工作原理

1. 脚本记录当前时间
2. 调用 `bunx claude` 执行简单任务（如 `1+1`）
3. 将执行输出写入日志文件
4. 完成激活，延长 5 小时有效期

## 定时策略建议

| 频率 | Cron 表达式 | 说明 |
|------|------------|------|
| 每 4 小时 | `0 */4 * * *` | 推荐，确保持续覆盖 5 小时有效期 |
| 每 3 小时 | `0 */3 * * *` | 更保守，留有余量 |

## 要求

- 已安装 `bun`
- 已配置 `claude` CLI 工具
- 脚本执行权限：`chmod +x activate.sh`

## License

MIT
