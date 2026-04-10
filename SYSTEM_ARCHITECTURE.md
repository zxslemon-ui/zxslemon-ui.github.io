# 🏗️ Hexo 博客系统架构全景

> 从系统架构、网络流程、文件生命周期、多个维度深度解析整个系统

---

## 📐 系统架构总览

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃              📱 最终用户 (全球访客)                    ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                           ⬆ HTTPS ⬇
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   🌐 GitHub Pages (CDN + Static Hosting)               ┃
┃                                                       ┃
┃  URL: https://username.github.io                     ┃
┃  数据源: gh-pages 分支                                ┃
┃  协议: HTTP/2, SSL/TLS                               ┃
┃  缓存: 全球 12 个机房 CDN                            ┃
┃  连接: 自动重定向 HTTP → HTTPS                       ┃
┃                                                       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                    ⬆ automated deploy ⬇
              (peaceiris/actions-gh-pages)
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   🤖 GitHub Actions (虚拟环境)                         ┃
┃                                                       ┃
┃  运行环境: Google Cloud Ubuntu VM                    ┃
┃  触发条件: git push to main/master                   ┃
┃  执行步骤:                                           ┃
┃  1. Checkout repo                                    ┃
┃  2. Setup Node.js 18                                 ┃
┃  3. npm install                                      ┃
┃  4. npm run build (hexo generate)                    ┃
┃  5. Deploy to gh-pages                              ┃
┃                                                       ┃
┃  超时设置: 默认 360 分钟                              ┃
┃  并发数: 1 (按顺序执行)                              ┃
┃                                                       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                    ⬆ git push ⬇
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   💾 GitHub Repository (远程)                         ┃
┃                                                       ┃
┃  main/master 分支                                    ┃
┃  ├─ source/          (原始 Markdown 文件)            ┃
┃  ├─ themes/          (主题文件)                      ┃
┃  ├─ _config.yml      (全局配置)                      ┃
┃  ├─ package.json     (依赖管理)                      ┃
┃  └─ .github/workflows/deploy.yml (CI/CD)           ┃
┃                                                       ┃
┃  gh-pages 分支 (自动管理)                             ┃
┃  └─ public/          (生成的静态 HTML)               ┃
┃                                                       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                    ⬆ git clone/push ⬇
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   💻 本地开发环境 (你的 Mac)                           ┃
┃                                                       ┃
┃  工作目录: /Users/forforever/Documents/code/ai-code/ ┃
┃  │                                                   ┃
┃  ├─ source/_posts/      (你写的 Markdown 文章)       ┃
┃  ├─ themes/landscape/   (主题文件)                  ┃
┃  ├─ _config.yml         (配置)                       ┃
┃  ├─ package.json        (npm 依赖)                  ┃
┃  ├─ node_modules/       (已安装的包)                ┃
┃  │  ├─ hexo/            (核心框架)                  ┃
┃  │  ├─ hexo-server/     (开发服务器)                ┃
┃  │  ├─ hexo-renderer-marked/ (Markdown 解析)       ┃
┃  │  └─ ... (20+ 其他包)                            ┃
┃  │                                                   ┃
┃  ├─ public/ (生成的静态文件)                          ┃
┃  │  ├─ index.html       (首页)                      ┃
┃  │  ├─ 2026/04/09/article/index.html (文章)         ┃
┃  │  ├─ archives/        (归档页)                    ┃
┃  │  ├─ css/             (样式文件)                   ┃
┃  │  ├─ js/              (脚本文件)                   ┃
┃  │  └─ images/          (图片资源)                   ┃
┃  │                                                   ┃
┃  └─ .git/               (Git 版本控制)               ┃
┃                                                       ┃
┃  开发工具:                                           ┃
┃  ├─ VS Code             (编辑器)                     ┃
┃  ├─ npm/Node.js         (构建和包管理)               ┃
┃  ├─ Git                 (版本控制)                   ┃
┃  └─ Terminal/zsh        (命令行)                     ┃
┃                                                       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

---

## 🔗 网络请求流程

### 用户访问网站的完整流程

