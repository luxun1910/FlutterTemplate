# サンプルプロジェクト

サンプルプロジェクト概要です。

## セットアップ

### 1. 依存関係のインストール

```bash
flutter pub get
```

### 2. 環境変数ファイルの準備

開発時はそのまま使用できます（テスト用IDが設定済み）。

本番ビルド時は、環境変数ファイルを作成してください：

```bash
cp env/.env.production.example env/.env.production
```

`env/.env.production` を編集し、以下のIDを設定：

| 項目 | 取得先 |
|------|--------|
| `ADMOB_APP_ID_ANDROID` | [Google AdMob](https://admob.google.com/) |
| `ADMOB_APP_ID_IOS` | [Google AdMob](https://admob.google.com/) |
| `ADMOB_BANNER_ID_ANDROID` | AdMob 広告ユニット |
| `ADMOB_BANNER_ID_IOS` | AdMob 広告ユニット |
| `PRIVACY_POLICY_URL` | プライバシーポリシーのURL |

### 3. Google Play Storeアップロード準備

upload-keystore.jksをルートディレクトリに配置します。

\android直下にkey.propertiesを配置します。
書く内容は都度ググること。

## ビルド方法

```bash
# 開発
flutter run --dart-define-from-file=env/.env.development

# 本番 - Android（App Bundle / Play Store 用）
flutter build appbundle --dart-define-from-file=env/.env.production

# 本番 - iOS
flutter build ios --dart-define-from-file=env/.env.production
```

APK が必要な場合（Play Store 以外の配布など）:

```bash
flutter build apk --dart-define-from-file=env/.env.production
# 分割版: flutter build apk --split-per-abi --dart-define-from-file=env/.env.production
```

## 環境変数ファイル

| ファイル | 用途 | Git管理 |
|---------|------|---------|
| `env/.env.development` | 開発用（テストID） | ✅ コミット |
| `env/.env.production` | 本番用（実際のID） | ❌ gitignore |
| `env/.env.production.example` | 本番用テンプレート | ✅ コミット |

## プロジェクト構成

```
lib/
├── config/           # 設定ファイル（環境変数から読み込み）
│   ├── ad_config.dart
│   ├── app_config.dart
│   └── purchase_config.dart
├── models/           # データモデル
├── providers/        # 状態管理（Riverpod）
├── screens/          # 画面
├── services/         # サービス層
├── utils/            # ユーティリティ
└── widgets/          # ウィジェット

env/                  # 環境変数ファイル
scripts/              # ビルドスクリプト
```
