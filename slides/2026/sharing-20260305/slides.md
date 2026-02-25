---
theme: default
background: https://images.unsplash.com/photo-1517694712202-14dd9538aa97
class: text-center
highlighter: shiki
lineNumbers: false
drawings:
  persist: false
transition: slide-left
title: Galleon 介紹 & Cursor Cloud Agent 分享
mdc: true
monaco: true
author: Jonathan Tang
date: 2026.03.05
info: Galleon 新專案介紹與 Cursor Cloud Agent 使用分享。Keywords - Galleon, Nuxt 4, Admin, 內部系統, Cursor Skills, Cursor Cloud Agent, niffler
---

# Sharing 2026.03.05

Jonathan

---
layout: center
---

# Today's sharing

- <Link to="part1-galleon" title="Galleon"/>
- <Link to="part2-cursor-agent" title="Cursor Cloud Agent"/>

---
routeAlias: part1-galleon
layout: center
---

# Galleon

- Omnichat 內部人員使用的後台
  - 預計取代現有產品中，財務團隊使用的頁面
- 財務與 AM / CS 部門為主要使用者
  - 財務團隊使用的頁面搬遷至此
  - slack 部分指令也會搬遷至此
- 以最低限度人力、時間完成需求，不經過 Design、QA 等部門

---
layout: image
image: /galleon-screenshot.png
backgroundSize: 90%
---


---
routeAlias: name-origin
layout: image-right
image: /mon48504-fantastic-beasts-and-where-to-find-them-niffler-coin-bank-titan-pop-culture-38491.webp
backgroundSize: 80%
---

# Galleon？

- ~~Dash Admin 這名稱後端使用了~~
- 財務、AM / CS 用途，和錢有關
- Niffler 手上拿著 Galleon
- Galleon = 金加隆

---
routeAlias: tech-stack
layout: center
---

# 技術選型

- **Nuxt 4** — 核心框架
- **Nuxt UI v4** — UI 元件
- **Pinia** — 狀態管理
- **Nuxt i18n** — 多國語系
- **Google Sign-In** — 身份驗證
- **Zod** — 表單驗證
- **VueUse** — 工具函式
- **Vitest + Playwright** — 單元／元件測試
- **Nuxt/eslint** — 開發規範

---
routeAlias: why-nuxt
layout: center
---

# Why Nuxt ?

- Vue ecosystem — 大家熟悉的 Vue
- Nuxt 4 — 開箱即用的一致架構，降低上手與學習成本
- 選用關鍵：
  - file based routing
  - auto import components, composables, helper functions and Vue APIs

---
routeAlias: structure
layout: center
---

# 專案結構

```text
├── app/                  # 應用程式入口
│   ├── api/              # API
│   ├── assets/           # 靜態資源
│   ├── components/       # 可複用元件
│   ├── composables/      # 邏輯封裝
│   ├── config/           # 共用設定檔
│   ├── layouts/          # 頁面佈局模板
│   ├── middleware/       # 中介層／路由守衛
│   ├── pages/            # 檔案結構式路由
│   ├── schemas/          # 表單驗證用 Zod schema
│   └── stores/           # 全域狀態管理
├── i18n/                 # 語系翻譯檔案
├── public/               # 靜態檔案
├── scripts/              # 指令相關腳本
├── test/                 # 測試案例
└── nuxt.config.ts        # Nuxt 全域設定
```

---
routeAlias: highlights
layout: center
---

# 其他

- <Link to="cursor-skills" title="Cursor Skills 整合"/>
- <Link to="ssr-false" title="Client Side Render"/>

---
routeAlias: cursor-skills
layout: center
---

# Cursor Skills

- 透過 `.cursor/skills/` 目錄下的規範，讓 Cursor AI 遵循專案標準
- 每個 skill 為一目錄，內含 `SKILL.md`（描述、何時載入）與可選的 `reference/` 參考文件
- 已安裝的 skill：
  - 技術相關：`nuxt`、`vue`、`pinia`、`vitest`
  - 實作相關：`vue-best-practices`、`vue-testing-best-practices`
  - 文件相關：`document-writer`
  - 工具相關：`pnpm`
- AI 依任務情境載入對應 skill，等同專案專用的 AI 知識庫

---
routeAlias: ssr-false
layout: center
---

# Client Side Render

- Nuxt 的渲染模式可以分為
  - Server Side Render
  - Client Side Render
  - Hybrid Render
- Galleon 使用 Nuxt 4 的 Client Side Rendering 模式，即 `SSR: false`
- build 使用 nuxt generate 指令，生成靜態檔案，相當於 Vue SPA

---
layout: center
---

# 小結

- **定位**：Omnichat 內部後台，取代財務團隊既有頁面，以最少人力與流程完成需求
- **技術**：Nuxt 4 + Nuxt UI v4，file-based routing、auto import，開發體驗一致
- **其他**：Cursor Skills 整合專案規範、SSR: false 靜態輸出，等同 Vue SPA
- **下一步**：財務功能持續搬遷，Slack 指令整合至 Galleon

---
routeAlias: part2-cursor-agent
layout: center
---

# 二、Cursor Cloud Agent 分享

---
routeAlias: cursor-agent-what
layout: center
---

# 什麼是 Cursor Cloud Agent

- （請補：Cloud Agent 是什麼、與本地 Agent 的差異）

---
routeAlias: cursor-agent-when
layout: center
---

# 使用情境／什麼時候用

- （請補：列點或短段說明）

---
routeAlias: cursor-agent-how
layout: center
---

# 實際使用方式／Demo 或流程

- （請補：流程說明、程式碼或截圖）

---
routeAlias: cursor-agent-tips
layout: center
---

# 心得／最佳實踐／注意事項

- （請補：列點）

---
routeAlias: summary
layout: center
---

# 總結

- **主題一**：Galleon 內部管理系統、技術選型與亮點
- **主題二**：Cursor Cloud Agent 的使用與心得

---
layout: center
---

<div class="flex flex-col items-center justify-center h-full">
  <h1>The end</h1>
  <PoweredBySlidev />
</div>