```
用户在浏览器输入 URL: https://username.github.io/2026/04/09/article/
│
├─ 第1步：DNS 解析 (10-100ms)
│  DNS 查询: github.io 域名
│  │
│  └─ DNS 服务器返回 IP 地址
│     例如: 185.199.108.153
│
├─ 第2步：建立 TCP 连接 (50-200ms)
│  你的浏览器 ←→ GitHub Pages CDN 节点
│  │
│  ├─ TCP 三次握手建立连接
│  ├─ 选择距离最近的 CDN 节点
│  │  (全球 12+ 个数据中心)
│  │
│  └─ 连接建立
│
├─ 第3步：TLS/SSL 握手 (100-300ms)
│  加密协议协商: TLS 1.3
│  │
│  ├─ 交换密钥
│  ├─ 验证 SSL 证书
│  │  (GitHub 颁发的证书，由 DigiCert 签署)
│  │
│  └─ 建立加密通道
│
├─ 第4步：发送 HTTP 请求 (0ms)
│  GET /2026/04/09/article/index.html HTTP/2
│  │
│  ├─ Host: username.github.io
│  ├─ User-Agent: Mozilla/5.0...
│  ├─ Accept: text/html, application/xhtml+xml...
│  ├─ Accept-Encoding: gzip, deflate, br
│  ├─ Cookie: (用户数据)
│  ├─ If-Modified-Since: (缓存检查)
│  │
│  └─ 请求发送
│
├─ 第5步：服务器处理 (10-50ms)
│  CDN 节点处理:
│  │
│  ├─ 检查本地缓存
│  │  ✅ 如果有：直接返回 (Cache Hit)
│  │  ❌ 如果没有：从 GitHub Pages 源服务器拉取
│  │
│  ├─ 执行权限检查
│  │  (验证 public/ 目录权限)
│  │
│  ├─ 设置 Response Headers
│  │  ├─ Content-Type: text/html; charset=utf-8
│  │  ├─ Content-Length: 45620
│  │  ├─ Cache-Control: public, max-age=3600
│  │  ├─ ETag: "5f8d6f1e"
│  │  ├─ Expires: Wed, 09 Apr 2026 15:30:00 GMT
│  │  ├─ Server: GitHub.com
│  │  ├─ X-Content-Type-Options: nosniff
│  │  ├─ X-Frame-Options: SAMEORIGIN
│  │  └─ Strict-Transport-Security: max-age=31536000
│  │
│  └─ 准备响应体
│
├─ 第6步：传输数据 (100-500ms 取决于文件大小)
│  HTTP/2 多路复用技术
│  │
│  ├─ 文件压缩 (Gzip/Brotli)
│  │  原始: 150KB → 压缩后: 30KB
│  │
│  ├─ 分片传输
│  │  TCP 窗口分片逐块发送
│  │
│  └─ 并行加载相关资源
│     (CSS, JS, 图片同步加载)
│
├─ 第7步：浏览器接收 (0ms 逐字节到达)
│  收到 HTTP 响应头 → 开始准备渲染
│  收到 HTML body → 开始解析 DOM
│  收到 CSS 文件 → 计算样式树
│  收到 JS 文件 → 准备执行脚本
│
├─ 第8步：浏览器处理 (1-3s)
│  1. HTML 解析
│     字符 → Tokens → DOM 树
│     (约 50-100ms)
│
│  2. CSS 处理
│     CSSOM 树构建
│     样式计算和优化
│     (约 20-50ms)
│
│  3. JavaScript 执行
│     ├─ 脚本加载
│     ├─ 代码解析
│     ├─ JIT 编译
│     ├─ 事件监听器注册
│     └─ (约 50-200ms)
│
│  4. 渲染流程
│     ├─ Layout (布局计算)     100-500ms
│     ├─ Paint (样式绘制)       50-200ms
│     └─ Composite (合成)       20-100ms
│
│  5. 首屏时间线
│     ├─ FCP (First Contentful Paint): 0.8s
│     ├─ LCP (Largest Contentful Paint): 1.2s
│     ├─ FID (First Input Delay): 50ms
│     └─ CLS (Cumulative Layout Shift): 0.05
│
└─ 第9步：用户看到网页 ✅
   完整呈现，可交互
   
   总时间: 1-3 秒 (取决于网络速度)
   
   分解:
   ├─ DNS + TCP + TLS握手: 250ms
   ├─ 请求往返 + 服务器: 50-100ms
   ├─ 数据传输: 300-1000ms (压缩后高速，取决于文件大小)
   ├─ 浏览器处理: 500-1500ms
   └─ 总计: 1100-3150ms
```

---

## 📁 文件生命周期

### 从用户编写到线上的完整旅程

