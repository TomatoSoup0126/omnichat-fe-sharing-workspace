#!/bin/bash

# 快速建立新的 FE-Sharing slide 專案
# 使用方式: ./new-slide.sh [YYYYMMDD] [title] [info]
# 範例: ./new-slide.sh 20250215 "React Hooks Advanced" "Deep dive into React Hooks patterns"

set -e

# 顏色定義
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 取得日期參數，預設為今天
if [ -z "$1" ]; then
    DATE=$(date +%Y%m%d)
    echo -e "${YELLOW}未提供日期，使用今天: $DATE${NC}"
else
    DATE=$1
fi

# 驗證日期格式
if ! [[ $DATE =~ ^[0-9]{8}$ ]]; then
    echo "❌ 日期格式錯誤！請使用 YYYYMMDD 格式（例如：20250215）"
    exit 1
fi

# 解析年份
YEAR=${DATE:0:4}
MONTH=${DATE:4:2}
DAY=${DATE:6:2}
FORMATTED_DATE="$YEAR.$MONTH.$DAY"

# 取得標題和描述
TITLE=${2:-"FE Sharing $FORMATTED_DATE"}
INFO=${3:-"Frontend engineering sharing session"}

# 專案名稱和路徑
PROJECT_NAME="sharing-$DATE"
PROJECT_PATH="slides/$YEAR/$PROJECT_NAME"

# 檢查專案是否已存在
if [ -d "$PROJECT_PATH" ]; then
    echo "❌ 專案已存在: $PROJECT_PATH"
    exit 1
fi

# 建立目錄結構
echo -e "${BLUE}📁 建立專案目錄...${NC}"
mkdir -p "$PROJECT_PATH/public"

# 建立 package.json
echo -e "${BLUE}📦 建立 package.json...${NC}"
cat > "$PROJECT_PATH/package.json" << EOF
{
  "name": "$PROJECT_NAME",
  "type": "module",
  "private": true,
  "scripts": {
    "dev": "slidev --open",
    "build": "slidev build",
    "export": "slidev export"
  },
  "dependencies": {
    "@slidev/cli": "^0.49.16",
    "@slidev/theme-default": "latest"
  }
}
EOF

# 建立 slides.md
echo -e "${BLUE}📝 建立 slides.md...${NC}"
cat > "$PROJECT_PATH/slides.md" << EOF
---
theme: default
background: https://images.unsplash.com/photo-1517694712202-14dd9538aa97
title: $TITLE
author: Jonathan Tang
date: $FORMATTED_DATE
info: $INFO
class: text-center
highlighter: shiki
drawings:
  persist: false
transition: slide-left
mdc: true
monaco: true
---

# $TITLE

$INFO

<div class="pt-12">
  <span @click="\$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    Press Space for next page <carbon:arrow-right class="inline"/>
  </span>
</div>

---

# 議程

- 📝 主題一
- 🎨 主題二
- 🚀 主題三

---

# 主題一

您的內容...

---

# 總結

- 重點一
- 重點二
- 重點三

---
layout: center
class: text-center
---

# Thank You!

Questions?
EOF

echo ""
echo -e "${GREEN}✅ 專案建立成功！${NC}"
echo ""
echo -e "${BLUE}專案資訊:${NC}"
echo "  路徑: $PROJECT_PATH"
echo "  名稱: $PROJECT_NAME"
echo "  標題: $TITLE"
echo "  日期: $FORMATTED_DATE"
echo ""
echo -e "${BLUE}下一步:${NC}"
echo "  1. cd $PROJECT_PATH"
echo "  2. pnpm install"
echo "  3. pnpm dev"
echo ""
echo -e "${YELLOW}或使用快速啟動:${NC}"
echo "  pnpm --filter $PROJECT_NAME dev"
