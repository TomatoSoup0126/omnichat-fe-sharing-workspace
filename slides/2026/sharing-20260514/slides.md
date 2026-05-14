---
theme: default
background: https://images.unsplash.com/photo-1594768816441-1dd241ffaa67
title: Learn Harness Engineering
author: Jonathan Tang
date: 2026.05.14
info: AI Agent Harness Engineering
class: text-center
highlighter: shiki
drawings:
  persist: false
transition: slide-left
mdc: true
monaco: true
---

# Sharing 2026.03.12

Jonathan

---

# Harness Engineering

<img src="/tech_sharing.png" class="m-auto h-80 mt-16" />

---
layout: image-right

# the image source
image: /441050.jpg
backgroundSize: contain
---

# Harness

/ˈhɑːrnɪs/


- 馬具、輓具、安全索

- Harness Engineering = 駕馭工程

---

# Harness Engineering - Google Trends

<img src="/trends.png" class="m-auto h-80 mt-16" />

---

<div class="flex items-center justify-center gap-16 mt-16">
  <div class="text-center">
    <img src="/harness-engineering-openai.png" class="m-auto h-64 rounded shadow" />
  </div>
  <div class="text-center">
    <img src="/harness-engineering-anthropic.png" class="m-auto h-88 rounded shadow" />
  </div>
</div>

---

<div class="flex items-center justify-center gap-8 h-full text-xl">
  <div class="text-center">
    <div class="text-4xl font-bold text-gray-400">2022</div>
    <div class="mt-2 text-2xl">Prompt Engineering</div>
    <div class="mt-4 text-sm text-gray-400 leading-relaxed">
      如何寫好指令讓模型理解需求<br/>
      「你是一位資深的前端工程師...」<br/>
      解決：單次對話的輸出品質
    </div>
  </div>
  <div class="text-3xl text-gray-400">→</div>
  <div class="text-center">
    <div class="text-4xl font-bold text-gray-400">2025</div>
    <div class="mt-2 text-2xl">Context Engineering</div>
    <div class="mt-4 text-sm text-gray-400 leading-relaxed">
      如何餵正確的資訊給模型理解<br/>
      RAG、Tool Use、Memory、MCP<br/>
      解決：模型拿到正確的上下文
    </div>
  </div>
  <div class="text-3xl text-gray-400">→</div>
  <div class="text-center">
    <div class="text-4xl font-bold text-green-400">2026</div>
    <div class="mt-2 text-2xl font-bold text-green-400">Harness Engineering</div>
    <div class="mt-4 text-sm text-green-300 leading-relaxed">
      如何讓 Agent 可靠地完成任務<br/>
      指令、工具、環境、狀態、驗證<br/>
      解決：點到點的執行可靠性
    </div>
  </div>
</div>

---
layout: center
---

# Harness 想解決的問題

<v-clicks>

- 用很強的模型，但結果為何差強人意？
   <!-- - 模型能力 ≠ 執行可靠性
   - 缺乏驗證、環境、狀態管理 → 結果不可控 -->

- Token 和時間都是有限的，如何有效利用？
   <!-- - Agent 花大量 Token 在探索、猜測、重試
   - 正確的資訊架構能大幅降低浪費 -->

- Agent 說做完了，但一測就炸

</v-clicks>

---
layout: center
---

# 千里馬與馬具

千里馬再強，沒有馬具也很難順利騎乘到目的地 — 模型也是一樣

---
layout: center
---

# 模型能力強 ≠ 執行可靠

---

# Harness 的效益
同一個模型 (Opus 4.5)，執行相同任務 (2D 復古遊戲開發)

| | 無 Harness | 完整 Harness |
|---|---|---|
| 投入 | 20 分鐘 / $9 | 6 小時 / $200 |
| 結果 | 核心功能壞掉 | 完整可玩的遊戲 |

<v-click>

→ 模型不變，改變的是 Harness

</v-click>

---

# 什麼是 Harness？

不是單純的「提示詞 (Prompt)」，而是模型之外的工程基礎設施

<v-clicks>

| 餐廳比喻 | Harness 子系統 | 說明 |
|---|---|---|
| 食譜 | **指令** | AGENTS.md / CLAUDE.md — 規範與架構 |
| 廚具 | **工具** | 工具存取權限 |
| 爐子 | **環境** | 環境描述檔：package.json、tsconfig |
| 備料台 | **狀態** | PROGRESS.md — 追蹤進度 |
| 出餐口 | **驗證** | 驗證指令：vitest、eslint |

</v-clicks>

---
layout: center
---

# 資訊與上下文管理
減少把 Token 用在「猜測」和「探索」上

<v-clicks>

「 讓我先看看這專案的結構 」

「 再讓我深入了解這些檔案 」

</v-clicks>

---

# 上下文焦慮 (Context Anxiety)

當 context window 逼近上限時，Agent 的行為會改變

<v-clicks>

- **過早收斂** — 倉促給出答案，跳過驗證步驟
- **選擇次佳方案** — 偏好「能快速結束」的做法，而非正確做法
- **跳過邊界情況** — 省略測試、忽略 edge case

</v-clicks>

<v-click>

→ Token 浪費在探索上 → context 更快耗盡 → 焦慮更早觸發 → 更早交差

</v-click>

---

# 專案儲存庫是唯一的可靠資訊來源

Agent 看不到 Slack、Jira 或工程師腦袋裡的資訊

<v-clicks>

- 不在儲存庫裡的知識，對 Agent 來說等於不存在
- 所有架構決策與硬性規範 → 必須寫入儲存庫（例如 AGENTS.md）