```
时间轴: T0 ──→ T1 ──→ T2 ──→ T3 ──→ T4 ──→ T5 ──→ T6 ──→ T7

┌──────────────────────────────────────────────────────────────┐
│ T0: 用户在本地编写文章                                       │
│                                                              │
│  用户操作:
│  $ bash publish.sh "我的新文章"
│    或
│  $ vim source/_posts/article.md
│
│  文件状态:
│  source/_posts/article.md
│  ├─ 状态: 新创建的 Markdown 文件
│  ├─ 位置: 本地硬盘
│  ├─ 内容: YAML Front Matter + Markdown
│  ├─ 权限: 644 (-rw-r--r--)
│  └─ Git: Untracked (未追踪)
│
│  用户尚未提交到 Git
│
└──────────────────────────────────────────────────────────────┘
                           ⬇ (用户操作)

┌──────────────────────────────────────────────────────────────┐
│ T1: 用户本地构建测试                                         │
│                                                              │
│  用户操作:
│  $ npm run server
│
│  文件变化:
│
│  Hexo 检测 source/ 目录变化
│  │
│  ├─ 读取 source/_posts/article.md
│  │  文件内容:
│  │  ---
│  │  title: 我的新文章
│  │  date: 2026-04-09
│  │  tags: [标签1, 标签2]
│  │  ---
│  │  # 文章内容
│  │  这是 Markdown 内容...
│  │
│  ├─ 触发 Markdown → HTML 转换
│  │  marked 库处理
│  │  # 文章内容 → <h1>文章内容</h1>
│  │
│  ├─ 写入 public/ 目录
│  │  public/2026/04/09/article/index.html 创建
│  │
│  ├─ 生成元数据页面
│  │  ├─ public/index.html 更新 (首页)
│  │  ├─ public/archives/index.html 更新
│  │  └─ public/tags/标签1/index.html 创建
│  │
│  └─ 启动 dev 服务器
│     监听 localhost:4000
│     监听文件变化 (watch mode)
│
│  文件状态:
│  public/ 目录生成！
│  public/
│  ├─ index.html (首页，包含新文章预览)
│  ├─ 2026/04/09/article/index.html (新文章详情页)
│  ├─ archives/index.html (更新的归档)
│  ├─ tags/标签1/index.html (标签页)
│  ├─ css/main.css (样式文件)
│  └─ js/main.js (交互脚本)
│
│  用户在本地浏览:
│  打开浏览器访问 http://localhost:4000
│  看到新文章已发布！
│
│  Git 状态:
│  - source/_posts/article.md (Untracked/Modified)
│  - public/* (应被 .gitignore 忽略)
│
└──────────────────────────────────────────────────────────────┘
                           ⬇ (用户操作)

┌──────────────────────────────────────────────────────────────┐
│ T2: 用户关闭本地服务，准备提交                               │
│                                                              │
│  用户操作:
│  $ npm run build  (不启动服务器，只生成)
│
│  或者

│  $ git status
│  On branch main
│  Untracked files:
│    source/_posts/article.md
│
│  文件状态:
│  source/_posts/article.md 在工作区
│  public/ 已生成 (仅本地)
│  .git/ 目录中:
│    ├─ HEAD: 指向 main
│    ├─ refs/heads/main: 最后提交的 SHA-1
│    ├─ objects/ (所有历史提交对象)
│    └─ index (暂存区)
│
└──────────────────────────────────────────────────────────────┘
                           ⬇ (用户操作)

┌──────────────────────────────────────────────────────────────┐
│ T3: 用户提交到本地 Git 仓库                                  │
│                                                              │
│  用户操作:
│  $ git add source/_posts/article.md
│  $ git commit -m "添加新文章"
│
│  文件变化:
│
│  Git 暂存区 (Index)
│  ├─ 添加 source/_posts/article.md 到暂存区
│  └─ 文件 Hash: 计算 SHA-1 哈希值
│
│  Git 本地仓库 (.git/)
│  ├─ 创建 tree object (目录树)
│  │  {
│  │    "source/": {
│  │      "_posts/": {
│  │        "article.md": "blob-hash-xyz"
│  │      }
│  │    }
│  │  }
│  │
│  ├─ 创建 commit object
│  │  {
│  │    "tree": "tree-hash-123",
│  │    "parent": "commit-hash-old",
│  │    "author": "Your Name <you@example.com>",
│  │    "committer": "Your Name <you@example.com>",
│  │    "date": "Wed Apr 9 10:30:00 2026 +0800",
│  │    "message": "添加新文章"
│  │  }
│  │
│  └─ 更新 refs/heads/main 指针
│     指向新 commit SHA-1
│
│  文件状态:
│  source/_posts/article.md
│  ├─ 位置: 本地磁盘 + Git 对象库
│  ├─ Git 状态: Committed (已提交到本地)
│  ├─ Git 跟踪: Tracked (受版本控制)
│  └─ 远程状态: 未同步 (ahead of origin/main)
│
│  Git 显示:
│  On branch main
│  Your branch is ahead of 'origin/main' by 1 commit.
│
└──────────────────────────────────────────────────────────────┘
                           ⬇ (用户操作)

┌──────────────────────────────────────────────────────────────┐
│ T4: 用户推送到 GitHub 远程仓库                               │
│                                                              │
│  用户操作:
│  $ git push origin main
│
│  网络传输:
│  本地 .git/ ←→ GitHub 服务器
│  │
│  ├─ SSH/HTTPS 连接建立
│  ├─ 认证 (SSH key 或 token)
│  ├─ 增量发送 (只发送新的 objects)
│  │  source/_posts/article.md (Blob object)
│  │  tree object
│  │  commit object
│  │  (总大小: 2-10 KB)
│  ├─ 更新远程 refs/heads/main 指针
│  └─ 完成推送
│
│  GitHub 存储:
│  main 分支 (远程)
│  ├─ source/_posts/article.md 已保存
│  ├─ package.json, _config.yml 等也已保存
│  ├─ .github/workflows/deploy.yml 也已保存
│  └─ 所有文件均可访问
│
│  🔔 Webhook 触发！
│  GitHub 检测到 main 分支有新推送
│  │
│  └─ 自动触发 GitHub Actions 工作流
│     .github/workflows/deploy.yml
│
│  文件状态:
│  source/_posts/article.md
│  ├─ 位置: 本地 + GitHub 远程服务器
│  ├─ Git 状态: Pushed (已推送到远程)
│  ├─ GitHub 分支: origin/main (最新)
│  └─ Actions 触发: 是 ✅
│
│  Git 显示:
│  On branch main
│  Your branch is up to date with 'origin/main'.
│
└──────────────────────────────────────────────────────────────┘
                           ⬇ (自动触发)

┌──────────────────────────────────────────────────────────────┐
│ T5: GitHub Actions 自动构建 (虚拟环境)                       │
│                                                              │
│  Actions 工作流启动 (约 60-120 秒)
│
│  Step 1: Checkout (5-10s)
│  虚拟 Ubuntu VM 获得仓库内容
│  /home/runner/work/blog/blog/
│  ├─ source/_posts/article.md (已包含！)
│  ├─ _config.yml
│  ├─ package.json
│  └─ ... 所有文件
│
│  Step 2: Setup Node.js (5-10s)
│  安装 Node.js v18
│  npm cache 检查 (命中 → 快速)
│
│  Step 3: npm install (10-30s)
│  下载依赖包:
│  ├─ hexo v8.1.1
│  ├─ hexo-renderer-marked
│  ├─ hexo-theme-landscape
│  └─ ... (全部 7 个包)
│
│  如果使用缓存 (第 2+ 次运行):
│  ✨ "cache restored"
│  ✨ 10-15 秒完成
│
│  Step 4: Build (npm run build = hexo generate)
│  虚拟环境执行构建:
│
│  Hexo 处理开始
│  │
│  ├─ 读取 _config.yml
│  │  ├─ site.title = "我的博客"
│  │  ├─ permalink = ":year/:month/:day/:title/"
│  │  └─ ... 全局配置
│  │
│  ├─ 扫描 source/_posts/
│  │  找到 5 篇文章:
│  │  ├─ article.md (新文章！)
│  │  ├─ post1.md
│  │  ├─ post2.md
│  │  └─ ...
│  │
│  ├─ 处理每篇文章
│  │  对于 article.md:
│  │  ├─ 解析 YAML Front Matter
│  │  ├─ 转换 Markdown → HTML
│  │  ├─ 计算 URL: /2026/04/09/article/
│  │  ├─ 创建目录: public/2026/04/09/article/
│  │  └─ 创建文件: public/2026/04/09/article/index.html
│  │
│  │  对于 post1.md:
│  │  ├─ 同样处理...
│  │
│  ├─ 聚合生成特殊页面
│  │  ├─ public/index.html (首页，新文章 + 最新 5 篇)
│  │  ├─ public/archives/index.html (文章时间轴)
│  │  ├─ public/tags/标签1/index.html (标签页)
│  │  └─ public/atom.xml (RSS 订阅)
│  │
│  ├─ 复制静态资源
│  │  ├─ 主题 CSS: public/css/main.css
│  │  ├─ 主题 JS: public/js/main.js
│  │  └─ 图片/字体: public/images/, public/fonts/
│  │
│  └─ 完成！
│     public/ 目录就绪，共 50-150 个文件
│
│  虚拟环境文件状态:
│  public/
│  ├─ index.html (新建)
│  ├─ 2026/04/09/article/index.html (新建！你的文章)
│  ├─ 2026/04/08/post1/index.html
│  ├─ archives/index.html (更新)
│  ├─ tags/标签1/index.html (新建)
│  ├─ css/main.css (复制)
│  ├─ js/main.js (复制)
│  └─ atom.xml (生成)
│
│  时间消耗: ~15-30 秒 (取决于文件数量)
│
└──────────────────────────────────────────────────────────────┘
                           ⬇ (自动执行)

┌──────────────────────────────────────────────────────────────┐
│ T6: GitHub Actions 自动部署                                 │
│                                                              │
│  Step 5: Deploy (peaceiris/actions-gh-pages)
│
│  部署脚本执行:
│  │
│  ├─ 认证
│  │  使用 ${{ secrets.GITHUB_TOKEN }} (GitHub 自动提供)
│  │
│  ├─ 读取 public/ 目录
│  │  所有文件都在虚拟环境的 public/ 中
│  │  共 50-150 个 HTML, CSS, JS, 图片
│  │
│  ├─ 创建部署 commit
│  │  全新的 git commit
│  │  包含 public/ 目录的全部内容
│  │
│  ├─ 推送到 gh-pages 分支
│  │  虚拟环境 → GitHub gh-pages 分支
│  │  强制推送 (覆盖旧版本)
│  │
│  └─ 完成！
│     部署完毕
│
│  GitHub 环节:
│  main 分支 (源代码) - 未改变
│  gh-pages 分支 (生成的网站) - 已更新！
│
│  文件最终状态:
│  gh-pages 分支 包含:
│  public/
│  ├─ 2026/04/09/article/index.html (你的新文章！)
│  ├─ index.html
│  ├─ archives/index.html
│  ├─ css/main.css
│  └─ 所有其他静态文件
│
│  时间消耗: 5-10 秒
│  Actions 总时间: 60-120 秒
│
│  ✅ Actions 绿色显示 (成功)
│
└──────────────────────────────────────────────────────────────┘
                           ⬇ (自动处理)

┌──────────────────────────────────────────────────────────────┐
│ T7: GitHub Pages 上线                                        │
│                                                              │
│  GitHub 检测 gh-pages 分支更新
│  │
│  ├─ 检测: gh-pages 分支有新 commits
│  │
│  ├─ 构建 (30-60 秒)
│  │  ├─ 验证 Jekyll 配置 (GitHub Pages 使用)
│  │  ├─ 准备文件
│  │  ├─ 构建网站
│  │  └─ 部署到 CDN
│  │
│  ├─ 分发到全球 CDN
│  │  ├─ 美国 (多个节点)
│  │  ├─ 欧洲 (多个节点)
│  │  ├─ 亚洲 (多个节点)
│  │  └─ 其他地区
│  │
│  └─ 网站生效！
│     https://username.github.io
│
│  网站最终状态:
│  
│  GitHub Pages CDN 缓存:
│  public/
│  ├─ 2026/04/09/article/index.html ✅ 线上！
│  ├─ index.html
│  ├─ css/main.css
│  └─ ...
│
│  时间消耗: 30-60 秒
│
│  📊 总计从 push 到上线: 2-3 分钟
│
│  用户看到的:
│  浏览器访问 https://username.github.io/2026/04/09/article/
│  │
│  ├─ DNS 解析 GitHub.io
│  ├─ 连接到 CDN 节点
│  ├─ 下载 index.html
│  ├─ 下载 CSS/JS
│  ├─ 浏览器渲染
│  │
│  └─ ✅ 你的新文章显示了！
│     全世界都能看到
│
│  文件状态:
│  source/_posts/article.md
│  ├─ 位置: 本地 + GitHub (main) + GitHub Pages CDN
│  ├─ HTML 版本: /2026/04/09/article/index.html 在 GitHub Pages
│  ├─ 网络: 全球可访问
│  ├─ 缓存: CDN 64 小时缓存
│  └─ URL: https://username.github.io/2026/04/09/article/
│
└──────────────────────────────────────────────────────────────┘
```

