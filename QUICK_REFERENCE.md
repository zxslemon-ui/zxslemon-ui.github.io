# 🚀 Hexo Blog 快速参考

## ⚡ 基础命令

```bash
npm run server    # 📝 启动本地服务 (localhost:4000)
npm run build     # 🔨 生成静态文件到 public/
npm run clean     # 🧹 清除缓存和生成的文件
npm run deploy    # 🚀 部署到配置的服务器
hexo new "标题"  # ✍️ 创建新文章
```

## 📋 工作流快速清单

```bash
# 1. 创建文章
hexo new "我的文章标题"
# ↓ 编辑 source/_posts/xxx.md

# 2. 本地预览
npm run server
# ↓ 访问 http://localhost:4000

# 3. 构建
npm run build

# 4. 提交代码
git add .
git commit -m "Add: 我的文章标题"
git push origin main

# 5. 部署
npm run deploy  # (如果配置了部署)
```

## 📁 重要文件说明

| 文件 | 用途 |
|------|------|
| `_config.yml` | ⚙️ 博客配置（网站名、域名等） |
| `source/_posts/` | 📄 所有文章放这里 |
| `themes/` | 🎨 主题文件 |
| `public/` | 📦 生成的网站（不要手动编辑） |

## 🔧 常见配置修改

### 修改网站标题
```yaml
# _config.yml
title: 你的网站标题
subtitle: 副标题
author: 你的名字
```

### 修改域名
```yaml
# _config.yml
url: https://yourdomain.com
```

### 部署到 GitHub Pages
```yaml
# _config.yml
deploy:
  type: git
  repo: https://github.com/username/username.github.io.git
  branch: main
```

## 📝 文章 Markdown 模板

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
description: 简短描述（显示在列表）
---

# 正文标题

正文内容...

## 子标题

更多内容...
```

## 🐛 常见问题排查

| 问题 | 解决方案 |
|------|--------|
| 样式加载不完整 | `npm run clean && npm run build && npm run server` |
| 文章没显示 | 检查文件位置和 YAML Front Matter 格式 |
| 本地预览无法访问 | 检查 4000 端口是否被占用 |
| 部署失败 | 检查 _config.yml 中 deploy 配置 |

## 🎯 推荐工作流

1. ✍️ **编写** - 在 `source/_posts/` 中创建 `.md` 文件
2. 👀 **预览** - `npm run server` 本地测试
3. 🔨 **构建** - `npm run build` 生成静态文件
4. 💾 **保存** - `git add/commit/push` 版本控制
5. 🚀 **发布** - `npm run deploy` 自动上线

## 📚 常用 Markdown 语法

```markdown
# 标题 1
## 标题 2
### 标题 3

**粗体**
*斜体*
`代码`

> 引用文本

- 列表项
- 列表项
  - 嵌套项

1. 有序列表
2. 有序列表

[链接文本](https://example.com)
![图片](url)

\`\`\`javascript
// 代码块
console.log('Hello');
\`\`\`
```

## 🎨 主题切换

```bash
# 下载主题
git clone https://github.com/theme-owner/hexo-theme-name.git themes/theme-name

# 在 _config.yml 中修改
theme: theme-name

# 重启查看效果
npm run server
```

## 📊 SEO 优化建议

- ✅ 每篇文章设置有意义的 `title` 和 `description`
- ✅ 使用相关的 `tags` 和 `categories`
- ✅ 文章包含适当的内部/外部链接
- ✅ 使用 alt 文字描述图片

---

**需要帮助？**
- 📖 查看 `WORKFLOW.md` 详细指南
- ⚙️ 查看 `SETUP_GUIDE.md` 配置说明
