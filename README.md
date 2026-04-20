# Shadow Wallet

>**資料大部分寫死在lib/core/mock/mock_database.dart，provider直接從這邊拿

---

## 🛠 環境安裝與開發設定

### 1. 下載 Flutter SDK
* 請前往 [Flutter 官網](https://docs.flutter.dev/install/manual) 下載 SDK。
* 請解壓縮至如 `C:\flutter_sdk\` 等路徑，不要放在 `C:\Program Files\`。

### 2. 設定環境變數
* 搜尋「環境變數」 -> 系統變數 -> `Path` -> 編輯 -> 新增。
* 加入路徑：`C:\你的路徑\flutter\bin`。

### 3. VS Code 設定
* 內建擴充功能搜尋並安裝 `Flutter` (會自動安裝 Dart 套件)。
* **依賴管理：** * Flutter 不需虛擬環境，使用 `pubspec.yaml` 管理套件。
  * 修改 `pubspec.yaml` 後，在 Terminal 輸入：
    ```bash
    flutter pub get
    ```
  * 套件會存在本地全域快取，並透過 `pubspec.lock` 確保版本一致。

---

```text
lib/
├── main.dart            # 程式進入點 (初始化、Provider 綁定)
├── app.dart             # MaterialApp 設定、全域主題設定
│
├── core/                # 全域共用模組
│   ├── models/          # UserRole, GroupModel 等基礎資料模型
│   ├── router/          # AppRouter 頁面導航管理
│   ├── services/        # 儲存 (SharedPreferences)、認證服務
│   ├── utils/           # 貨幣轉換、日期格式化工具
│   └── widgets/         # 全域共用 UI 元件 (按鈕、輸入框、Loading)
│
└── features/            # 核心功能模組
    ├── auth/            # 1. 登入與身份選擇 (家長/小孩)
    ├── family_group/    # 2. 家庭群組管理 (序號產生與加入)
    ├── task_board/      # 3. 任務系統 (任務發布、照片審核、上傳證明)
    ├── wallet/          # 4. 財商系統 (餘額計算、利息派發、交易明細)
    └── scanner_store/   # 5. 掃碼兌換 (實體掃碼標價、願望清單審核)