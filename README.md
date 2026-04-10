# shadow_wallet

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


現在沒有全部
lib/
├── main.dart # 程式進入點 (初始化設定、Provider 綁定)
├── app.dart # MaterialApp 設定、全域主題設定
│
├── core/ # 全域共用模組 (跨功能都會用到的東西)
│ ├── constants/ # 靜態常數
│ │ ├── app_colors.dart # 品牌顏色、UI 配色
│ │ ├── app_theme.dart # 字體大小、按鈕預設樣式
│ │ └── api_urls.dart # (未來用) 後端 API 網址統一放這
│ │
│ ├── models/ # 全域資料模型
│ │ ├── user_model.dart # 包含 UserRole (parent/child)
│ │ └── group_model.dart # 包含家庭序號、經濟參數設定
│ │
│ ├── network/ # 網路請求底層 (對接後端用)
│ │ └── dio_client.dart # 封裝 Dio，處理 Token 和共用錯誤攔截
│ │
│ ├── router/ # 頁面導航管理 (建議用 go_router)
│ │ └── app_router.dart # 定義所有頁面的跳轉路徑
│ │
│ ├── services/ # 全域服務
│ │ ├── local_storage.dart # 封裝 SharedPreferences (存登入狀態)
│ │ └── auth_service.dart # 處理登入、註冊邏輯
│ │
│ ├── utils/ # 工具包 (純邏輯，不涉及 UI)
│ │ ├── currency_converter.dart # 真實貨幣與影子幣的「匯率換算公式」
│ │ └── date_formatter.dart # 將時間戳轉成「2023-10-25」格式
│ │
│ └── widgets/ # 全域共用 UI 元件 (確保設計風格統一)
│ ├── custom_button.dart # 共用的主按鈕
│ ├── custom_text_field.dart # 共用的輸入框
│ └── loading_overlay.dart # 載入中的轉圈圈動畫
│
└── features/ # 核心功能模組 (按業務邏輯拆分)
│
├── auth/ # 1.登入與身份選擇
│ ├── providers/ # 狀態管理 (例如：目前登入者是誰？)
│ └── views/ # 畫面 (login_view.dart, role_selection_view.dart)
│
├── family_group/ # 2.家庭群組管理
│ ├── providers/ # 處理產生序號、加入群組的邏輯
│ └── views/
│ ├── parent_settings_view.dart # 家長端：調整教育導向、經濟狀況
│ ├── child_join_view.dart # 小孩端：輸入序號加入家庭
│ └── members_list_view.dart # 共用：查看家庭成員
│
├── task_board/ # 3.任務系統 (最龐大的模組)
│ ├── models/
│ │ └── task_model.dart # 任務結構 (標題、獎勵、照片連結)
│ ├── providers/
│ │ └── task_provider.dart # 任務清單狀態、審核狀態管理
│ ├── services/
│ │ └── task_mock_service.dart # 開發初期用的假資料服務
│ └── views/
│ ├── widgets/ # 專屬小元件 (如：TaskCard)
│ ├── parent/
│ │ ├── create_task_view.dart # 發布新任務
│ │ └── review_task_view.dart # 審核小孩上傳的照片
│ └── child/
│ ├── child_task_list.dart # 瀏覽可領取的任務
│ └── submit_proof_view.dart# 上傳完成證明的畫面
│
├── wallet/ # 4.影子錢包與財商系統
│ ├── models/
│ │ └── transaction_model.dart # 交易明細 (賺取/花費/利息)
│ ├── providers/
│ │ └── wallet_provider.dart # 負責計算餘額、利息派發
│ └── views/
│ ├── parent/
│ │ └── adjust_balance_view.dart # 家長手動扣款或發獎勵
│ └── child/
│ ├── wallet_dashboard.dart # 顯示大大的餘額和利息
│ └── transaction_history.dart # 歷史帳本清單
│
└── scanner_store/ # 5.實體掃碼與兌換願望
├── models/
│ └── wishlist_model.dart # 願望清單商品
├── providers/
│ └── scanner_provider.dart # 處理相機掃描狀態
├── services/
│ └── barcode_api_service.dart # (未來) 串接真實條碼資料庫
└── views/
├── child_scanner_view.dart # 打開相機掃描標價
├── wish_checkout_view.dart # 送出購買請求
└── parent_approval_view.dart # 家長確認「已買實體物品給小孩」