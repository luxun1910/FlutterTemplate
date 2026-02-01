/// アプリ内課金設定
///
/// ビルド時に環境変数ファイルから値を読み込みます：
///
/// 開発ビルド:
///   flutter run --dart-define-from-file=env/.env.development
///
/// 本番ビルド:
///   flutter build apk --dart-define-from-file=env/.env.production
class PurchaseConfig {
  PurchaseConfig._();

  // ============================================================
  // 環境変数から読み込み
  // ============================================================

  /// 広告削除の商品ID
  /// Google Play Console と App Store Connect で同じIDを設定してください
  static const String removeAdsProductId = String.fromEnvironment(
    'REMOVE_ADS_PRODUCT_ID',
    defaultValue: 'remove_ads',
  );

  /// 広告削除のデフォルト価格表示（ストアから取得できない場合のフォールバック）
  static const String removeAdsDefaultPrice = String.fromEnvironment(
    'REMOVE_ADS_DEFAULT_PRICE',
    defaultValue: '¥120',
  );
}