---

## 🎯 系统交互矩阵

```
                    ┌─────────────────────────────────────────┐
                    │     什么工具在什么时候做什么？            │
                    └─────────────────────────────────────────┘

阶段            本地操作          什么工具         输出          何时发生
──────────────────────────────────────────────────────────────────
写作            编辑 .md 文件      VS Code         source/      随时
                                                                
测试            npm run server     Hexo + Node     public/      用户主动
                                                                
构建            npm run build      Hexo 生成器      public/      用户主动
                                                   (50+ 文件)   或 CI/CD
                                                                
版本控制        git add/commit     Git             .git/        用户主动
                                                                
提交到云        git push           Git + GitHub    远程 main    用户主动
                                                   分支         
                                                                
自动构建        (无需操作)         GitHub Actions  私有虚拟      git push
                                   + npm           环境         之后自动
                                   + hexo                       
                                                                
自动部署        (无需操作)         GitHub Actions  gh-pages     Actions
                + peaceiris        分支           成功之后
                                                                
上线            (无需操作)         GitHub Pages    全球 CDN     30-60 秒
                                   + CDN           网络         
                                                                
用户访问        浏览器输入 URL     浏览器 + CDN    网页呈现      随时


每个 Markdown 文件的生命周期:

source/_posts/xxx.md
  ├─ [本地] VS Code 编辑
  ├─ [本地] hexo new / hexo generate
  ├─ [本地] git add / git commit
  ├─ [网络] git push to GitHub
  ├─ [自动] GitHub Actions 构建
  ├─ [自动] Hexo 转为 HTML
  ├─ [自动] 部署到 gh-pages
  ├─ [自动] GitHub Pages 上线
  └─ [全球] CDN 分发 → 用户浏览器
```

