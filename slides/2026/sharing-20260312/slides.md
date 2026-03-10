---
theme: default
background: https://images.unsplash.com/photo-1727434032773-af3cd98375ba
class: text-center
highlighter: shiki
lineNumbers: false
drawings:
  persist: false
transition: slide-left
title: Galleon & Cursor Cloud Agent
mdc: true
monaco: true
author: Jonathan Tang
date: 2026.03.12
info: Introduction to Galleon internal admin and Cursor Cloud Agent usage. Keywords - Galleon, Nuxt 4, Cursor Cloud Agent, Slidev Workspace
---

# Sharing 2026.03.12

Jonathan

---
layout: center
---

# 今天的內容

- <Link to="part1-galleon" title="Galleon"/>
- <Link to="part2-cursor-agent" title="Cursor Cloud Agent"/>
- <Link to="part3-slidev-workspace" title="Slidev Workspace"/>

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

- <Link to="cursor-skills" title="Cursor Skills"/>
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
- AI 依任務情境載入對應 skill 使用

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

# Cursor Cloud Agent

---
layout: center
---

# 前情提要 - 1

- 年假前覺得 Flip 7 的官方計分小工具不夠好用

<div class="flex justify-center items-stretch gap-8 mt-6">
  <div class="flex flex-col items-center gap-2">
    <img src="/filp7.webp" alt="自製 Flip7 計分板" class="max-h-72 object-contain" />
  </div>
  <div class="flex flex-col items-center gap-2">
    <img src="/offical-scorebaord.png" alt="官方計分板" class="max-h-72 object-contain" />
  </div>
</div>



---
layout: image-right
image: /fan-made-scorebaord.png
backgroundSize: 30%
---

# 前情提要 - 2

- 用 Cursor vibe 了一個
- 儲存於 GitHub
- 部署到 Netlify

<div class="flex justify-center items-center gap-8 mt-20">
  <img src="/Cursor_Vector_Logo.png" alt="Cursor" class="h-20 w-20 object-contain bg-white rounded-full p-2" />
  <span class="text-xl">→</span>
  <img src="/github_logo_icon_229278.png" alt="GitHub" class="h-20 w-20 object-contain bg-white rounded-full p-2" />
  <span class="text-xl">→</span>
  <img src="/netlify.webp" alt="Netlify" class="h-20 w-20 object-contain bg-white rounded-full p-2" />
</div>

---
layout: center
---

# 前情提要 - 3

- 回老家後沒帶電腦但又想加功能
- 使用 Cursor Cloud Agent 來完成

---
routeAlias: cursor-agent-what
layout: center
---

# Cursor Cloud Agent ?

- 直接使用 Cursor 的雲端虛擬機來進行開發，可以直接在 web 上操作
- 只能開發已存在的 repo，無法用於建立新專案
- 只支援 GitHub、GitLab 的 repo，目前無法使用其他平台 (有預計支援 Bitbucket)
- 強制使用 max mode
- 沒有 auto model，需指定 model
  - Codex 5.3 High
  - GPT-5.2 High
  - Opus 4.6 High
  - Composer 1.5

---
layout: center
---

# 每個 Cursor Cloud Agent 會進行...

  - clone 目標 repo
  - 建立一個 branch 用於開發
  - 每次對話都會生成一次 commit + push
  - 最後建立一個 PR (每個 agent 只能發一個 PR)

---
routeAlias: cursor-agent-when
layout: center
---

# 開發流程 - 1 

<div class="flow-two-rows">
  <div class="flow-row">
    <span class="flow-step">指定 repo</span>
    <span class="flow-arrow">→</span>
    <span class="flow-step">提出開發需求</span>
    <span class="flow-arrow">→</span>
    <span class="flow-step">來回和 agent 討論</span>
    <span class="flow-arrow">→</span>
    <span class="flow-step">Agent 自動建立 PR</span>
  </div>
</div>

