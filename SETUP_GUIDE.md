# 🎯 Hexo 博客项目配置指南

> 这是一个完整的个人博客项目，采用**纯手动方案**：本地 Markdown 编写 + Hexo 构建 + Git 版本控制

## 📋 当前项目结构

```
blog/
├── source/                          # 文章源文件
│   ├── _posts/                      # 已发布的文章
│   │   └── welcome.md              # 示例文章
│   └── _drafts/                     # 草稿（不会发布）
│
├── themes/                          # 主题目录
│   └── landscape/                   # 默认主题
│
├── public/                          # 生成的静态网站（勿编辑）
│   └── （执行 npm run build 后生成）
│
├── .github/
│   └── workflows/
│       └── deploy.yml              # GitHub Actions 自动部署配置
│
├── _config.yml                      # ⚙️ 博客核心配置文件
├── package.json                     # 项目依赖配置
├── WORKFLOW.md                      # 📖 工作流完整指南
├── README.md                        # 项目说明
└── publish.sh                       # 🚀 快速发布脚本
```

---

## 🔧 第一次运行：初始化配置

### 1️⃣ 创建 Git 仓库

```bash
cd blog

# 初始化 Git（如果还没有）
git init
git add .
git commit -m "Initial commit: Hexo blog setup"

# 添加远程仓库
git remote add origin https://github.com/[你的用户名]/[仓库名].git
git branch -M main
git push -u origin main
```

### 2️⃣ 设置 _config.yml（重要！）

编辑 `_config.yml`，这是你的博客配置核心：

```yaml
# Site 信息
title: 你的博客标题              # 显示在网站标题
subtitle: 你的副标题              # 网站副标题
description: 网站描述             # SEO 描述
keywords: 关键词1,关键词2         # SEO 关键词
author: 你的名字                   # 作者名
language: zh-CN                    # 语言
timezone: Asia/Shanghai            # 时区

# URL 配置
url: https://yourblog.com         # 你的域名（重要！）
root: /                            # 根路径
permalink: :year/:month/:day/:title/  # 文章链接格式

# 文章配置
new_post_name: :title.md          # 新文章文件名格式
default_layout: post               # 默认布局

# 主题配置
theme: landscape                   # 使用的主题
```

### 3️⃣ 本地测试

```bash
npm install          # 安装依赖
npm run server       # 启动本地预览
# 访问 http://localhost:4000
```

---

## 📝 日常工作流

### 快速创建和发布文章

```bash
# ✨ 使用脚本快速创建文章
bash publish.sh "我的第一篇文章"

# 或手动创建
hexo new "我的第一篇文章"
```

### 编辑文章

```
source/_posts/我的第一篇文章.md

---
title: 我的第一篇文章
date: 2026-04-09
tags:
  - Hexo
  - 博客
categories:
  - 技术
description: 文章简介
---

# 文章标题

正文内容从这里开始...
```

### 本地预览

```bash
npm run server
# http://localhost:4000 查看实时更新
```

### 构建和部署

```bash
# 方式一：使用脚本（推荐）
npm run build
git add .
git commit -m "Add: 我的第一篇文章"
git push origin main

# 方式二：写成 shell 脚本
# #!/bin/bash
# npm run build
# git add .
# git commit -m "Auto deploy"
# git push origin main
```

---

## 🚀 部署方式选择

### 方案一：GitHub Pages（⭐ 强烈推荐）

**优点：** 完全免费，无需管理服务器，自动 HTTPS

#### 步骤 1：安装部署工具
```bash
npm install hexo-deployer-git --save
```

#### 步骤 2：配置 _config.yml
在文件末尾添加：
```yaml
deploy:
  type: git
  repo: https://github.com/[用户名]/[用户名].github.io.git
  branch: main
```

#### 步骤 3：一键部署
```bash
npm run deploy
```

#### 步骤 4：访问你的博客
```
https://[用户名].github.io
```

**自定义域名：**
1. 在项目根目录创建 `source/CNAME` 文件，内容为你的域名
2. 在域名提供商那里，将 A 记录指向 GitHub Pages IP

---

### 方案二：自己的服务器

#### 准备工作
1. 购买云服务器（阿里云、腾讯云、DigitalOcean 等）
2. 配置 Nginx 或 Apache
3. 配置 SSH 密钥

#### 部署脚本
```bash
# deploy-to-server.sh
#!/bin/bash

echo "构建中..."
npm run clean
npm run build

echo "上传到服务器..."
scp -r public/* your-user@your-server:/var/www/blog/

echo "✅ 部署完成！"
```

---

### 方案三：GitHub Actions 自动部署

已配置在 `.github/workflows/deploy.yml`

**工作流：**
1. 本地编写文章
2. `git push` 到 main 分支
3. GitHub Actions 自动构建和部署
4. 网站自动更新

**注意：** 需要配置 GitHub Pages 指向 `gh-pages` 分支

---

## 📚 常见问题解决

### Q1: 如何更改主题？

```bash
# 下载主题
git clone https://github.com/next-theme/hexo-theme-next.git themes/next

# 修改 _config.yml
theme: next

# 重启服务器
npm run server
```

### Q2: 样式不显示？

```bash
npm run clean
npm run build
npm run server
```

### Q3: 文章没有显示？

- ✅ 确保文件在 `source/_posts/` 目录
- ✅ 检查文件扩展名为 `.md`
- ✅ 确保 YAML Front Matter 格式正确
- ✅ 检查 `date` 不要是未来时间

### Q4: 如何添加页面（关于、友链等）？

```bash
hexo new page "about"
# 编辑 source/about/index.md
```

### Q5: 如何添加评论系统？

编辑 `_config.yml`，添加：
```yaml
disqus_shortname: your-disqus-shortname
```

---

## 🔐 重要提示

1. **不要上传 node_modules 和 public 目录**
   ```
   # .gitignore 中已配置
   node_modules/
   public/
   .DS_Store
   ```

2. **定期备份**
   ```bash
   git push origin main  # 备份源文件
   ```

3. **生成 Sitemap 和 RSS**
   ```bash
   npm install hexo-generator-sitemap --save
   npm install hexo-generator-feed --save
   ```

4. **SEO 优化**
   - 每篇文章设置有意义的 title
   - 添加合适的 description
   - 使用相关的 tags 和 categories

---

## 📖 有用的资源

- 📚 [Hexo 官方文档](https://hexo.io/docs)
- 🎨 [主题列表](https://hexo.io/themes)
- 📝 [Markdown 语法](https://markdown.com.cn)
- 🚀 [GitHub Pages Guide](https://pages.github.com)

---

## ✅ 快速检查清单

部署前检查：

- [ ] 修改了 `_config.yml` 中的 `title`, `author`, `url`
- [ ] 测试了本地预览 `npm run server`
- [ ] 构建成功 `npm run build`
- [ ] 提交到 Git
- [ ] 推送到远程仓库

---

祝你的博客写作顺利！🚀✨
