

資料大部分寫死在lib/core/mock/mock_database.dart，provider直接從這邊拿
以後改View $\leftarrow$ Provider$\leftarrow$ Service $\leftarrow$ Data。
還沒做掃描商品

---



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
    flutter clean
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
│   ├── mock/            # 放一些假的資料用的
│   ├── services/        # 儲存 (SharedPreferences)、認證服務
│   └── widgets/         # 全域共用 UI 元件
│
└── features/            # 核心功能模組
    ├── auth/            # 1. 登入與身份選擇 (家長/小孩)
    ├── family_group/    # 2. 家庭群組管理 (序號產生與加入)
    ├── profile/         # 3. 個人設定
    ├── task_board/      # 4. 任務系統 (任務發布、照片審核、上傳證明)
    └── wallet/          # 5. 錢包(餘額計算、利息派發、交易明細)


要跑的話
在main.dart run或是terminal輸入flutter run

chrome可以直接跑

android實體、模擬器都要裝Android Studio

iphone要跑需要mac
