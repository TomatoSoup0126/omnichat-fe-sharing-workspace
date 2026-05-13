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

# Context Engineering vs. Harness Engineering

| | Context Engineering | Harness Engineering |
|---|---|---|
| **關注點** | 給模型正確的輸入 | 讓 Agent 可靠地完成任務 |
| **範圍** | Prompt、RAG、Memory、MCP | 指令 + 工具 + 環境 + 狀態 + 驗證 |
| **對象** | 單次 LLM 呼叫 | 跨 Session 的 Agent 工作流 |
| **成功標準** | 模型回答正確 | 功能完整交付且通過驗證 |

<v-click>

<div class="mt-8">

→ Context Engineering 可被視為 Harness 的子集合

</div>

</v-click>

---
layout: center
---

# 痛點 1：模型很強，為什麼結果還是不盡人意？

---

# 強模型不等於可靠執行

核心論點：升級更強的模型**不能**解決 Agent 的可靠性問題

<v-clicks>

- SWE-bench Verified 上最強的 coding agent 也只有 ~50-60% 通過率 (2025/12)
- 真正影響成敗的不是模型能力，而是**環境**

</v-clicks>

---

# Anthropic 的對照實驗

同一個模型 (Opus 4.5)，同一個任務 (2D 復古遊戲製作器)：

| | 裸環境 | 完整 Harness |
|---|---|---|
| 時間 | 20 分鐘 | 6 小時 |
| 費用 | $9 | $200 |
| 結果 | 核心功能壞掉 | 完整可玩的遊戲 |

<v-click>

→ 模型沒變，改變的是環境

</v-click>

---

# Agent 的五大困難

<v-clicks>

1. **任務定義不清** — 模糊指令迫使 Agent 猜測
2. **未文件化的潛規則** — Agent 看不到的規則（e.g. 只存在於 Slack 對話串裡的細節）
3. **不完整的執行環境** — 缺少相依套件、版本不對
4. **沒有驗證機制** — 沒有測試或 lint 來確認正確性
5. **長任務的「上下文焦慮」** — Context window 逼近上限時，Agent 會傾向過早收斂，導致失敗率急遽上升

</v-clicks>

---

# Harness 的五子系統

Harness **不只是**一個 prompt 檔案，而是模型權重以外的一切

<v-clicks>

1. **Instruction (食譜架)** — AGENTS.md / CLAUDE.md：專案概覽、技術堆疊、硬性規範
2. **Tool (刀具架)** — 足夠的工具存取權限
3. **Environment (爐具)** — 自描述環境：package.json、.nvmrc、tsconfig.json
4. **State (備料台)** — PROGRESS.md 追蹤已完成 / 進行中 / 阻塞的工作
5. **Feedback (品檢窗口)** — 明確的驗證指令：vitest、tsc、eslint、pnpm check

</v-clicks>

---

# 實證：逐步加入子系統的效果

<div class="grid grid-cols-2 gap-8">
<div>

**案例 1**：Claude Sonnet + FastAPI

| | 沒有 Harness | 加入 AGENTS.md |
|---|---|---|
| 上下文浪費 | 40% | 大幅降低 |
| 結果 | 宣告完成但有錯誤 | 三次嘗試都成功 |

</div>
<div>

**案例 2**：GPT-4o + React (~20K 行)

| 配置 | 成功率 |
|---|---|
| 只有 README | 20% |
| + AGENTS.md | 60% |
| + 驗證指令 | 80% |
| + 進度追蹤 | 80-100% |

</div>
</div>

<v-click>

→ 模型始終不變 — 所有改善都來自 Harness

</v-click>

---
layout: center
---

# 痛點 2：Agent 花 40% 時間在探索 repo，效率超低

---

# Repo 是唯一真相來源

→ 不在 repo 裡的資訊，對 Agent 來說就是不存在的

Agent 無法存取 Slack、Jira、Notion 或任何人腦中的隱藏知識

---

# Cold-Start Test

一個全新的 Agent session，僅靠 repo 內容能回答這五個問題嗎？

<v-clicks>

1. 這個系統是什麼？
2. 它是怎麼組織的？
3. 怎麼跑起來？
4. 怎麼驗證？
5. 目前的進度？

</v-clicks>

<v-click>

→ 答不出來 → 知識盲區 → 更高的失敗率

</v-click>

---

# 建議的 Repo 結構

```
project/
├── AGENTS.md          # 入口檔 (50-100 行)
├── ARCHITECTURE.md    # 每個模組一份
├── CONSTRAINTS.md     # 硬性約束
├── PROGRESS.md        # 當前進度
├── Makefile           # 驗證指令
└── docs/              # 主題文件
```

