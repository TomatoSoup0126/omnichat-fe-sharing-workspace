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
layout: center
---

# 模型能力強 ≠ 執行可靠

---

# 千里馬與馬鞍的迷思

同一個模型 (Opus 4.5)，同一個任務 (2D 復古遊戲製作器)：

| | 裸跑（無 Harness） | 完整 Harness |
|---|---|---|
| 投入 | 20 分鐘 / $9 | 6 小時 / $200 |
| 結果 | 核心功能壞掉 | 完整可玩的遊戲 |

<v-click>

→ 模型沒變，改變的是**馬鞍**

</v-click>

---

# 什麼是 Harness？

不是單純的「提示詞 (Prompt)」，而是**模型權重之外的一切工程基礎設施**

<v-click>

就像一間餐廳 — 模型是食材，Harness 是整套廚房系統：

</v-click>

<v-clicks>

| 餐廳比喻 | Harness 子系統 | 說明 |
|---|---|---|
| 菜譜 | **Instruction** | AGENTS.md / CLAUDE.md — 規範與架構 |
| 刀具 | **Tool** | 工具存取權限 |
| 灶台 | **Environment** | 自描述環境：package.json、tsconfig |
| 備菜台 | **State** | PROGRESS.md — 追蹤進度 |
| 出菜檢查口 | **Feedback** | 驗證指令：vitest、tsc、eslint |

</v-clicks>

---
layout: center
---

# 資訊與上下文管理

## 拒絕把 Token 浪費在「猜測」上

---

# 專案儲存庫是唯一的可靠資訊來源

Agent 看不到 Slack、Jira 或工程師腦袋裡的資訊

<v-clicks>

- 所有架構決策與硬性規範 → 必須寫入儲存庫（例如 AGENTS.md）
- **不在儲存庫裡的知識，對 Agent 來說等於不存在**

</v-clicks>

---

# Cold-Start Test

一個全新 Agent session，僅靠 repo 能回答這五個問題嗎？

1. 這個系統是什麼？
2. 它是怎麼組織的？
3. 怎麼跑起來？
4. 怎麼驗證？
5. 目前的進度？

<v-click>

→ 答不出來 = 知識盲區 = 更高的失敗率

</v-click>

---

# 對抗「中間迷失」

Agent 犯錯 → 加一條規則 → 指令檔從 50 行膨脹到 600+ 行

<v-clicks>

- **Context 預算消耗** — 600 行 ≈ 10-20K tokens（佔 200K window 的 5-10%）
- **Lost in the Middle** — LLM 處理開頭 / 結尾的表現遠優於中間內容
- **優先級不明** — Agent 無法區分硬性規範 vs. 軟性建議
- **矛盾累積** — 新舊規則互相衝突

</v-clicks>

<v-click>

**解法：漸進式揭露**
→ AGENTS.md（50-200 行）連結到主題文件（testing-guidelines.md, api-conventions.md...）

</v-click>

---

# 三層終止校驗

把「完成」的判定權交給 Harness 外部系統，而非讓 Agent 自己說了算

<v-clicks>

1. **語法靜態檢查** — lint、type check
2. **運行時行為驗證** — unit test、integration test
3. **端到端系統測試** — 完整流程 E2E

</v-clicks>

<v-click>

→ 核心功能驗證通過之前，**禁止重構**（功能正確性 → 效能 → 風格）

</v-click>

---

# 端到端測試的必要性

Unit test 的盲區：mock 隱藏了真正的跨組件問題

<v-clicks>

- **介面不匹配** — 元件間資料格式不相容
- **狀態傳播錯誤** — 跨層的不一致
- **資源生命週期** — 跨元件的 subscription / event listener
- **環境依賴** — mock 環境通過，真實環境失敗

</v-clicks>

<v-click>

→ 加入 E2E 不僅能**抓錯**，還能改變 Agent **遵守架構邊界**的行為

</v-click>

---

# 明確的錯誤訊息

<div class="grid grid-cols-2 gap-8 mt-8">
<div>

**差的錯誤訊息**

```
Error: assertion failed
Exit code: 1
```

Agent 只能**盲目重試**

</div>
<div>

**好的錯誤訊息**

```
Error: POST /users returned 500
Expected: 201
Check: database migration
  has not been applied
Fix: run `pnpm db:migrate`
```

Agent 能**精準修復**

</div>
</div>

<v-click>

→ 給予明確的修復指導，而非只丟出報錯

</v-click>

---

# 雙層可觀測性

給 Agent 裝上儀表板

<v-clicks>

- **系統層** — log、trace、health check
  - 告訴你「系統做了什麼」

- **流程層** — Sprint Contract、客觀評分標準
  - 告訴你「為什麼這個變更應該被接受」
  - 避免 Agent 在錯誤方向上**盲目重試**

</v-clicks>

<v-click>

→ 沒有可觀測性 = 在黑暗中除錯

</v-click>

---

# 每次會話的清潔交接

「以後再清理」= **永遠不清理**

<v-clicks>

會話結束前的五項檢查：

1. **Build 通過**
2. **Tests 通過**（含既有測試）
3. **進度已記錄**（machine-readable artifact）
4. **清理臨時工件**（debug log、temp file、註解程式碼）
5. **啟動路徑可用**（下個 session 不需人工介入）

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

# 兩大主題，完整 Harness

<div class="grid grid-cols-2 gap-8">
<div>

**一、模型能力強 ≠ 執行可靠**

- 同一模型，Harness 決定成敗
- Harness = 指令 + 工具 + 環境 + 狀態 + 回饋
- 不是 Prompt，是完整的廚房系統

</div>
<div>

**二、資訊與上下文管理**

- Repo 是唯一真相來源
- 指令要拆分，不要膨脹
- 三層終止校驗 + E2E 測試
- 雙層可觀測性
- 每次會話都要 Clean State

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
