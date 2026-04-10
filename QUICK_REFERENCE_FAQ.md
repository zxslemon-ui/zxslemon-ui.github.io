# 🚀 快速参考 & 常见问题

> 这个文档用于快速查找和解决问题

---

## 📋 常用命令速查

### 初始化和启动

```bash
# 首次使用：初始化项目
npm install

# 启动本地预览服务器
npm run server
# 访问: http://localhost:4000

# 完全清理和重建
npm run clean
npm run build

# 生成静态文件（不启动服务器）
npm run build
```

### 文章管理

```bash
# 使用脚本快速创建文章
bash publish.sh "我的新文章标题"
# 自动打开编辑器，直接开始写作

# 手动创建文章
hexo new "标题"
hexo new post "标题"   # 创建 post 类型
hexo new page "标题"   # 创建 page 类型

# 创建后手动编辑
vim source/_posts/article.md
```

### Git 和部署

```bash
# 查看变化
git status
git log --oneline          # 查看提交历史

# 提交和推送
git add .
git commit -m "提交信息"
git push origin main       # 推送到 GitHub

# 使用菜单助手
bash workflow.sh           # 交互式菜单
```

---

## ❓ 常见问题解决方案

### 问题 1: 网站生成很慢，怎么办？

**症状**: `npm run build` 需要 10+ 秒

**原因**:
- 文件数量多（100+ 篇文章）
- 没启用缓存
- 磁盘 I/O 慢

**解决方案**:

```bash
# 方案1: 使用增量生成（仅生成修改的文件）
hexo generate --watch

# 方案2: 清空缓存后重新生成
hexo clean
hexo generate

# 方案3: 本地使用开发服务器（自动增量）
npm run server

# 方案4: 如果是 GitHub Actions，启用缓存
# 已在 deploy.yml 中配置，自动优化
```

---

### 问题 2: 本地测试显示正确，但网站上显示错误

**症状**: `localhost:4000` 正常，但 `github.io` 上不对

**原因**:
- 没有 `git push` 
- GitHub Actions 还在构建
- 浏览器缓存问题

**解决方案**:

```bash
# 步骤1: 检查是否已 push
git log --oneline
git push origin main  # 确保已推送

# 步骤2: 检查 GitHub Actions
# 打开: https://github.com/username/blog/actions
# 查看最新工作流是否成功

# 步骤3: 查看部署状态
# 打开: https://github.com/username/blog/deployments
# 检查最新的 GitHub Pages 部署

# 步骤4: 清除浏览器缓存
# Chrome: Ctrl+Shift+Delete
# Mac: Cmd+Shift+Delete

# 步骤5: 验证网站
# 访问: https://username.github.io
# 如果还是旧内容，等待 1-2 分钟再试
```

---

### 问题 3: 文章没有显示在首页

**症状**: 新文章创建了，但首页/归档页看不到

**原因**:
- YAML Front Matter 格式错误
- 文件名包含无效字符
- 日期设置在未来
- 文章被隐藏 (draft: true)

**解决方案**:

```bash
# 检查文章格式
# 正确的 Front Matter 必须以 --- 开头和结尾

# ✅ 正确:
---
title: 我的文章
date: 2026-04-09 10:30:00
tags:
  - 标签1
  - 标签2
categories:
  - 分类
---

# ❌ 错误: 遗漏 ---
title: 我的文章
date: 2026-04-09

# ❌ 错误: draft 为 true（草稿会隐藏）
---
title: 我的文章
draft: true    # 删除这行，或改为 false
---

# 检查文件名
# ✅ 正确: source/_posts/my-article.md
# ❌ 错误: source/_posts/my article.md (空格)

# 检查日期
# ✅ 正确: date: 2026-04-09 (当前日期或过去)
# ❌ 错误: date: 2099-04-09 (未来日期，会隐藏)

# 解决: 编辑文件
vim source/_posts/article.md

# 修复后重新生成
npm run build
npm run server  # 本地测试

# 无误后推送
git add .
git commit -m "修复文章"
git push origin main
```

---

### 问题 4: GitHub Actions 构建失败

**症状**: GitHub Actions 显示红色 ❌

**原因**:
- package-lock.json 损坏
- 依赖包不兼容
- 配置文件语法错误