</v-clicks>

---

# Cold-Start Test

一個全新 Agent session，僅靠 repo 能回答這五個問題嗎？

1. 這個系統是什麼？
2. 它的架構是什麼？
3. 怎麼如何執行？
4. 如何驗證？
5. 目前的開發進度？

<v-click>

→ 答不出來 / 只能靠猜 = 存在知識盲區 = 更高的失敗率

</v-click>

---

# AGENTS.md

讓 Agent 在第一秒就知道該做什麼、怎麼做、不能做什麼

```markdown
# 專案概述
<!-- 一句話說明系統用途 -->

# Startup Workflow
<!-- 開始工作前的標準流程：安裝依賴套件、檢查環境、確認 git branch -->

# Working Rules
<!-- 工作時的規則：如不要改動某些檔案、不要使用某些工具 -->

# Hard Constraints
<!-- 硬性規範：如認證方式、API 模式、表單驗證 -->

# Definition of Done
<!-- 完成任務的標準：如無錯誤、型別檢查通過、測試通過、UI 驗證通過、無未預期的副作用 -->
```

<v-click>

→ 200 行就能消除大部分的探索浪費

</v-click>

---

# 日漸膨脹的 AGENTS.md

Agent 犯錯 → 加一條規則 → 指令檔從 50 行膨脹到 600+ 行

<v-clicks>

- **Context 消耗** — 600 行 ≈ 10-20K tokens（佔 200K window 的 5-10%）
- **中間迷失** — LLM 處理開頭 / 結尾的表現遠優於中間內容
- **優先級不明** — Agent 無法區分硬性規範 vs. 軟性建議
- **矛盾累積** — 新舊規則互相衝突

</v-clicks>

<v-click>

**解法：漸進式揭露**
→ AGENTS.md（50-200 行）連結到其餘的主題文件，做更詳細的說明
- api.md
- components.md
- testing-guidelines.md
- ...

</v-click>

---
layout: center
---

# Agent 說做完了，但一測就炸

---

# Agent 對自身有過度樂觀的傾向

把「完成」的判定權交給 Harness 外部系統，而非讓 Agent 自己說了算

在 AGENT.md 中加入驗證規則

<v-clicks>

- **語法靜態檢查** — lint、type check
- **運行時行為驗證** — unit test、integration test
- **E2E 系統測試** — 完整流程測試

</v-clicks>

<v-click>

→ 核心功能驗證通過之前，**禁止重構**（功能正確性 → 效能 → 撰寫風格）

</v-click>

---

# 雙重可觀測性

給 Agent 裝上儀表板

<v-clicks>

- **系統層** — log、trace、health check
  - 告訴它「系統發生了什麼事」

- **流程層** — **PROGRESS.md**：當前進度、已完成/進行中/阻塞的任務、驗收條件
  - 告訴它「為什麼這個任務應該要被完成、如何完成」
  - 避免 Agent 在錯誤方向上盲目重試

</v-clicks>

---

# 每次會話的清潔交接

「以後再清理」= 永遠不清理

<v-clicks>

會話結束前的各項檢查：

- **Build 通過**
- **Tests 通過**（含既有測試）
- **進度已記錄**（machine-readable artifact）
- **清理臨時檔案 / 程式碼**（debug log、temp file、註解程式碼）
- **專案可順利啟動**（下個 session 不需人工介入）

</v-clicks>

---

# 不清理的代價

12 週專案退化曲線：

| | Week 1 | Week 12（無 cleanup） | Week 12（有 cleanup） |
|---|---|---|---|
| Build 通過率 | 100% | 68% | 97% |
| Test 通過率 | 100% | 61% | 95% |
| 啟動時間 | 5 min | 60+ min | 9 min |

<v-click>

→ 熵增是預設行為 — 不主動維護，品質一定下降。技術債會指數級累積，拖垮下一個會話

</v-click>

---
layout: center
---

# 總結

---
layout: center
---

<div class="grid grid-cols-3 gap-6 text-sm">
<div>

**模型能力強 ≠ 執行可靠**

- 同一模型，Harness 決定成敗
- Harness = 指令 + 工具 + 環境 + 狀態 + 驗證
- 不是 Prompt，是完整的廚房系統

</div>
<div>

**Token 和時間如何有效利用**

- 儲存庫是唯一真相來源
- 用 AGENTS.md 消除探索浪費
- 試圖減少 LLM 的上下文焦慮
- 指令要拆分，不要膨脹

</div>
<div>

**Agent 說做完了，一測就炸**

- 使用 Harness 取代自我評估
- PROGRESS.md 雙重可觀測性
- 每次會話都要 Clean State

</div>
</div>

---

# 安裝 Harness <a href="https://github.com/walkinglabs/learn-harness-engineering/blob/main/docs/en/resources/templates/index.md" target="_blank" style="text-decoration: none !important; border-bottom: none !important;"><carbon-logo-github class="inline-block text-xl align-middle" /> </a>

<img src="/template-guide.png" class="m-auto mt-16 h-64 rounded shadow" />

---
layout: center
---

# Reference

- [Learn Harness Engineering](https://github.com/walkinglabs/learn-harness-engineering)
- [Harness engineering: leveraging Codex in an agent-first world](https://openai.com/index/harness-engineering/)
- [Harness design for long-running application development](https://www.anthropic.com/engineering/harness-design-long-running-apps)

---
layout: center
class: text-center
---

<div class="flex flex-col items-center justify-center h-full">
  <h1>The end</h1>
  <PoweredBySlidev />
</div>
