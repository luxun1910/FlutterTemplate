/// アプリ全体の設定
///
/// ビルド時に環境変数ファイルから値を読み込みます：
///
/// 開発ビルド:
///   flutter run --dart-define-from-file=env/.env.development
///
/// 本番ビルド:
///   flutter build apk --dart-define-from-file=env/.env.production
class AppConfig {
  AppConfig._();

  // ============================================================
  // 環境変数から読み込み
  // ============================================================

  /// プライバシーポリシーのURL
  static const String privacyPolicyUrl = String.fromEnvironment(
    'PRIVACY_POLICY_URL',
    defaultValue: 'https://example.com/privacy-policy',
  );

  /// サポートメールアドレス
  static const String supportEmail = String.fromEnvironment(
    'SUPPORT_EMAIL',
    defaultValue: 'support@example.com',
  );

  // ============================================================
  // 固定値
  // ============================================================

  /// 利用規約のURL（オプション）
  static const String termsOfServiceUrl = 'https://example.com/terms';
}