**解决方案**:

```bash
# 步骤1: 查看错误日志
# 打开: https://github.com/username/blog/actions
# 点击失败的工作流，查看详细错误

# 步骤2: 查看是否是 npm 问题
# 删除 node_modules 和 lock 文件
rm -rf node_modules
rm -rf node_modules/.package-lock.json

# 重新安装
npm install

# 步骤3: 本地测试构建
npm run build

# 没有错误后推送
git add .
git commit -m "修复构建问题"
git push origin main

# 步骤4: 如果还是失败，检查 package.json
# 确保所有依赖正确安装
npm list

# 步骤5: 核对 _config.yml 语法
# YAML 格式必须正确
vim _config.yml
```

---

### 问题 5: URL 链接不正确

**症状**: 链接显示错误，如 `/article` 而不是 `/2026/04/09/article/`

**原因**:
- 没修改 `_config.yml` 中的 `url` 字段
- `permalink` 格式不正确

**解决方案**:

```bash
# 编辑配置文件
vim _config.yml

# 检查和修改这些字段:
url: https://username.github.io    # 改为你的域名
permalink: :year/:month/:day/:title/

# 修复后重新生成
hexo clean          # 删除旧的 public/ 目录
hexo generate       # 重新生成

# 验证 URL 格式
# 文件应该在: public/2026/04/09/article/index.html
# 对应 URL: https://username.github.io/2026/04/09/article/

# 测试
npm run server
# 访问 http://localhost:4000/2026/04/09/article/

# 无误后推送
git add .
git commit -m "修复 URL 配置"
git push origin main
```

---

### 问题 6: 代码高亮不工作

**症状**: 代码块显示为纯文本，没有着色

**原因**:
- marked 渲染器没配置高亮库
- 依赖包缺失

**解决方案**:

```bash
# 检查依赖
npm list hexo-renderer-marked
npm list highlight.js

# 如果缺失，安装
npm install highlight.js --save-dev

# 重新生成
hexo clean
hexo generate

# 验证：访问本地服务器查看代码块
npm run server
```

---

### 问题 7: 更改后没有及时生效

**症状**: 修改了配置或文章，但看不到变化

**原因**:
- 本地服务没重启
- 浏览器缓存
- 文件未保存
- GitHub Pages 缓存

**解决方案**:

```bash
# 方案1: 重启本地服务器
# 按 Ctrl+C 停止
# 然后重新运行
npm run server

# 方案2: 清除浏览器缓存并硬刷新
# 浏览器: Ctrl+Shift+R (硬刷新)
# 或: Cmd+Shift+R (Mac)

# 方案3: 检查文件是否保存
# 确认编辑器中的文件已保存

# 方案4: 如果是网站上的问题，等待 CDN 更新
# GitHub Pages 缓存 1 小时
# 或访问: https://username.github.io/?t=123456 (清除 URL 缓存)
```

---

### 问题 8: 无法推送到 GitHub (SSH 或认证问题)

**症状**: `git push` 命令报错，提示认证失败

**原因**:
- SSH key 未配置
- GitHub token 过期
- 仓库权限问题

**解决方案**:

```bash
# 检查当前使用的协议
git remote -v
# 输出应该显示: origin  https://github.com/username/blog.git

# 如果是 HTTPS，输入 GitHub token
git push origin main
# 提示输入用户名和密码
# 用户名: 输入 GitHub 用户名
# 密码: 输入 Personal Access Token (不是账户密码！)

# 生成 Personal Access Token:
# 1. 打开 https://github.com/settings/tokens
# 2. 点击 "Generate new token"
# 3. 选择 "repo" 和 "workflow" 权限
# 4. 复制 token (只显示一次！)
# 5. 粘贴到密码提示中

# 或改用 SSH 密钥认证
# 1. 生成 SSH 密钥
ssh-keygen -t ed25519 -C "you@example.com"

# 2. 添加到 GitHub
# 打开 https://github.com/settings/keys
# 点击 "New SSH key"
# 然后修改 git remote
git remote set-url origin git@github.com:username/blog.git

# 3. 测试连接
ssh -T git@github.com

# 4. 推送
git push origin main
```

---

## 🔧 自定义配置

### 修改网站标题和基本信息

