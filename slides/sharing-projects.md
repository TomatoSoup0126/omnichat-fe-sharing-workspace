# Sharing Projects

這些是從 omnichat-fe-sharing 專案搬移過來的簡報專案。

## 專案列表

| 專案名稱 | 標題 | Slides 行數 | 來源 |
|---------|------|------------|------|
| sharing-20231123 | Sharing 2023.11.23 | 333 lines | git commit 0f670cb |
| sharing-20240215 | Sharing 2024.02.15 | 274 lines | sharing-20240215 |
| sharing-20240502 | Sharing 2024.05.02 | 545 lines | shiring-20240502 (原 branch 拼字) |
| sharing-20240711 | Sharing 2024.07.11 | 523 lines | sharing-20240711 |
| sharing-20240927 | Sharing 2024.09.26 | 1034 lines | sharing-20240927 |
| sharing-20250102 | Sharing 2025.01.02 | 638 lines | sharing-20250102 |
| sharing-20250327 | Sharing 2025.03.27 | 441 lines | sharing-20250327 |
| sharing-20250626 | Sharing 2025.06.26 | 250 lines | sharing-20250626 |
| sharing-20250911 | Sharing 2025.09.11 | 338 lines | sharing-20250911 |
| sharing-20251127 | Sharing 2025.11.27 | 325 lines | sharing-20251127 |

## 使用方式

### 開發單一專案
```bash
cd slides/2024/sharing-20240215
pnpm dev
```

### 建構單一專案
```bash
cd slides/2024/sharing-20240215
pnpm build
```

### 使用 workspace 指令

預覽所有專案：
```bash
pnpm preview
```

建構所有專案：
```bash
pnpm build
```

## 專案結構

每個專案包含：
- `slides.md` - 主要簡報內容
- `package.json` - 專案設定與依賴
- `components/` - 自訂元件（如果有）
- `public/` - 靜態資源（圖片等）
- `pages/` - 額外頁面（如果有）
