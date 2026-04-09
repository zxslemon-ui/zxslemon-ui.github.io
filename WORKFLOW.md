# 📝 纯手动博客工作流指南

## 🎯 方案概述

**本方案特点：**
- ✅ 完全自主控制 - 无平台依赖
- ✅ 零成本运行 - 仅需一个 Git 仓库
- ✅ 极致性能 - 纯静态网站
- ⚙️ 需要基础技术能力 - 适合开发者

---

## 📋 核心工作流

```
┌─────────────────────────────────────────────────────┐
│  1️⃣ 本地写作                                         │
│  在 source/_posts/ 中编写 Markdown 文章               │
└─────────────────────┬───────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────┐
│  2️⃣ 本地预览                                         │
│  运行 npm run server 在本地 http://localhost:4000    │
└─────────────────────┬───────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────┐
│  3️⃣ 构建生成                                         │
│  运行 npm run build 生成静态文件到 public/           │
└─────────────────────┬───────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────┐
│  4️⃣ 提交版本控制                                     │
│  git add . → git commit → git push                   │
└─────────────────────┬───────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────┐
│  5️⃣ 自动部署                                         │
│  GitHub Actions 自动构建并部署到服务器               │
└─────────────────────────────────────────────────────┘
```

---

## 🚀 快速开始

### 第一步：安装依赖

```bash
cd blog
npm install
```

### 第二步：本地开发

```bash
# 启动本地预览服务器
npm run server

# 访问 http://localhost:4000 即可看到博客
```

### 第三步：写文章

```bash
# 方式一：使用命令生成文章模板
hexo new "我的第一篇文章"

# 方式二：手动创建
# 新建文件：source/_posts/my-first-post.md
```

### 第四步：文章格式

```markdown
---
title: 文章标题
date: 2026-04-09
updated: 2026-04-09
tags:
  - 标签1
  - 标签2
categories:
  - 分类
description: 文章简述
---

# 正文内容

从这里开始写你的内容...
```

### 第五步：本地测试

```bash
# 实时预览（带自动刷新）
npm run server

# 或者先生成再预览
npm run build
npm run server
```

---

## 💾 发布到 Git

### 初始化仓库

```bash
# 如果还没有 Git 仓库
git init
git add .
git commit -m "Initial commit: Hexo blog setup"
git remote add origin [你的仓库地址]
git push -u origin main
```

### 更新博客

```bash
# 1. 编写文章（source/_posts/xxx.md）

# 2. 本地测试
npm run server

# 3. 构建生成
npm run build

# 4. 提交代码
git add .
git commit -m "Add new post: [文章标题]"
git push origin main
```

---

## 🔧 部署选项

### 方案A：GitHub Pages（推荐新手）

#### 1️⃣ 安装部署工具
```bash
npm install hexo-deployer-git --save
```

#### 2️⃣ 配置 _config.yml
```yaml
# 在 _config.yml 最后添加
deploy:
  type: git
  repo: https://github.com/[用户名]/[用户名].github.io.git
  branch: main
```

#### 3️⃣ 一键部署
```bash
npm run deploy
# 2-5分钟后访问 https://[用户名].github.io 即可
```

### 方案B：自己的服务器

#### 1️⃣ 准备服务器
- 购买云服务器（阿里云/腾讯云/DigitalOcean等）
- 配置 SSH 密钥

#### 2️⃣ 配置部署脚本
```bash
# 在项目根目录创建 deploy.sh
#!/bin/bash

# 生成静态文件
npm run build

# 上传到服务器
scp -r public/* your-user@your-server:/var/www/html/

echo "✅ 部署完成！"
```

#### 3️⃣ 运行部署
```bash
chmod +x deploy.sh
./deploy.sh
```

### 方案C：GitHub Actions 自动部署

创建文件：`.github/workflows/deploy.yml`

```yaml
name: Hexo Deploy

on:
  push:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm install
      
      - name: Build
        run: npm run build
      
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
```

---

## 📁 项目结构说明

```
blog/
├── source/              # 文章源文件目录
│   ├── _posts/         # 博客文章（Markdown格式）
│   └── _drafts/        # 草稿文章（未发布）
├── themes/             # 主题目录
├── public/             # 构建输出目录（生成的静态网站）
├── _config.yml         # 博客配置文件（重要！）
├── package.json        # 项目依赖配置
└── scaffolds/          # 文章模板
```

---

## ✍️ 常用命令

```bash
# 启动本地服务器
npm run server

# 生成静态文件
npm run build

# 清除缓存
npm run clean

# 创建新文章
hexo new "文章标题"

# 创建草稿
hexo new draft "草稿标题"

# 发布草稿
hexo publish "草稿标题"

# 一键部署
npm run deploy
```

---

## 🎨 主题更换

```bash
# 安装主题（以 Next 主题为例）
git clone https://github.com/next-theme/hexo-theme-next themes/next

# 在 _config.yml 中修改
theme: next

# 重启服务器生效
npm run server
```

---

## 🔍 SEO 优化

### 1️⃣ 安装SEO插件
```bash
npm install hexo-seo-friendly-sitemap --save
npm install hexo-seo-friendly-rss --save
```

### 2️⃣ 配置 _config.yml
```yaml
# 添加到 _config.yml
feed:
  type: atom
  path: atom.xml
  limit: 20
```

### 3️⃣ 优化文章
- 每篇文章设置合理的 title 和 description
- 使用相关的 tags 和 categories
- 文章配图使用有意义的名称

---

## 📊 常见问题

### Q1: 如何修改域名？
编辑 `_config.yml` 的 `url` 字段：
```yaml
url: https://yourdomain.com
```

### Q2: 如何修改博客标题？
编辑 `_config.yml` 的 `title` 字段：
```yaml
title: 你的博客名称
```

### Q3: 本地预览时，样式加载不完整？
```bash
# 清除缓存重新生成
npm run clean
npm run build
npm run server
```

### Q4: 如何备份博客？
```bash
# 整个 blog 目录就是备份
# 定期 git push 即可备份所有内容
git push origin main
```

---

## 📚 进阶配置

### 添加分析统计
```yaml
# _config.yml
google_analytics: UA-XXXXXXX-XX
```

### 启用评论系统
```yaml
disqus_shortname: your_short_name
```

### 自定义菜单
```yaml
menu:
  首页: /
  归档: /archives/
  标签: /tags/
  分类: /categories/
  关于: /about/
```

---

## 🎯 完整发布流程（总结）

```bash
# 1. 进入项目目录
cd blog

# 2. 创建新文章
hexo new "我的新文章"

# 3. 编辑文章
# 打开 source/_posts/我的新文章.md 进行编辑

# 4. 本地预览
npm run server
# 访问 http://localhost:4000 查看效果

# 5. 构建生成
npm run build

# 6. 提交版本控制
git add .
git commit -m "Add: 我的新文章"
git push origin main

# 7. 部署（如果配置了部署工具）
npm run deploy
```

---

## 💡 推荐实践

1. **主分支保持纯净** - main 分支仅保存源文件
2. **定期提交** - 每周至少 git push 一次作为备份
3. **文章模板** - 使用统一的前置元数据格式
4. **本地预览** - 不要跳过本地测试就直接部署
5. **备份策略** - 在 GitHub / GitLab 都保存一份备份

---

祝您写作愉快！🎉
