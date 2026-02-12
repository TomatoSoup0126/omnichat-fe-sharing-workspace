# Slidev Workspace Starter

This starter helps you manage multiple **Slidev** presentations in a single monorepo. Since each Slidev project is an independent package, using a **pnpm workspace** makes it easy to manage, develop, and deploy them together.

## ✨ Features

- **Built with slidev-workspace**: Powered by [`slidev-workspace`](https://github.com/leochiu-a/slidev-workspace), a package that simplifies the management of slides workflow.
- **Workspace-friendly**: Manage all your Slidev presentations as separate packages within a single workspace.
- **Automated deployment**: Use GitHub Actions to automatically deploy each presentation to GitHub Pages.
- **Easy to scale**: Quickly add new Slidev projects by creating new packages in the workspace.

## 🚀 Quick Start

1. Clone the repository and install dependencies

  ```bash
  git clone https://github.com/leochiu-a/slidev-workspace-starter.git
  cd slidev-workspace-starter
  pnpm install
  ```

2. Change `base` of `slidev-workspace.yaml`. This is the base path for GitHub Pages, typically the same as the repository name.

3. Set up the GitHub Pages build and deploy based on GitHub Actions. `Settings > Pages > Build and deployment > Source > GitHub Actions`

## ➕ Creating a New Slide

Use the `pnpm new` command to quickly create a new presentation:

```bash
# 使用今天日期和預設標題
pnpm new

# 指定日期
pnpm new 20250215

# 指定日期、標題和描述
pnpm new 20250215 "React Hooks Advanced" "Deep dive into React Hooks patterns"
```

腳本會自動：
- 根據年份建立正確的目錄結構（`slides/YYYY/sharing-YYYYMMDD/`）
- 生成標準的 `package.json`
- 創建包含完整 frontmatter 的 `slides.md` 模板
- 建立 `public/` 目錄

建立後執行：
```bash
cd slides/YYYY/sharing-YYYYMMDD
pnpm install
pnpm dev
```

或使用 workspace 指令（推薦）：
```bash
pnpm --filter sharing-YYYYMMDD dev
```

## 🎬 開發單一專案

**推薦做法**：由於同時啟動所有專案可能導致 `too many open files` 錯誤，建議單獨啟動需要的專案：

```bash
# 查看所有專案列表
./quick-start.sh

# 方法 1: 使用 workspace 指令（推薦）
pnpm --filter sharing-20240927 dev

# 方法 2: 直接進入目錄
cd slides/2024/sharing-20240927
pnpm dev
```

專案會在 `http://localhost:3030/` 啟動。

## 📦 Demo

Check out the live demo: https://leochiu-a.github.io/slidev-workspace-starter/

## 📚 Included Presentations

This workspace contains presentations organized by category:

### FE-Sharing Series (10 presentations)
Frontend engineering sharing sessions from 2023-2025, organized by year in `slides/`.

See [slides/sharing-projects.md](./slides/sharing-projects.md) for complete details:
- sharing-20231123 (Nov 2023)
- sharing-20240215 (Feb 2024)
- sharing-20240502 (May 2024)
- sharing-20240711 (Jul 2024)
- sharing-20240927 (Sep 2024)
- sharing-20250102 (Jan 2025)
- sharing-20250327 (Mar 2025)
- sharing-20250626 (Jun 2025)
- sharing-20250911 (Sep 2025)
- sharing-20251127 (Nov 2025)