<div class="flex justify-center gap-6 mt-6">
  <img src="/cloud_agent/01.png" alt="Cloud Agent 介面" class="w-80 h-80 object-contain rounded-lg" />
  <img src="/cloud_agent/02.png" alt="Cloud Agent 完成結果" class="w-80 h-80 object-contain rounded-lg" />
</div>

<style>
.flow-two-rows { display: flex; flex-direction: column; gap: 1rem; align-items: center; margin-top: 1rem; }
.flow-row { display: flex; flex-wrap: wrap; align-items: center; justify-content: center; gap: 0.5rem; }
.flow-step { background: rgba(255,255,255,0.1); padding: 0.5rem 0.75rem; border-radius: 6px; font-size: 1rem; white-space: nowrap; }
.flow-arrow { color: #888; font-size: 1.25rem; }
</style>

---
layout: center
---

# 開發流程 - 2

<div class="flow-two-rows">
  <div class="flow-row">
    <span class="flow-step">到 GitHub 查看 PR</span>
    <span class="flow-arrow">→</span>
    <span class="flow-step">Netlify build preview 供部署前檢查</span>
    <span class="flow-arrow">→</span>
    <span class="flow-step">合併 PR</span>
    <span class="flow-arrow">→</span>
    <span class="flow-step">Netlify 部署正式版</span>
  </div>
</div>

<div class="flex justify-center gap-6 mt-6">
  <img src="/cloud_agent/03.png" alt="GitHub PR" class="w-56  object-contain rounded-lg" />
  <img src="/cloud_agent/04.png" alt="Netlify preview" class="w-56  object-contain rounded-lg" />
  <img src="/cloud_agent/05.png" alt="Netlify preview" class="w-56  object-contain rounded-lg" />
</div>

<style>
.flow-two-rows { display: flex; flex-direction: column; gap: 1rem; align-items: center; margin-top: 1rem; }
.flow-row { display: flex; flex-wrap: wrap; align-items: center; justify-content: center; gap: 0.5rem; }
.flow-step { background: rgba(255,255,255,0.1); padding: 0.5rem 0.75rem; border-radius: 6px; font-size: 1rem; white-space: nowrap; }
.flow-arrow { color: #888; font-size: 1.25rem; }
</style>

---
routeAlias: cursor-agent-how
layout: center
---

# 花費

<img src="/cloud_agent/cost.png" alt="Cloud Agent 使用紀錄" class="max-h-92 object-contain mx-auto" />

**總計：US$5.78**（18 筆，使用 gpt-5.3-codex-high ）

---
routeAlias: cursor-agent-tips
layout: center
---

# 心得

- 沒電腦或想快速修改時，用 Cloud Agent 處理小型需求頗方便
- 善用 PR preview 做手動測試
- 因為是 max mode，model 和開發規模要慎選
- 一個 agent 只會開一個 PR，如果 merge 了可以手動去 github 開新 PR
- 只支援 GitHub、GitLab，不能開新專案，目前只適合既有 repo 迭代

---
routeAlias: part3-slidev-workspace
layout: center
---

# Slidev Workspace

---
layout: center
---

<img src="/slidev-workspace.png" class="mt-6 max-h-96 object-contain mx-auto" alt="Slidev Workspace README" />

- [leochiu-a/slidev-workspace](https://github.com/leochiu-a/slidev-workspace)

---
layout: center
---

# Workspace 檔案結構

```
omnichat-fe-sharing-workspace/
├── slidev-workspace.yaml
├── package.json
├── pnpm-workspace.yaml
├── slides/
│   ├── 2024/ sharing-20240215, 20240502, ...
│   ├── 2025/ sharing-20250102, 20250327, ...
│   └── 2026/ sharing-20260312/ 
│       ├── slides.md
│       ├── package.json
│       └── public/
└── dist/
```

---
layout: image
image: /workspace-screenshot.png
backgroundSize: contain
---

---
layout: center
---

<div class="flex flex-col items-center justify-center h-full">
  <h1>The end</h1>
  <PoweredBySlidev />
</div>