<v-click>

四個原則：知識放在程式碼旁邊、標準化入口檔、最小但完整、文件隨程式碼一起更新

</v-click>

---

# 「巨型指令檔」的陷阱

Agent 犯錯 → 加一條規則 → 指令檔從 50 行膨脹到 600+ 行

<v-clicks>

- **Context 預算消耗** — 600 行 = 10-20K tokens（佔 200K window 的 5-10%）
- **Lost in the Middle 效應** — LLM 處理開頭/結尾遠優於中間內容
- **優先級不明** — Agent 無法區分硬性約束和軟性建議
- **矛盾累積** — 新舊規則互相衝突

</v-clicks>

---

# 解法：漸進式揭露架構

```
AGENTS.md (50-200 行，路由器)
├── 專案概覽
├── 首次執行指令
├── 最多 15 條全域硬性約束
└── 連結到主題文件 ↓

docs/
├── testing-guidelines.md (50-150 行)
├── api-conventions.md
├── security-requirements.md
└── ...
```

<v-click>

**實際案例**：SaaS 團隊重構 600 行 AGENTS.md → 80 行路由器 + 主題文件
- 任務成功率：45% → 72%
- 安全合規率：60% → 95%

</v-click>

---
layout: center
---

# 痛點 3：同時碰 5 個功能，沒有一個完整的

---

# Agent 傾向同時啟動多個任務

<v-clicks>

- **Overreach**：啟動太多任務
- **Under-finish**：已啟動 vs. 已驗證完成的比率太低
- 兩者是共生的 — 解決一個就解決另一個
- **Little's Law**：高 WIP → 每個任務的 lead time 增加

</v-clicks>

<v-click>

→ 使用 WIP=1 策略的 Agent，任務完成率高出 37%

</v-click>

---

# 實際案例：REST API 8 個功能

| | Buffet Mode (無約束) | Single-Plate Mode (WIP=1) |
|---|---|---|
| 同時啟動 | 5 個功能 | 1 個功能 |
| 程式碼量 | 800 行 / 12 檔案 | 200 行 / 4 檔案 |
| E2E 通過率 | 20% | 100% |
| 功能完成率 | 37.5% | 87.5% |

<v-click>

→ 「做少但做完」永遠優於「做多但做一半」

</v-click>

---

# Feature List 作為基礎資料結構

每個 feature 需要三重結構：

```json
{
  "id": "F-001",
  "behavior": "POST /users returns 201 with valid payload",
  "verification": "curl -s -o /dev/null -w '%{http_code}' -X POST ...",
  "state": "not_started",
  "evidence": null
}
```

<v-clicks>

**四個狀態**：`not_started` → `active` → `passing` / `blocked`

**關鍵規則**：Agent **不能**直接改變狀態 — 必須透過驗證指令的執行結果來推進

</v-clicks>

---
layout: center
---

# 痛點 4：Agent 說做完了，一測就炸

---

# Agent 過早宣告完成

關鍵失敗模式：Agent 經常**過早宣告任務完成**

<v-click>

例：密碼重設功能 — unit test 通過，但 email service 設定缺失、migration 失敗、E2E 流程從未測試

</v-click>

---

# 三個致命陷阱

<v-clicks>

1. **Unit test 通過 ≠ 任務完成** — mock 隱藏了介面不匹配、狀態傳播錯誤、環境依賴
2. **「順便重構」毒害完成度判斷** — 改動了已驗證與未驗證程式碼的邊界
3. **系統性的自我評估偏差** — 同一個模型生成又評估，容易偏袒自己

</v-clicks>

---

# 三層終止驗證

<v-clicks>

1. **語法/靜態分析** — lint、type check
2. **執行時行為驗證** — unit test、integration test
3. **系統級 E2E 確認** — 完整流程測試

</v-clicks>

<v-click>

→ 核心功能驗證通過之前，禁止重構（功能正確性 → 效能 → 風格）

</v-click>

---

# Unit Test 抓不到的四類問題

<v-clicks>

1. **介面不匹配** — 元件之間的資料格式不相容
2. **狀態傳播錯誤** — 跨層的不一致
3. **資源生命週期問題** — 跨元件的 subscription、event listener
4. **環境依賴** — mock 環境通過，真實環境失敗

</v-clicks>

<v-click>

→ 架構規則必須是可執行的，不能只是寫在文件裡

</v-click>

---
layout: center
---

# 痛點 5：新 Session 打開，之前做的事全忘了

---

# 資訊流失的問題

<v-clicks>

