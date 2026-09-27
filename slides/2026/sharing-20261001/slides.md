---
theme: default
background: https://images.unsplash.com/photo-1755157318174-8a1d942ffe5a?q=80&w=2070
title: TypeSafe Jev
author: Jonathan Tang
date: 2026.10.01
info: TypeSafe Jev 介紹，以及在開發端的三個用法：i18n 語意對齊、worklog 標籤分類、ux-review 探索
class: text-center
highlighter: shiki
drawings:
  persist: false
transition: slide-left
mdc: true
monaco: true
---

# Sharing 2026.10.01

Jonathan

---
layout: center
---

# 今天的內容

- <Link to="part1-what-is-jev" title="Jev 是什麼"/>
- <Link to="part2-usage" title="工作上的用法"/>
- <Link to="part3-takeaways" title="心得"/>

---
routeAlias: part1-what-is-jev
layout: center
---

# Jev 是什麼

---

# TypeSafe 與 Jev

<v-clicks>

- **2026.09.15** TypeSafe AI 首次公開亮相，發表 Jev，同時宣布募得 $40M
- **2026.09.20** 開放註冊
- 舊金山的 AI lab，2024 年成立

</v-clicks>

<div v-click class="grid grid-cols-3 gap-4 mt-6">
  <div class="border rounded p-4 flex flex-col items-center text-center">
    <img src="/diogo-almeida.jpg" alt="Diogo Almeida" class="w-20 h-20 rounded-full object-cover mb-2" />
    <div class="font-bold">Diogo Almeida</div>
    <div class="text-sm opacity-70">CEO</div>
    <div class="text-sm mt-2">前 OpenAI，共同發明 RLHF、InstructGPT</div>
  </div>
  <div class="border rounded p-4 flex flex-col items-center text-center">
    <img src="/sasha-sheng.jpg" alt="Sasha Sheng" class="w-20 h-20 rounded-full object-cover mb-2" />
    <div class="font-bold">Sasha Sheng</div>
    <div class="text-sm opacity-70">COO</div>
    <div class="text-sm mt-2">前 Meta / FAIR research engineer</div>
  </div>
  <div class="border rounded p-4 flex flex-col items-center text-center">
    <img src="/erik-gafni.jpg" alt="Erik Gafni" class="w-20 h-20 rounded-full object-cover mb-2" />
    <div class="font-bold">Erik Gafni</div>
    <div class="text-sm opacity-70">CTO</div>
    <div class="text-sm mt-2">連續創業，擅長 production AI 系統</div>
  </div>
</div>

---
layout: two-cols
---

# 為什麼叫 Jev

<v-clicks>

- 取自經濟學家 **William Stanley Jevons**
- **Jevons paradox**（傑文斯悖論）
  - 1865 年，蒸汽機改良後，燒同樣的煤能做更多事
  - 結果煤的用量不減反增，因為蒸汽機被用到工廠、鐵路、輪船
- TypeSafe 押注 AI 也會如此發展
  - 只要一個判斷的成本遠低於一美分
  - 就會被放進以前根本不會呼叫 LLM 的地方

</v-clicks>

<div class="absolute bottom-4 left-14 text-xs opacity-50">
  參考：<a href="https://flaviocopes.com/jev/" target="_blank">flaviocopes.com/jev</a>
</div>

::right::

<div class="h-full flex flex-col items-center justify-center">
  <img src="/jevons.jpg" alt="William Stanley Jevons" class="h-96 shadow-xl rounded" />
  <div class="text-xs opacity-60 mt-2">William Stanley Jevons（1835–1882）</div>
</div>

---
layout: two-cols
---

# Jev 是 System One model

<v-clicks>

- 這個分法來自 Kahneman《快思慢想》
  - **System 1**：快、直覺
  - **System 2**：慢、需要推理
- 一般的 LLM 比較像 System 2：會推理、產生文字
- TypeSafe 做的是 **System One model**，Jev 是第一個
  - 不寫回覆、不寫程式碼、不解釋理由
  - 只回傳**有型別的答案**和**機率**
  - 每題約 100ms

</v-clicks>

::right::

<div class="h-full flex items-center justify-center">
  <img src="/thinking-fast-and-slow.jpg" alt="快思慢想 封面" class="h-96 shadow-xl rounded" />
</div>

---

# Code 與 Jev 的分工

<v-clicks>

- **Code** 掌控流程、規則、side effects
- **Jev** 只回答拆得很細的判斷題
  - 「這則訊息是不是在問帳單？」
  - 「這兩句翻譯的意思一樣嗎？」
- 回傳的是 JSON，不用再 parse 一段文字
- 流程：拆題 → 平行發問 → 在 code 裡組合 → 依機率決定下一步

</v-clicks>

---

# 三種 Primitive

