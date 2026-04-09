#!/bin/bash

# 🚀 Hexo Blog 一键部署脚本
# 使用: bash publish.sh "文章标题"

set -e  # 发生错误时停止执行

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查是否提供了文章标题
if [ -z "$1" ]; then
    echo -e "${RED}❌ 错误: 请提供文章标题${NC}"
    echo "使用方法: bash publish.sh \"你的文章标题\""
    exit 1
fi

TITLE="$1"
DATE=$(date '+%Y-%m-%d')

echo -e "${YELLOW}📝 创建新文章: $TITLE${NC}"
echo "📅 日期: $DATE"
echo ""

# 1️⃣ 创建文章
echo -e "${GREEN}1️⃣  正在生成文章模板...${NC}"
hexo new "$TITLE"

# 获取生成的文件名
POST_FILE="source/_posts/$(echo $TITLE | tr ' ' '-' | tr A-Z a-z).md"

# 如果自动命名失败，尝试查找最新创建的文件
if [ ! -f "$POST_FILE" ]; then
    POST_FILE=$(find source/_posts -name "*.md" -type f -printf '%T@ %p\n' | sort -rn | head -1 | cut -d' ' -f2-)
fi

echo -e "${GREEN}✅ 文章已创建: $POST_FILE${NC}"
echo ""

# 2️⃣ 本地预览提示
echo -e "${YELLOW}2️⃣  文章编辑完成后，使用以下命令预览:${NC}"
echo -e "${YELLOW}   npm run server${NC}"
echo -e "${YELLOW}   访问: http://localhost:4000${NC}"
echo ""

# 3️⃣ 打开编辑器（如果配置了 EDITOR 环境变量）
if command -v code &> /dev/null; then
    echo -e "${GREEN}3️⃣  自动打开 VS Code...${NC}"
    code "$POST_FILE"
elif [ -n "$EDITOR" ]; then
    echo -e "${GREEN}3️⃣  打开编辑器...${NC}"
    $EDITOR "$POST_FILE"
else
    echo -e "${YELLOW}3️⃣  请用你的编辑器打开此文件进行编辑:${NC}"
    echo -e "${YELLOW}   $POST_FILE${NC}"
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✨ 文章创建完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "📋 后续步骤:"
echo "  1. 编辑文章内容"
echo "  2. 运行 'npm run server' 本地预览"
echo "  3. 运行 'npm run build' 生成静态文件"
echo "  4. 运行 'git add . && git commit -m \"Add: $TITLE\" && git push'"
echo ""
