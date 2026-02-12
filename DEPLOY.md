# 部署指南

本專案支援多種部署平台，每個平台都有預先配置好的設定檔。

## 🚀 Netlify 部署（推薦）

### 優點
- ✅ 自動偵測配置（`netlify.toml`）
- ✅ 快速部署
- ✅ 內建 CDN
- ✅ 自動 HTTPS
- ✅ 預覽部署（Pull Request）

### 部署步驟

1. **將代碼推送到 GitHub**
   ```bash
   git remote add origin https://github.com/your-username/your-repo.git
   git push -u origin main
   ```

2. **連接 Netlify**
   - 前往 [Netlify](https://app.netlify.com)
   - 點擊 "Add new site" > "Import an existing project"
   - 選擇 GitHub 並授權
   - 選擇你的 repository

3. **自動配置**
   Netlify 會自動讀取 `netlify.toml` 配置：
   - Build command: `pnpm install && pnpm build`
   - Publish directory: `dist`
   - Node version: 20

4. **部署**
   - 點擊 "Deploy site"
   - 等待建置完成（約 3-5 分鐘）
   - 你的網站會得到一個 `*.netlify.app` 網址

### 自訂網域

1. 在 Netlify 專案設定中選擇 "Domain management"
2. 點擊 "Add custom domain"
3. 依照指示設定 DNS 記錄

---

## 📦 GitHub Pages 部署

### 優點
- ✅ 完全免費
- ✅ 與 GitHub 整合
- ✅ 自動化 CI/CD

### 部署步驟

1. **啟用 GitHub Actions**
   - 前往你的 repository Settings > Pages
   - Source 選擇 "GitHub Actions"

2. **推送程式碼**
   ```bash
   git push origin main
   ```

3. **自動部署**
   - GitHub Actions 會自動執行 `.github/workflows/deploy.yml`
   - 建置完成後會自動部署到 GitHub Pages
   - 網址格式：`https://your-username.github.io/your-repo/`

### 設定 base path

如果你的 repository 名稱不是 `slidev-workspace-starter`，需要修改 `slidev-workspace.yaml`：

```yaml
base: /your-repo-name/
```

---

## ▲ Vercel 部署

### 優點
- ✅ 零配置部署
- ✅ 極快的 CDN
- ✅ 自動 HTTPS
- ✅ 預覽部署

### 部署步驟

1. **推送到 GitHub**
   ```bash
   git push origin main
   ```

2. **連接 Vercel**
   - 前往 [Vercel](https://vercel.com)
   - 點擊 "New Project"
   - Import 你的 GitHub repository

3. **配置**
   - Framework Preset: 選擇 "Other"
   - Build Command: `pnpm build`
   - Output Directory: `dist`
   - Install Command: `pnpm install`

4. **部署**
   - 點擊 "Deploy"
   - 完成後會得到 `*.vercel.app` 網址

---

## 🔧 本地測試建置

在部署前，建議先在本地測試建置：

```bash
# 安裝依賴
pnpm install

# 建置所有專案
pnpm build

# 預覽建置結果
npx serve dist
```

然後開啟 http://localhost:3000 查看。

---

## 📊 建置時間估算

- **10 個專案全部建置**：約 3-5 分鐘
- **單一專案建置**：約 20-30 秒

### 優化建置時間

如果只想部署特定專案：

```bash
# 只建置特定專案
pnpm build sharing-20240927 sharing-20250102
```

---

## ⚠️ 常見問題

### Q: Netlify 建置失敗，顯示 "too many open files"

**A:** 這通常不會發生，因為 Netlify 的建置環境有足夠的文件描述符限制。如果發生，可以：

1. 分批建置專案
2. 聯絡 Netlify 支援提高限制

### Q: GitHub Pages 部署後無法載入資源

**A:** 檢查 `slidev-workspace.yaml` 中的 `base` 設定是否正確：

```yaml
base: /your-repo-name/  # 必須與 repository 名稱一致
```

### Q: 部署後圖片無法顯示

**A:** 確認：
1. 圖片檔案在 `public/` 目錄下
2. 路徑使用 `/` 開頭（例如：`/20240927/image.png`）
3. 檔案名稱大小寫正確

### Q: 建置時記憶體不足

**A:** 嘗試：
1. 在 `netlify.toml` 增加 NODE_OPTIONS：
   ```toml
   [build.environment]
     NODE_OPTIONS = "--max-old-space-size=4096"
   ```

---

## 🎯 推薦配置

- **個人專案/快速原型**：Netlify
- **開源專案**：GitHub Pages
- **商業專案**：Vercel 或 Netlify Pro
- **需要預覽部署**：Netlify 或 Vercel

---

## 📝 更新部署

所有平台都支援自動部署：

```bash
# 修改內容後
git add .
git commit -m "update slides"
git push

# 平台會自動偵測更新並重新部署
```

---

## 🔗 有用的連結

- [Netlify 文檔](https://docs.netlify.com/)
- [GitHub Pages 文檔](https://docs.github.com/en/pages)
- [Vercel 文檔](https://vercel.com/docs)
- [Slidev Workspace](https://github.com/leochiu-a/slidev-workspace)
