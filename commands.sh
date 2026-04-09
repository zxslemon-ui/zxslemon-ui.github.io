#!/bin/bash

# 📋 快速命令参考（可打印）
# 粘贴这些命令到终端快速执行

cat << 'EOF'

╔════════════════════════════════════════════════════════════════╗
║                 🚀 Hexo 博客快速命令参考                      ║
║              打印或收藏本页面以便快速查阅                    ║
╚════════════════════════════════════════════════════════════════╝


📍 项目位置
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
cd /Users/forforever/Documents/code/ai-code/ai-blog/blog


🚀 快速启动（3 步）
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
npm run server
# 然后访问 http://localhost:4000


📝 日常文章创建
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 方式 1：快速脚本（推荐）
bash publish.sh "我的文章标题"

# 方式 2：命令行
hexo new "我的文章标题"

# 然后编辑：source/_posts/我的文章标题.md


🔨 构建和部署
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
npm run build       # 生成静态文件
npm run clean       # 清除缓存（有问题时用）
npm run deploy      # 部署到服务器


💾 版本控制
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
git status          # 查看修改
git add .          # 暂存所有
git commit -m "msg" # 提交
git push origin main # 推送


🎨 工具脚本
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
bash init.sh        # 🎯 交互式初始化（首次运行）
bash publish.sh "标题"  # 📝 快速发布文章
bash workflow.sh    # 🔄 工作流菜单助手


📚 文档导航
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 GETTING_STARTED.md   👈 新手必读（3 分钟快速开始）
📖 README.md            项目概览
📖 WORKFLOW.md          完整工作流
⚙️ SETUP_GUIDE.md       配置说明
🎯 QUICK_REFERENCE.md   快速参考


⚡ 完整发布流程（复制即用）
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 1. 创建文章
hexo new "我的新文章"

# 2. 编辑文章（打开文本编辑器修改 source/_posts/xxx.md）

# 3. 本地预览
npm run server
# 访问 http://localhost:4000

# 4. 构建
npm run build

# 5. 提交代码
git add .
git commit -m "Add: 我的新文章"
git push origin main

# 6. 自动部署（GitHub Actions 自动执行）


需要修改的文件
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

_config.yml：
  title: 改成你的博客标题
  author: 改成你的名字
  url: 改成你的域名 (https://yourblog.com)


常用配置示例
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 更改主题
git clone https://github.com/theme-owner/hexo-theme-xxx.git themes/xxx
# 然后在 _config.yml 改: theme: xxx

# 部署到 GitHub Pages
npm install hexo-deployer-git --save
# 然后在 _config.yml 末尾添加:
# deploy:
#   type: git
#   repo: https://github.com/username/username.github.io.git
#   branch: main
npm run deploy


文章格式模板
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

---
title: 文章标题
date: 2026-04-09
updated: 2026-04-09
tags:
  - 标签1
  - 标签2
categories:
  - 分类
description: 简短描述
---

# 文章正文

你的内容从这里开始...


🆘 常见问题快速解决
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

问题：样式显示不正常
解决：npm run clean && npm run build && npm run server

问题：文章没在首页显示
检查：
  1. 文件在 source/_posts/ 目录
  2. 扩展名是 .md
  3. YAML Front Matter 格式正确

问题：本地预览无法访问
原因：4000 端口被占用
解决：hexo server -p 5000  # 改用 5000 端口


🎯 初次使用完整步骤
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1️⃣  进入项目目录
    cd /Users/forforever/Documents/code/ai-code/ai-blog/blog

2️⃣  运行初始化脚本（可选但推荐）
    bash init.sh

3️⃣  启动本地预览
    npm run server

4️⃣  打开浏览器
    http://localhost:4000

5️⃣  创建第一篇文章
    hexo new "我的第一篇文章"

6️⃣  编辑文章内容
    source/_posts/我的第一篇文章.md

7️⃣  查看效果（浏览器自动刷新）

8️⃣  提交到 Git
    git add .
    git commit -m "Add: 我的第一篇文章"
    git push origin main

9️⃣  自动部署完成！


💡 专业提示
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ 每次编辑保存后，npm run server 会自动刷新
✓ 大量修改前先 git commit，方便回滚
✓ 定期 git push 备份你的文章
✓ 使用 git log 查看历史记录


╔════════════════════════════════════════════════════════════════╗
║  📖 完整文档：查看 GETTING_STARTED.md                         ║
║  🆘 问题排查：查看 SETUP_GUIDE.md                            ║
║  📚 详细指南：查看 WORKFLOW.md                                ║
╚════════════════════════════════════════════════════════════════╝

EOF
