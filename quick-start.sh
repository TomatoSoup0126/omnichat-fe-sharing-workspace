#!/bin/bash
# Slidev Workspace - 快速啟動腳本

# 顏色定義
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== FE-Sharing Collection ===${NC}"
echo ""

# 列出所有 FE-Sharing 專案（按年份）
echo -e "${GREEN}FE-Sharing 系列專案（按年份）：${NC}"
echo ""
for year in slides/202*/; do
    year_name=$(basename "$year")
    echo -e "${BLUE}  ▸ $year_name${NC}"
    i=1
    for dir in "$year"*/; do
        name=$(basename "$dir")
        title=$(grep -m 1 "^# " "$dir/slides.md" 2>/dev/null | sed 's/^# //' | head -c 50)
        echo -e "    ${YELLOW}$i.${NC} $name - $title"
        i=$((i+1))
    done
    echo ""
done

echo -e "${BLUE}常用指令：${NC}"
echo ""
echo "  ${GREEN}新增專案：${NC}"
echo "    pnpm new                          # 使用今天日期"
echo "    pnpm new 20250215                 # 指定日期"
echo "    pnpm new 20250215 \"標題\" \"描述\"      # 完整設定"
echo ""
echo "  ${GREEN}開發單一專案：${NC}"
echo "    cd slides/2024/sharing-20240215 && pnpm dev"
echo "    pnpm --filter sharing-20240215 dev  # 使用 workspace 指令"
echo ""
echo "  ${GREEN}建構單一專案：${NC}"
echo "    pnpm --filter sharing-20240215 build"
echo ""
echo "  ${GREEN}預覽所有專案：${NC}"
echo "    pnpm preview"
echo ""
echo "  ${GREEN}建構所有專案：${NC}"
echo "    pnpm build"
echo ""
