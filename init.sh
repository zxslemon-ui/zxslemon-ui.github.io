#!/bin/bash

# 🎯 Hexo Blog 一键初始化脚本
# 首次使用运行此脚本以完成必要的初始化

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════╗"
echo "║  🚀 Hexo 博客项目初始化向导                   ║"
echo "╚════════════════════════════════════════════════╝${NC}"
echo ""

# 步骤 1: 检查和创建 git 仓库
echo -e "${YELLOW}第 1 步: 初始化 Git 仓库${NC}"
if [ -d ".git" ]; then
    echo -e "${GREEN}✅ Git 仓库已存在${NC}"
else
    echo "初始化 Git..."
    git init
    git add .
    git commit -m "Initial commit: Hexo blog setup"
    echo -e "${GREEN}✅ Git 仓库已创建${NC}"
fi

echo ""
echo -e "${YELLOW}第 2 步: 配置博客信息${NC}"
echo ""
echo "请输入以下信息（直接点击回车使用默认值）："
echo ""

read -p "📝 博客标题 (默认: 我的个人博客): " TITLE
TITLE=${TITLE:-"我的个人博客"}

read -p "📝 博客副标题 (默认: 技术分享与思考): " SUBTITLE
SUBTITLE=${SUBTITLE:-"技术分享与思考"}

read -p "✍️ 作者名字 (默认: Developer): " AUTHOR
AUTHOR=${AUTHOR:-"Developer"}

read -p "🌐 网址/域名 (默认: https://example.com): " URL
URL=${URL:-"https://example.com"}

read -p "🇨🇳 语言 (默认: zh-CN): " LANGUAGE
LANGUAGE=${LANGUAGE:-"zh-CN"}

read -p "⏰ 时区 (默认: Asia/Shanghai): " TIMEZONE
TIMEZONE=${TIMEZONE:-"Asia/Shanghai"}

# 更新 _config.yml
echo -e "${YELLOW}更新配置文件...${NC}"

# 使用 sed 更新值（跨平台兼容）
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s/^title:.*$/title: $TITLE/" _config.yml
    sed -i '' "s/^subtitle:.*$/subtitle: $SUBTITLE/" _config.yml
    sed -i '' "s/^author:.*$/author: $AUTHOR/" _config.yml
    sed -i '' "s|^url:.*$|url: $URL|" _config.yml
    sed -i '' "s/^language:.*$/language: $LANGUAGE/" _config.yml
    sed -i '' "s/^timezone:.*$/timezone: $TIMEZONE/" _config.yml
else
    # Linux
    sed -i "s/^title:.*$/title: $TITLE/" _config.yml
    sed -i "s/^subtitle:.*$/subtitle: $SUBTITLE/" _config.yml
    sed -i "s/^author:.*$/author: $AUTHOR/" _config.yml
    sed -i "s|^url:.*$|url: $URL|" _config.yml
    sed -i "s/^language:.*$/language: $LANGUAGE/" _config.yml
    sed -i "s/^timezone:.*$/timezone: $TIMEZONE/" _config.yml
fi

echo -e "${GREEN}✅ 配置已保存到 _config.yml${NC}"

echo ""
echo -e "${YELLOW}第 3 步: 部署方式选择${NC}"
echo ""
echo "请选择部署方式:"
echo "  1) GitHub Pages (推荐、完全免费)"
echo "  2) 自定义服务器"
echo "  3) 跳过（稍后配置）"
echo ""

read -p "选择 (1/2/3): " DEPLOY_CHOICE

case $DEPLOY_CHOICE in
    1)
        echo ""
        read -p "请输入 GitHub 用户名: " GITHUB_USER
        read -p "请输入 GitHub 仓库名 (通常为: $GITHUB_USER.github.io): " GITHUB_REPO
        GITHUB_REPO=${GITHUB_REPO:-"$GITHUB_USER.github.io"}
        
        echo -e "${YELLOW}配置 GitHub Pages 部署...${NC}"
        npm install hexo-deployer-git --save
        
        cat >> _config.yml << EOF

# Deployment
deploy:
  type: git
  repo: https://github.com/$GITHUB_USER/$GITHUB_REPO.git
  branch: main
EOF
        
        echo -e "${GREEN}✅ GitHub Pages 已配置${NC}"
        echo "访问: https://$GITHUB_USER.github.io"
        ;;
    2)
        echo -e "${YELLOW}请手动修改 _config.yml 中的 deploy 配置${NC}"
        echo "查看 SETUP_GUIDE.md 了解详情"
        ;;
    3)
        echo -e "${YELLOW}部署配置已跳过${NC}"
        ;;
esac

echo ""
echo -e "${GREEN}"
echo "╔════════════════════════════════════════════════╗"
echo "║  ✨ 初始化完成！                              ║"
echo "╚════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${BLUE}📚 文档位置：${NC}"
echo "  • 快速开始: README.md"
echo "  • 完整指南: WORKFLOW.md"
echo "  • 配置说明: SETUP_GUIDE.md"
echo "  • 快速参考: QUICK_REFERENCE.md"
echo ""

echo -e "${BLUE}🚀 快速开始：${NC}"
echo "  # 启动本地预览"
echo "  npm run server"
echo ""
echo "  # 访问"
echo "  http://localhost:4000"
echo ""

echo -e "${BLUE}📝 创建文章：${NC}"
echo "  hexo new \"我的第一篇文章\""
echo ""

echo -e "${BLUE}🎯 完整流程：${NC}"
echo "  1. npm run server        # 本地预览"
echo "  2. hexo new \"标题\"     # 创建文章"
echo "  3. npm run build         # 构建生成"
echo "  4. git add && git commit # 提交代码"
echo "  5. npm run deploy        # 部署"
echo ""

echo -e "${YELLOW}💡 提示：${NC}"
echo "  使用 './workflow.sh' 获得交互式工作流助手"
echo ""

echo -e "${BLUE}现在就开始吧！✨${NC}"