| Primitive | 問的是 | 回傳 |
|------|------|------|
| **Choice** | 選擇題：從一組選項裡選一個 | `choice`、`probabilities`、`confidence` |
| **Noul** | 是非題：某個條件成不成立 | `noul`（yes 的機率，0–1） |
| **Score** | 量表題：落在有序刻度的哪個位置 | `score`、`probabilities`、`confidence` |

<div v-click class="mt-6">

- JS SDK：`npm install @typesafe-ai/sdk`（Node 20+）
- 從 `TYPESAFE_API_KEY` 讀 key，所以要放在 server 端

</div>

---

# Choice：選擇題

```ts {all|7-11|14}
import { choice, TypeSafeClient } from "@typesafe-ai/sdk";

const client = new TypeSafeClient();
const response = await client.systemOne({
  state: { document: "I was charged twice. Please fix this ASAP." },
  questions: {
    category: choice("What is this ticket about?", {
      billing: null,
      technical: null,
      other: null,
    }),
  },
});
response.answers.category.choice; // "billing"
```

<v-click>

- 回傳的型別從 `questions` 推導出來，`category.choice` 會是 `"billing" | "technical" | "other"`
- 選項可能不完整時，加一個 `other`

</v-click>

---

# Noul：是非題

```ts {all|4|5-8|11}
const { answers } = await client.systemOne({
  state: "I was charged twice. Please help.",
  questions: {
    billing: noul("Is this about billing?"),
    is_repeat_contact: noul("Has the customer contacted support about this before?", {
      true: "Mentions a prior attempt, ticket, or that they have asked before",
      false: "No sign of any previous contact",
    }),
  },
});
answers.billing.noul; // 0.95
```

<v-clicks>

- 只回傳一個數字：yes 的機率，沒有 `confidence`
- 0.5 代表 yes 和 no 一樣可能，不是「中等程度」
- 多個標籤可能同時成立時，每個標籤各問一題 Noul

</v-clicks>

---

# Score：量表題

```ts
const { answers } = await client.systemOne({
  state: "The export button crashes the settings page in Safari...",
  questions: {
    bug_severity: score("How severe is the reported issue?", [
      "Cosmetic; no impact to functionality",
      "Broken or degraded feature, but workaround exists",
      "Blocking issue; no workaround exists",
    ]),
  },
});
// score: 1.43, probabilities: { 0: 0, 1: 0.57, 2: 0.43 }
```

<v-clicks>

- `score` = Σ level × 機率，是連續值（這裡是 0–2）
- 每個 level 要描述具體情境，單獨拿出來也看得懂
- 適合做排序：每個項目各問一次，再比較分數

</v-clicks>

---

# state / instructions / criteria

<v-clicks>

- **state**：要被判斷的內容（string、JSON object 或 array）
  - 有多個部分時用 object，instructions 裡可以寫 `` `ticket.messages[0].text` `` 指到欄位
- **instructions**：問題本身，保持簡短
- **criteria**：選項或刻度的定義，容易混淆時寫成結構

</v-clicks>

<v-click>

```ts
criteria: {
  billing: { what: "Charges, invoices, refunds, or subscriptions",
             not_for: "Order tracking or account access" },
  shipping: { what: "Order tracking and delivery" },
}
```

</v-click>

---

# 多題一起問

<v-clicks>

- 同一個 request 可以放很多題，平行跑、彼此看不到答案
- 官方 cookbook：一篇約 54k 字元的文章問 13 題

| | 成本 | 時間 |
|---|---|---|
| 合成一個 request | $0.000497 | 0.27s |
| 一題一個 request | $0.006090 | 2.71s |

- 便宜 12 倍、快 10 倍，答案沒有差別（jev-1.12 的數據）
- 「可能會用到」的後續問題也可以先一起問，code 再挑要用的

</v-clicks>

---

# 怎麼看 confidence

<v-clicks>

- `confidence` 把機率分布的集中程度壓成 0–1
  - 全部集中在一個選項是 1，平均分散是 0
- 官方建議的起點：

| confidence | 做法 |
|---|---|
| < 0.5 | 轉給人 |
| 0.5–0.9 | 先驗證或請使用者確認 |
| > 0.9 | 自動處理 |

- 門檻要拿自己的資料校準，同一個系統裡不同動作可以用不同門檻

</v-clicks>

---

# 規格與限制

<div class="grid grid-cols-2 gap-8">

<div v-click>

**規格**

- 模型：`jev-1.13.0`（`jev-latest`）
- $0.042 / 1M input tokens，output 不收費
- 每題約 100ms
- 每個 request 64k tokens
- 只收文字

</div>

<div v-click>

**限制**

- 算術、計數、日期比較不可靠
- 英文最準，中文等其他語言比較不穩
- state 裡的無關內容會干擾判斷
- 所有人共用同一組 weights，不能 fine-tune

</div>

</div>

---
routeAlias: part2-usage
layout: center
---

# 工作上的用法

---

# TODO：Part 2

---
routeAlias: part3-takeaways
layout: center
---

# 心得

---

# TODO：Part 3

---
layout: center
class: text-center
---

# Thank You!

Questions?