---

## 💡 性能优化分析

```
哪些环节可以优化？为什么？

┌─ 本地构建 ──────────────────────────────────┐
│ 瓶颈: Markdown 解析和 HTML 生成             │
│ 原因: 文件数量增加时线性增长                │
│ 优化: 增量构建 (仅构建修改的文件)           │
│ Hexo 版本: 8.0+ 自带增量模式                │
│ 效果: 50+ 文件时快 10-50 倍               │
└──────────────────────────────────────────────┘

┌─ GitHub Actions ────────────────────────────┐
│ 瓶颈: npm install (首次 30s, 无缓存时)     │
│ 原因: 需要从 npm registry 下载所有包        │
│ 优化: 启用 npm 缓存 (已在 deploy.yml)     │
│ 效果: 第 2+ 次运行快 50-70%                 │
├────────────────────────────────────────────┤
│ 瓶颈2: hexo generate (生成 HTML)            │
│ 原因: 磁盘 I/O 和 CPU 处理                  │
│ 优化: 已有并发和增量支持                    │
│ 效果: 已达最优                              │
└──────────────────────────────────────────────┘

┌─ CDN 分发 ──────────────────────────────────┐
│ 瓶颈: 地理距离造成的延迟                    │
│ 原因: 光速限制                              │
│ 优化: GitHub Pages 使用全球 CDN              │
│ 效果: 任何地区 <300ms 首字节延迟            │
└──────────────────────────────────────────────┘

┌─ 浏览器渲染 ────────────────────────────────┐
│ 瓶颈: DOM 解析, CSS 计算, JavaScript 执行   │
│ 原因: 串行处理                              │
│ 优化: 使用 HTTP/2, CSS-in-JS, 代码分割     │
│ 构成: Landscape 主题已优化                  │
└──────────────────────────────────────────────┘

┌─ 首次加载 vs 再次访问 ──────────────────────┐
│ 首次: 1-3 秒 (全部下载)                    │
│ 再次: 0.2-0.5 秒 (本地缓存)                │
│ Cache-Control: public, max-age=3600         │
│ ETag: 文件版本检查                          │
└──────────────────────────────────────────────┘
```

---

这个系统的设计完全优化了个人博客的使用体验和性能表现！