- **摘要壓縮**保留了「做了什麼」，但失去了「為什麼這樣做」
- 下個 session 看到結果，卻不理解決策背景，可能撤銷刻意的最佳化
- **Context Anxiety**：Anthropic 研究顯示 Agent 在接近 context 上限時會「過早收斂」 — 倉促、跳過驗證、選擇次佳方案

</v-clicks>

---

# 四個連續性工具

<v-clicks>

1. **PROGRESS.md** — 當前 commit hash、測試/lint 狀態、已完成/進行中/阻塞的任務、已知問題、下一步
2. **DECISIONS.md** — 架構選擇的理由、被拒絕的替代方案、約束條件
3. **Git commits 作為 checkpoint** — 原子化工作單元 + 解釋性 commit message
4. **Session 日常流程**
   - Clock-in：讀取進度/決策、跑驗證、從 next steps 繼續
   - Clock-out：更新進度、驗證、commit

</v-clicks>

---

# 實際效果

Blog 系統，12 個功能，~5 個 session：

| | 沒有 Journal | 有 Journal |
|---|---|---|
| 功能完成 | 7/12 (58%) | 12/12 (100%) |
| 缺陷率 | 43% | 8% |
| 重建時間 | — | 減少 78% |

<v-click>

→ 把 Agent 當成有失憶症的天才工程師：下班前一定要記錄做了什麼、為什麼、下一步做什麼

</v-click>

---

# Bootstrap Contract — 初始化是獨立階段

第一個 session 的產出：**零業務功能**，只確認四件事

<v-clicks>

- **Can start** — 環境可運作
- **Can test** — 至少一個測試通過
- **Can see progress** — 狀態有文件記錄
- **Can pick up next steps** — 任務拆解存在

</v-clicks>

<v-click>

→ 有獨立初始化階段的專案，多 Session 場景下功能完成率高出 31%

</v-click>

---
layout: center
---

# 痛點 6：專案做三個月，啟動從 5 分鐘變 60 分鐘

---

# 兩個層次的可觀測性

<v-clicks>

- **Runtime Observability** — 系統層信號（log、trace、process event、health check）
  - 「系統做了什麼」
- **Process Observability** — Harness 決策產物（計畫、評分標準、驗收條件）
  - 「為什麼這個變更應該被接受」

</v-clicks>

<v-click>

→ 沒有可觀測性，Agent 在不確定中做決策，重試變成盲目摸索

</v-click>

---

# Clean State 的五個條件

每次 Session 結束都要保持乾淨：「晚點再清」= 永遠不清

<v-clicks>

1. **Build 通過**
2. **Tests 通過**（包含既有測試）
3. **進度已記錄**（machine-readable artifact）
4. **沒有殘留物**（debug log、temp file、註解掉的程式碼、TODO marker）
5. **啟動路徑可用**（下個 session 不需要人工介入）

</v-clicks>

---

# 不清理的代價

沒有 cleanup 策略的 12 週專案退化曲線：

| | Week 1 | Week 12 (無 cleanup) | Week 12 (有 cleanup) |
|---|---|---|---|
| Build 通過率 | 100% | 68% | 97% |
| Test 通過率 | 100% | 61% | 95% |
| 啟動時間 | 5 min | 60+ min | 9 min |

<v-click>

→ 熵增是預設行為 — 不主動維護，品質一定下降

</v-click>

---
layout: center
---

# 總結

---

# 六個痛點，六組解法

<div class="grid grid-cols-2 gap-4 text-sm">
<div>

**1. 結果不可靠**
- Harness = 模型權重以外的一切
- 五子系統：指令、工具、環境、狀態、驗證

**2. Agent 在瞎猜**
- Repo 是唯一真相來源
- 指令要拆分，不要膨脹

**3. 做太多做不完**
- WIP=1，做少做完
- Feature List 是基礎元件

</div>
<div>

**4. 說完成但沒完成**
- 外部化完成判斷
- E2E 測試是真正的驗證

**5. 跨 Session 失憶**
- 連續性工具 + Session 日常流程
- 初始化是獨立階段

**6. 長期退化**
- 可觀測性是核心架構屬性
- 每次 Session 都要 clean state

</div>
</div>

---
layout: center
---

# 一句話總結

→ 不要升級模型，先升級 Harness

<v-click>

課程來源：[Learn Harness Engineering](https://walkinglabs.github.io/learn-harness-engineering/en/)

</v-click>

---
layout: center
class: text-center
---

<div class="flex flex-col items-center justify-center h-full">
  <h1>The end</h1>
  <PoweredBySlidev />
</div>