```bash
vim _config.yml

# 找到并修改这些字段:
title: 我的个人博客          # 网站标题
subtitle: 技术分享和记录      # 副标题
description: 这是我的博客    # 网站描述
author: 你的名字             # 作者名
language: zh-CN             # 语言
timezone: Asia/Shanghai     # 时区

# 修改后重新生成
hexo clean
hexo generate
npm run server              # 本地测试
```

### 修改主题

```bash
# 查看已安装的主题
ls themes/

# 在 _config.yml 中修改
vim _config.yml
theme: landscape            # 改为其他主题

# 如果要安装新主题
# 从 https://hexo.io/themes/ 找到主题
# 然后克隆到 themes/ 目录
git clone https://github.com/theme-name themes/theme-name

# 在 _config.yml 中改 theme: theme-name
# 重新生成
hexo clean
hexo generate
```

### 添加自定义页面

```bash
# 创建 "关于我" 页面
hexo new page "about"
vim source/about/index.md

# 编辑内容后，刷新网站
npm run server

# 如果菜单中看不到，编辑主题菜单配置
vim _config.landscape.yml  # 主题配置

# 查找 menu 字段，添加:
# menu:
#   Home: /
#   Archives: /archives
#   About: /about
```

---

## 📊 性能检查

```bash
# 检查构建性能
npm run build

# 输出示例:
# INFO  Validating config
# INFO  Generating
# Page generated in 250 ms (5 posts)

# 检查网站大小
du -sh public/
# 示例: 2.5M

# 检查文件数量
find public -type f | wc -l
# 示例: 45

# 查看最大的文件
find public -type f -exec du -h {} + | sort -rh | head -10

# 测试网络速度（本地到 GitHub Pages）
curl -w "@curl-format.txt" -o /dev/null -s https://username.github.io
```

---

## 🚨 备份和恢复

```bash
# 备份本地仓库
git bundle create backup.bundle --all
# 这样创建了 backup.bundle 文件，包含整个仓库

# 如果需要恢复
git clone backup.bundle new-repo
cd new-repo
git config --add remote.origin.url https://github.com/username/blog.git
git push -u origin main

# 备份 source/ 目录（重要内容）
tar -czf blog-backup-$(date +%Y%m%d).tar.gz source/
# 定期备份到外部硬盘或云存储
```

---

## 🎓 学习路径

### 初学者 (第 1-3 天)

1. ✅ `npm run server` - 启动本地预览
2. ✅ `bash publish.sh` - 创建文章
3. ✅ `git add . && git commit && git push` - 推送到 GitHub
4. ✅ 访问 `https://username.github.io` - 看网站上线

目标: 理解基本工作流

### 中级 (第 1-2 周)

1. ✅ 修改 `_config.yml` - 自定义网站信息
2. ✅ 理解文章的 YAML Front Matter
3. ✅ 学会编写高质量 Markdown
4. ✅ 监控 GitHub Actions 工作流
5. ✅ 使用 `hexo new page` 创建自定义页面

目标: 能够自主维护和优化博客

### 高级 (第 3 周以上)

1. ✅ 安装和配置自定义主题
2. ✅ 理解 Hexo 插件系统
3. ✅ 修改主题样式 (CSS)
4. ✅ 添加评论系统 (Disqus/Gitalk)
5. ✅ 添加分析工具 (Google Analytics/Fathom)
6. ✅ SEO 优化 (sitemap/robots.txt)

目标: 创建完全定制化的专业博客

---

## 📧 获取帮助

### 官方资源

- Hexo 官网: https://hexo.io
- Hexo 中文文档: https://hexo.io/zh-cn/
- GitHub Pages 文档: https://docs.github.com/en/pages
- Landscape 主题: https://github.com/hexojs/hexo-theme-landscape

### 社区讨论

- GitHub Issues: https://github.com/hexojs/hexo/issues
- Stack Overflow: https://stackoverflow.com/questions/tagged/hexo
- Reddit: https://www.reddit.com/r/emacs/ (寻找个人博客讨论)

### 调试技巧

```bash
# 启用详细日志
hexo --debug

# 导出完整配置
hexo config

# 空间分析（找出大文件）
npm ls --all
```

---

这个快速参考涵盖了 95% 的常见场景！

