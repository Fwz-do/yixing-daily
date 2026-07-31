#!/usr/bin/env bash
# 宜兴日报部署脚本
# 用法: ./deploy.sh <生成好的当日日报HTML文件路径>
# 效果: 覆盖部署到固定URL对应的文件（URL本身不变，只更新内容）
set -euo pipefail

SRC="${1:?用法: deploy.sh <日报HTML文件路径>}"
DEST="/var/www/html/pages/yixing-daily-v2-20260730.html"

if [ ! -f "$SRC" ]; then
  echo "错误：源文件不存在: $SRC" >&2
  exit 1
fi

# 部署前先备份线上当前版本（含时间戳），防止误覆盖无法回滚
if [ -f "$DEST" ]; then
  cp "$DEST" "${DEST}.bak-$(date +%Y%m%d-%H%M%S)"
fi

cp "$SRC" "$DEST"
echo "已部署: $DEST"
echo "线上URL: https://api.lexoavatar.com/pages/yixing-daily-v2-20260730.html"
