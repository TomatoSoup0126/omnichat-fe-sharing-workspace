---
theme: default
background: https://images.unsplash.com/photo-1755157318174-8a1d942ffe5a?q=80&w=2070
title: TypeSafe Jev
author: Jonathan Tang
date: 2026.10.01
info: TypeSafe Jev 介紹，以及兩個實際用法：工作日誌的類型標籤、Figma View plugin
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
- <Link to="part-agentic-cases" title="使用情境"/>
- <Link to="part-github-cases" title="GitHub 上的使用案例"/>
- <Link to="part2-usage" title="目前拿來做了什麼"/>
- <Link to="part3-takeaways" title="心得"/>

---
routeAlias: part1-what-is-jev
layout: center
---

# JEV?

---

# 剛開放註冊的模型

<v-clicks>

- **2026.09.15** TypeSafe AI 首次公開亮相，發表 Jev，同時宣布募得 $40M
- **2026.09.20** 取消候補名單，開放所有人使用
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

# System One 與 System Two

<v-clicks>

- 名稱來自 Kahneman《快思慢想》
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
layout: two-cols
---

# 名稱由來

<v-clicks>

- 取自經濟學家 **William Stanley Jevons**
- **Jevons paradox**（[傑文斯悖論](https://zh.wikipedia.org/zh-tw/%E5%A8%81%E5%BB%89%C2%B7%E6%96%AF%E5%9D%A6%E5%88%A9%C2%B7%E6%9D%B0%E6%96%87%E6%96%AF#%E6%9D%B0%E6%96%87%E6%96%AF%E5%9B%B0%E5%B1%80)）
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

# Jev 負責什麼

<v-clicks>

- 只回答拆得很細的判斷題
  - 「這組中英文翻譯的意思一樣嗎？」
  - 「這個 catch 顯示的錯誤訊息，跟這個操作對得上嗎？」
  - 「這張票是 bug 修復、新功能還是重構？」
  - 「這個 shell 指令是唯讀的嗎？」
  - 「這個 PR 描述跟 diff 的內容一致嗎？」

</v-clicks>

---

# 三種 Primitive

| Primitive | 問的是 | 回傳 |
|------|------|------|
| **Choice** | 選擇題：從一組選項裡選一個 | `choice`、`probabilities`、`confidence` |
| **Noul** | 是非題：某個條件成不成立 | `noul`（yes 的機率，0–1） |
| **Score** | 量表題：落在有序刻度的哪個位置 | `score`、`probabilities`、`confidence` |

---

# state / instructions / criteria

<div class="grid grid-cols-[3fr_2fr] gap-6">

<div>

```jsonc {all|1-2|5|9|10-15}
// POST https://api.typesafe.ai/v1/systemone
// Authorization: Bearer $TYPESAFE_API_KEY
{
  "model": "jev-latest",
  "state": { "document": "我被重複扣款兩次，請盡快處理！" },
  "questions": {
    "category": {
      "type": "choice",
      "instructions": "這張客服單是關於什麼？",
      "criteria": {
        "billing": { "what": "扣款、發票、退款或訂閱",
                     "not_for": "訂單追蹤或帳號登入" },
        "shipping": { "what": "訂單追蹤與配送" },
        "other": null
      }
    }
  }
}
```

</div>

<div>

- **state**：要被判斷的內容（string、JSON object 或 array），所有題目共用
- **instructions**：問題本身，保持簡短
- **criteria**：Choice 的選項、Noul 的 true / false、Score 的刻度
  - 描述可以是字串，容易混淆時改寫成 object，例如 `{ what, not_for }`

</div>

</div>

---

# Choice：選擇題

```jsonc {all|6|7|8-12|16-17}
{
  "model": "jev-latest",
  "state": { "document": "我被重複扣款兩次，請盡快處理！" },
  "questions": {
    "category": {
      "type": "choice",
      "instructions": "這張客服單是關於什麼？",
      "criteria": {
        "billing": "扣款、發票、退款或訂閱",  // 附上描述
        "technical": null,  // 只給名稱
        "other": null       // 選項可能不完整時，加一個 other
      }
    }
  }
}
// 實測：choice "billing"，confidence 1.0
// probabilities { billing: 1.0, technical: 0, other: 0 }
```

---

# Noul：是非題

```jsonc {all|6|7|8-11|15}
{
  "model": "jev-latest",
  "state": "我被重複扣款了，請幫忙處理。",
  "questions": {
    "is_repeat_contact": {
      "type": "noul",
      "instructions": "顧客之前是否已經為這件事聯絡過客服？",
      "criteria": {
        "true": "提到之前問過、開過單，或已經反映過",
        "false": "沒有任何之前聯絡過的跡象"
      }
    }
  }
}
// 實測：is_repeat_contact 0.11
```

<v-clicks>

- 只回傳一個數字：yes 的機率，沒有 `confidence`
- 0.5 代表 yes 和 no 一樣可能，不是「中等程度」

</v-clicks>

---

# Score：量表題

```jsonc {all|6|7|8-12|16}
{
  "model": "jev-latest",
  "state": "在 Safari 上，設定頁的匯出按鈕點了會讓整頁當掉⋯⋯",
  "questions": {
    "bug_severity": {
      "type": "score",
      "instructions": "回報的問題有多嚴重？",
      "criteria": [
        "外觀問題，不影響功能",
        "功能壞掉或變差，但有替代做法",
        "完全卡住，沒有替代做法"
      ]
    }
  }
}
// 實測：score 1.8，confidence 0.69，probabilities { 0: 0, 1: 0.2, 2: 0.8 }
```

<v-clicks>

- `score` = Σ level × 機率，是連續值（這裡是 0–2）
- 每個 level 要描述具體情境，單獨拿出來也看得懂

</v-clicks>

---

# 多題一起問

<div class="text-sm opacity-70 -mt-2 mb-2">同一個 request 可以放很多題、混用三種題型，平行跑、彼此看不到答案</div>

```jsonc {all|3|5-8|9-11|12-15|18-19}
{
  "model": "jev-latest",
  "state": { "document": "我被重複扣款兩次，上週已經來信反映過了，請盡快處理！" },
  "questions": {
    "category": {
      "type": "choice", "instructions": "這張客服單是關於什麼？",
      "criteria": { "billing": "扣款、發票、退款或訂閱", "technical": null, "other": null }
    },
    "is_repeat_contact": {
      "type": "noul", "instructions": "顧客之前是否已經為這件事聯絡過客服？"
    },
    "urgency": {
      "type": "score", "instructions": "顧客有多急？",
      "criteria": ["不急，可以慢慢處理", "希望盡快處理", "非常緊急，需要立即處理"]
    }
  }
}
// 實測：一個 request 約 0.4 秒
// category "billing"（1.0）、is_repeat_contact 0.96、urgency 1.16
```

---

# 多題一起問：省多少

<v-clicks>

- 官方 cookbook：一篇約 54k 字元的文章問 13 題

| | 成本 | 時間 |
|---|---|---|
| 合成一個 request | $0.000497 | 0.27s |
| 一題一個 request | $0.006090 | 2.71s |

- 便宜 12 倍、快 10 倍，答案沒有差別（jev-1.12 的數據）
- 「可能會用到」的後續問題也可以先一起問，code 再挑要用的

</v-clicks>

<style>
table { margin-bottom: 1rem; }
</style>

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
- 不能 fine-tune

</div>

</div>

---

# 在 Claude Code 裡使用

```bash
# 1. 在 console.typesafe.ai 取得 key，寫進 ~/.zshrc 後重開終端機
export TYPESAFE_API_KEY=<your-key>

# 2. 安裝官方 plugin
/plugin marketplace add typesafe-ai/skills
/plugin install typesafe@typesafe-ai

# 3. 呼叫 skill，或直接說「用 Jev 判斷…」
/typesafe:typesafe-ai
```

---
routeAlias: part-agentic-cases
layout: center
---

# 使用情境

---

<div class="h-full flex flex-col justify-center">
<div class="grid grid-cols-3 gap-4">
  <FlowCard title="瀏覽器的下一步" :inputs="['DOM 狀態']" :outputs="['CLICK', 'TYPE', 'STOP']" :note="['頁面先轉成元素清單', 'Jev 挑動作和目標元素']" />
  <FlowCard title="自然語言 → 篩選條件" :inputs="['「上週未回覆」', '可用的篩選']" :outputs="['filter(…)']" :note="['每個參數各自判斷', '最沒把握的決定能否套用']" />
  <FlowCard title="表單自動填入" :inputs="['訂單文字']" pre="抽取器" :outputs="['直接填入', '使用者確認']" :note="['逐欄檢查有沒有抽錯', '可疑的欄位才標出來']" />
  <FlowCard title="站內搜尋重排序" :inputs="['搜尋字', '撈回的結果']" :outputs="['重排結果']" :note="['關鍵字或 embedding 先撈候選', 'Jev 依意思重排']" />
  <FlowCard title="按需載入 skill" :inputs="['這一輪的對話', 'skill 描述']" :outputs="['載入 skill']" :note="['只載入這一輪需要的', '不塞整份 skill 清單']" />
  <FlowCard title="Jevgrep 程式碼搜尋" :inputs="['自然語言問題', 'repo']" :outputs="['檔案與片段']" :note="['逐層判斷資料夾、檔案、宣告', '依程式在做什麼來搜尋']" />
</div>
</div>

<div class="absolute bottom-4 left-14 text-[10px] opacity-50">
  Reference：<a href="https://x.com/_avichawla/status/2104168233309974779" target="_blank">@_avichawla</a> · <a href="https://github.com/dzhng/jevgrep" target="_blank">dzhng/jevgrep</a>
</div>

---
routeAlias: part-github-cases
layout: center
---

# GitHub 上的使用案例

---

# browser-use/jev-ultrafast

<div class="text-sm opacity-60 -mt-2 mb-4">21.5k ★ · Browser Use · 2026.09.16</div>

<v-clicks>

- 目標：不看截圖，用最快、最便宜的方式操作網頁
- 每一步把 DOM 轉成一張有編號的 element table，當作 state
- 同一個 request 問完「做什麼」和「對誰做」

```yaml
operation:        choice(CLICK / TYPE_TEXT / SELECT / SCROLL / WAIT / DONE / BLOCKED)
click_target:     choice(元素編號…)   # 先一起問，用不到就丟掉
type_text_target: choice(元素編號…)
select_target:    choice(元素編號…)
```

- 只有要打字時才呼叫小型 LLM；Jev 的輸出不會直接變成 selector 或 JS
- Google Flights 蘇黎世 → 倫敦的任務跑完約 7.1 秒

</v-clicks>

---

# tamaratran/fast-jev-compaction

<div class="text-sm opacity-60 -mt-2 mb-4">7.2k ★ · 個人專案 · 2026.09.17</div>

<v-clicks>

- Claude Code 的 plugin，取代 context 滿了之後的 compaction
- 原本：把對話寫成摘要，細節會遺失
- 改成：只刪掉過時的 tool call 和 tool result，其他內容原文保留
- 每個 tool call 問兩題 Noul

```yaml
keep_call:   noul("這個 tool call 還需要留著嗎？")
keep_result: noul("這個 result 需要保留原文嗎？")
```

- 依機率決定保留、只留前 300 字，或整個刪掉
- 刪得不夠多時，退回 Claude Code 內建的摘要

</v-clicks>

---

# gargpratyush/jev-router

<div class="text-sm opacity-60 -mt-2 mb-4">500 ★ · 個人專案 · 2026.09.16</div>

<v-clicks>

- 目標：Claude Code / Codex 每一輪對話，自動挑夠用的最便宜模型
- 每輪只在第一個 request 問一次，一次問 4 題

```yaml
model:               choice(models…)  # 帳號可用的模型，每個選項寫 { what, signals, not_for }
task_complexity:     score(0–9)       # 任務整體多複雜
reasoning_required:  score(0–9)       # 需要多少推理
tool_complexity:     score(0–9)       # tool 操作多複雜
```

- 規則交給 code：使用者說「use opus」就照做；confidence < 0.3 不降級
- 對話超過 20k tokens 不降級，換模型會讓 prompt cache 失效
- Jev 失敗就維持目前的模型（fail-open），每次約 0.3 秒

</v-clicks>

---
routeAlias: part2-usage
layout: center
---

# 目前拿來做了什麼

---

# 工作日誌的類型標籤

<v-clicks>

- 用 Obsidian 記工作日誌，每張票有一份筆記，靠標籤做歸納整理
- 原本請 Claude Code 寫一支程式整理標籤，用正規表達式比對關鍵字
- 但關鍵字判斷不太精準，改用 Jev 判斷後，標籤準確很多

</v-clicks>

---

# 工作日誌：一張票問一題 Choice

```python {all|1-4|5-11|12}
state = {
    "ticket": {"key": "OCPD-32127", "title": "傳送到 /authorize 的附加參數"},
    "log_mentions": ["2026-09-29: 附加參數標題與新增參數按鈕間距改 8px"],
}
KIND_CRITERIA = {
    "修復": "修正既有功能的錯誤：原本應該正常運作卻壞掉…",
    "功能": "新增或擴充使用者看得到的能力：新頁面、新設定…",
    "樣式": "視覺與設計調整：色票、圖示、間距…，功能行為不變",
    # 重構、文件、維運…
    "不明": "素材不足以判斷這張票的性質",
}
# 實測：choice "樣式"，confidence 0.86（樣式 0.88、功能 0.11）
```

<v-clicks>

- 規則看到「新增」判成「功能」，Jev 判成「樣式」

</v-clicks>

---

# 工作日誌：結果

<v-clicks>

- 60 張票裡，37 張和關鍵字規則的結果不同
  - 9 張是規則原本掛不上的
  - 11 張 confidence 不到 0.6，留給人判斷

| 票 | 關鍵字規則 | Jev（實測） |
|---|---|---|
| 認證碼加上四位識別碼 | 修復（「修正 review 列出的…」） | 功能 0.98 |
| 更新 Omnichat Logo | 維運（「合進 release」） | 樣式 1.0 |
| /authorize 的附加參數 | 功能（「新增參數按鈕」） | 樣式 0.88 |

</v-clicks>

---

# Figma View plugin

<div class="border-l-4 border-gray-400 pl-4 py-2 my-4 opacity-80">
  <div class="text-sm opacity-60">出發點</div>
  <div>Figma MCP 額度不夠用，View seat 也沒有 Dev Mode</div>
</div>

<v-clicks>

- 畫布是 `<canvas>`，但圖層樹和 Properties 面板是 DOM，讀得到
- 難的是**找到那個圖層**：圖層樹很深，名稱常常是「Frame 48095617」
- 做法：**用 Jev 當導航**，一層一層走到目標圖層
- Claude Code plugin：`/figma-view:inspect`

</v-clicks>

<a v-after href="https://github.com/TomatoSoup0126/figma-view" target="_blank" class="block ml-6 mt-3 w-fit !border-none">
  <img src="/figma-view-github.png" alt="TomatoSoup0126/figma-view on GitHub" class="h-36 rounded shadow-lg" />
</a>

---
layout: two-cols
---

# Figma View：Jev 當導航

<v-clicks>

- 先從要求裡抓出圖層名稱（例如「輸入驗證碼-default」）去搜尋，Jev 從搜尋結果挑一個當起點
- 接著 code 一次只展開一層、列出直接子圖層，每層問兩題

```yaml
child: choice(c0 / c1 / … / NONE)   # 目標在哪個子圖層底下
here:  noul("目前這層就是要找的圖層嗎？")
```

- `here` ≥ 0.6 就停，`NONE` 就退回上一層換別的分支
- 「Frame 123」這種名稱看不出內容，先列出它底下的幾個子圖層當線索
- Jev 不寫搜尋字串、不產生 selector，只從 code 列出的選項裡挑

</v-clicks>

::right::

<div class="h-full flex items-center justify-center pl-6">
  <img src="/figma-layer-tree.png" alt="Figma 圖層樹：從輸入驗證碼-default 一路展開到文字圖層 A" class="max-h-[420px] rounded shadow-lg" />
</div>

---

# Figma View：實測

<div class="text-sm opacity-70 -mt-2 mb-2">要求：在「輸入驗證碼-default」畫面裡，選 ABCD 識別碼的「A」文字圖層</div>

| 目前這層 | Jev 選擇 | p |
|---|---|---|
| 搜尋「輸入驗證碼-default」（2 筆） | 輸入驗證碼-default | 0.92 |
| 輸入驗證碼-default | Group 18555 | 0.66 |
| Group 18555 | Frame 20109 | 0.97 |
| Frame 20109 | Frame 48095617 | 0.77 |
| Frame 48095617 | Frame 48096155 | 0.94 |
| Frame 48096155 | Frame 48096137 | 0.99 |
| Frame 48096137 | **A**（文字圖層） | 0.93 |

<v-clicks>

- 7 次 Jev 呼叫，每次 0.2–0.3 秒（含網路往返），合計約 1.6 秒
- 整趟約 41 秒，大部分花在載入檔案和 Figma 自己的搜尋

</v-clicks>

<style>
table { font-size: 0.85em; margin-bottom: 1rem; }
td, th { padding-top: 0.3em !important; padding-bottom: 0.3em !important; }
</style>

---

# Figma View：走錯可以退回來

<div class="text-sm opacity-70 -mt-2 mb-2">要求：在「驗證錯誤」Section 裡，選名稱是「驗證失敗」的 1440×700 畫面 frame</div>

| 目前這層 | Jev 選擇 | p |
|---|---|---|
| 搜尋「驗證失敗」（17 筆） | 驗證失敗 | 0.30 |
| 驗證失敗 | **NONE**（目標不在這底下） | 0.82 |
| 起點走不通，改選頁面 | 目前這個頁面 | 0.95 |
| 頁面最上層 | 登入 | 0.27 |
| 登入 | step 2-輸入驗證碼 | 0.78 |
| step 2-輸入驗證碼 | 驗證錯誤 | 0.46 |
| 驗證錯誤 | 驗證失敗 | 1.00 |
| 驗證失敗 | **HERE**（就是這層） | 0.85 |

<v-clicks>

- 同名的圖層有 17 個，第一次挑錯了，Jev 自己回答 NONE 退回來
- 8 次 Jev 呼叫合計約 1.8 秒，整趟約 26 秒

</v-clicks>

<style>
table { font-size: 0.85em; margin-bottom: 1rem; }
td, th { padding-top: 0.3em !important; padding-bottom: 0.3em !important; }
</style>

---

# Figma View：Jev 導航 vs Claude 自己操作

<div class="text-sm opacity-70 -mt-2 mb-2">同一個要求：選 ABCD 識別碼的「A」文字圖層</div>

| | Jev 導航 | Claude 自己操作 |
|---|---|---|
| 決策時間 | 7 步合計 1.5 秒（每步約 0.2 秒） | 13 輪合計約 55 秒（每輪約 4 秒） |
| 截圖 | 1 張 | 11 張 |

<div class="mt-4">

- 決策時間只算模型判斷下一步的時間，不含開檔、Figma 搜尋和等畫面載入

</div>

---

# Figma View：限制

<v-clicks>

- 這幾天跑了 20 次：選對 10 次、選錯 7 次、無法確認 3 次
- 要求裡有圖層名稱就準；只描述外觀容易選錯，因為 Jev 看不到畫面
- 但因為反應速度快、價格低，所以試誤成本低很多

</v-clicks>

---

# 這幾天花了多少錢

| 日期 | requests | input tokens | 費用 |
|---|--:|--:|--:|
| 2026.09.23 | 291 | 585,299 | $0.0246 |
| 2026.09.27 | 399 | 851,889 | $0.0358 |
| 2026.09.29 | 176 | 162,350 | $0.0068 |
| 2026.09.30 | 21 | 16,905 | $0.0007 |
| **合計** | **887** | **1,616,443** | **$0.068** |

<v-clicks class="mt-4">

- 以 $0.042 / 1M input tokens 計算，output 不收費
- 平均每個 request 約 1.8k tokens
- 這幾天的標籤、導航實驗全部加起來，不到 7 美分（約 NT$2）

</v-clicks>

---
routeAlias: part3-takeaways
layout: center
---

<v-clicks>

- Jev 的費用不是問題，真正的成本是把問題拆成選擇題
- code 掌控流程，Jev 只做選擇；規則就能判斷的，不需要用 Jev
- 適合要反覆做小判斷的地方：每一步約 0.2 秒，Claude 自己判斷要約 4 秒
- Jev 只看得到你給它的 state
- 用 confidence 分流，門檻拿自己的資料校準

</v-clicks>

<div v-click class="border-l-4 border-gray-400 pl-4 py-2 mt-12 text-[1.2em]">
  又快又便宜，讓原本覺得「交給 LLM 不划算」的操作，變得值得投入<br />
  <span class="text-sm opacity-60">就是開頭提到的 Jevons paradox</span>
</div>

<style>
li { margin: 0.9em 0; font-size: 1.2em; }
</style>

---
layout: center
class: text-center
---

<div class="flex flex-col items-center justify-center h-full">
  <h1>The end</h1>
  <PoweredBySlidev />
</div>
