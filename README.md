# My Blog

> 个人博客 - 采用纯手动方案（本地 Markdown + Hexo + Git）

## ⚡ 快速开始（30秒）

```bash
# 1. 安装依赖
npm install

# 2. 启动本地预览
npm run server

# 3. 访问 http://localhost:4000
```

## 📖 工作流速览

```
Write Markdown  →  Local Preview  →  Build  →  Git Push  →  Auto Deploy
  本地编写         本地调试        生成      版本提交      自动发布
```

## 📁 项目结构

| 目录 | 说明 |
|------|------|
| `source/_posts/` | 📄 博客文章存放位置 |
| `themes/` | 🎨 博客主题 |
| `public/` | 📦 生成的静态网站（勿编辑） |
| `_config.yml` | ⚙️ 博客配置文件 |

## 🚀 常用命令

```bash
npm run server      # 启动本地服务
npm run build       # 生成静态文件
npm run clean       # 清除缓存
npm run deploy      # 部署到 GitHub Pages
hexo new "标题"    # 创建新文章
```

## 📝 发布新文章

```bash
# 方式一：快速脚本（自动打开编辑器）
bash publish.sh "我的文章标题"

# 方式二：命令行
hexo new "我的文章标题"

# 方式三：手动
# 创建文件 source/_posts/my-post.md
```

## 🔧 文章格式

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
description: 文章简要描述
---

# 文章正文

从这里开始写你的内容...
```

## 🌐 部署方式

### 方式 1️⃣：GitHub Pages（推荐）

```bash
# 1. 安装部署工具
npm install hexo-deployer-git --save

# 2. 编辑 _config.yml
# deploy:
#   type: git
#   repo: https://github.com/[用户名]/[用户名].github.io.git
#   branch: main

# 3. 一键部署
npm run deploy
```

访问 `https://[用户名].github.io`

### 方式 2️⃣：自定义服务器

```bash
npm run build
scp -r public/* your-server:/var/www/blog/
```

### 方式 3️⃣：自动部署（GitHub Actions）

推送到 main 分支，自动构建和部署

---

## 📚 详细文档

- 📖 **[完整工作流指南](./WORKFLOW.md)** - 详细的发布流程和部署指南
- ⚙️ **[项目配置指南](./SETUP_GUIDE.md)** - 配置说明和常见问题解决

## 🎨 修改博客配置

编辑 `_config.yml`：

```yaml
# 网站信息
title: 你的博客标题
subtitle: 副标题
description: 网站描述
author: 你的名字
language: zh-CN

# 网址
url: https://yourblog.com  # 修改为你的域名
root: /

# 主题
theme: landscape  # 可改为其他主题
```

## 🎯 常见操作

### 本地测试后部署

```bash
# 1. 编写文章
# 2. 本地预览（验证无误）
npm run server

# 3. 生成静态文件
npm run build

# 4. 提交版本控制
git add .
git commit -m "Add: 文章标题"
git push origin main

# 5. 部署（如果配置了）
npm run deploy
```

### 修改主题

```bash
# 下载新主题
git clone https://github.com/theme-owner/hexo-theme-name.git themes/theme-name

# 修改 _config.yml
# theme: theme-name

# 重启服务器
npm run server
```

### 添加分类/标签页面

```bash
# 创建分类页面
hexo new page categories

# 创建标签页面
hexo new page tags
```

编辑文件，添加下列内容：

```markdown
---
title: 分类
type: categories
layout: categories
---
```

## 🔗 有用链接

- 🏠 [Hexo 官网](https://hexo.io)
- 🎨 [主题库](https://hexo.io/themes)
- 📚 [Hexo 文档](https://hexo.io/docs)
- 🖊️ [Markdown 语法](https://markdown.com.cn)

## ⚡ 优势与特点

- ✅ **完全自主** - 无平台限制，代码100%属于你
- ✅ **成本极低** - GitHub Pages 免费托管
- ✅ **性能出众** - 纯静态网站，加载极快
- ✅ **版本控制** - 所有文章都有 Git 记录
- ✅ **易于备份** - 整个项目就是备份
- ✅ **灵活定制** - 完全控制每个细节

## 💡 工作流建议

1. 在 `source/_posts/` 中编写 Markdown 文章
2. 使用 `npm run server` 本地预览
3. 满意后运行 `npm run build`
4. 使用 `git add/commit/push` 保存版本
5. 自动部署到 GitHub Pages 或自定义服务器

---

**开心创作！✨**

有问题？查看 [WORKFLOW.md](./WORKFLOW.md) 或 [SETUP_GUIDE.md](./SETUP_GUIDE.md)
