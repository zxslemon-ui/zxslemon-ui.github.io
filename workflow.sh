#!/bin/bash

# 🎯 Hexo Blog 完整发布流程脚本
# 自动执行从编写到部署的全过程

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 显示菜单
show_menu() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════╗"
    echo "║   🚀 Hexo Blog 工作流助手              ║"
    echo "╚══════════════════════════════════════════╝${NC}"
    echo ""
    echo "请选择操作："
    echo "  1️⃣  - 启动本地预览 (npm run server)"
    echo "  2️⃣  - 创建新文章 (hexo new)"
    echo "  3️⃣  - 构建生成 (npm run build)"
    echo "  4️⃣  - 清除缓存 (npm run clean)"
    echo "  5️⃣  - 完整构建+部署流程"
    echo "  6️⃣  - 显示 Git 状态"
    echo "  7️⃣  - Git 提交"
    echo "  0️⃣  - 退出"
    echo ""
}

# 启动本地预览
start_server() {
    echo -e "${GREEN}🌐 启动本地预览服务器...${NC}"
    echo "访问地址: http://localhost:4000"
    npm run server
}

# 创建新文章
create_post() {
    read -p "请输入文章标题: " title
    if [ -z "$title" ]; then
        echo -e "${RED}❌ 文章标题不能为空${NC}"
        return 1
    fi
    
    echo -e "${GREEN}📝 创建文章: $title${NC}"
    hexo new "$title"
    
    # 查找新创建的文件
    POST_FILE=$(find source/_posts -name "*.md" -type f -printf '%T@ %p\n' | sort -rn | head -1 | cut -d' ' -f2-)
    
    echo -e "${GREEN}✅ 文章已创建: $POST_FILE${NC}"
    
    # 提供打开编辑器的选项
    if command -v code &> /dev/null; then
        read -p "是否用 VS Code 打开？(y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            code "$POST_FILE"
        fi
    fi
}

# 构建生成
build() {
    echo -e "${GREEN}🔨 构建静态文件...${NC}"
    npm run build
    echo -e "${GREEN}✅ 构建完成！${NC}"
}

# 清除缓存
clean() {
    echo -e "${YELLOW}🧹 清除缓存...${NC}"
    npm run clean
    echo -e "${GREEN}✅ 缓存已清除${NC}"
}

# 完整流程
full_deploy() {
    echo -e "${BLUE}════════════════════════════════════════${NC}"
    echo -e "${YELLOW}🚀 开始完整发布流程${NC}"
    echo -e "${BLUE}════════════════════════════════════════${NC}"
    
    # 1. 清除缓存
    echo -e "${YELLOW}1️⃣  清除缓存...${NC}"
    npm run clean
    
    # 2. 构建
    echo -e "${YELLOW}2️⃣  构建静态文件...${NC}"
    npm run build
    
    # 3. 显示 Git 状态
    echo -e "${YELLOW}3️⃣  检查 Git 状态...${NC}"
    git status
    
    # 4. 询问是否提交
    read -p "是否提交到 Git?(y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "输入提交信息: " commit_msg
        if [ -z "$commit_msg" ]; then
            commit_msg="Update blog"
        fi
        
        echo -e "${YELLOW}4️⃣  提交到 Git...${NC}"
        git add .
        git commit -m "$commit_msg"
        git push origin main
        
        echo -e "${GREEN}✅ 已推送到远程仓库${NC}"
    fi
    
    # 5. 询问是否部署
    read -p "是否执行部署?(y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}5️⃣  部署到服务器...${NC}"
        npm run deploy 2>/dev/null || echo -e "${YELLOW}⚠️  部署命令未配置${NC}"
    fi
    
    echo -e "${BLUE}════════════════════════════════════════${NC}"
    echo -e "${GREEN}✨ 发布流程完成！${NC}"
    echo -e "${BLUE}════════════════════════════════════════${NC}"
}

# Git 状态
git_status() {
    echo -e "${BLUE}📊 Git 状态：${NC}"
    git status
}

# Git 提交
git_commit() {
    echo -e "${YELLOW}💾 Git 提交${NC}"
    
    # 显示当前修改
    echo -e "${BLUE}当前修改：${NC}"
    git status --short
    
    echo ""
    read -p "输入提交信息: " commit_msg
    
    if [ -z "$commit_msg" ]; then
        echo -e "${RED}❌ 提交信息不能为空${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}提交中...${NC}"
    git add .
    git commit -m "$commit_msg"
    
    read -p "是否推送到远程仓库?(y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git push origin main
        echo -e "${GREEN}✅ 已推送${NC}"
    fi
}

# 主循环
while true; do
    show_menu
    read -p "选择操作 (0-7): " choice
    
    case $choice in
        1) start_server ;;
        2) create_post ;;
        3) build ;;
        4) clean ;;
        5) full_deploy ;;
        6) git_status ;;
        7) git_commit ;;
        0) 
            echo -e "${BLUE}👋 再见！${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ 无效选择，请重试${NC}"
            ;;
    esac
    
    echo ""
    read -p "按 Enter 继续..."
    clear
done
