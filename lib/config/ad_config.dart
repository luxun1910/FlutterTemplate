import 'dart:io';
import 'package:flutter/foundation.dart';

/// AdMob広告設定
///
/// ビルド時に環境変数ファイルから値を読み込みます：
///
/// 開発ビルド:
///   flutter run --dart-define-from-file=env/.env.development
///
/// 本番ビルド:
///   flutter build apk --dart-define-from-file=env/.env.production
///   flutter build ios --dart-define-from-file=env/.env.production
class AdConfig {
  AdConfig._();

  // ============================================================
  // 環境変数から読み込み（--dart-define-from-file で設定）
  // ============================================================

  /// Android用 AdMobアプリID
  static const String admobAppIdAndroid = String.fromEnvironment(
    'ADMOB_APP_ID_ANDROID',
    defaultValue: 'ca-app-pub-3940256099942544~3347511713', // テスト用フォールバック
  );

  /// iOS用 AdMobアプリID
  static const String admobAppIdIOS = String.fromEnvironment(
    'ADMOB_APP_ID_IOS',
    defaultValue: 'ca-app-pub-3940256099942544~1458002511', // テスト用フォールバック
  );

  /// Android用 バナー広告ユニットID
  static const String admobBannerIdAndroid = String.fromEnvironment(
    'ADMOB_BANNER_ID_ANDROID',
    defaultValue: 'ca-app-pub-3940256099942544/6300978111', // テスト用フォールバック
  );

  /// iOS用 バナー広告ユニットID
  static const String admobBannerIdIOS = String.fromEnvironment(
    'ADMOB_BANNER_ID_IOS',
    defaultValue: 'ca-app-pub-3940256099942544/2934735716', // テスト用フォールバック
  );

  // ============================================================
  // テストデバイスID（オプション）
  // ============================================================

  /// テストデバイスのID一覧
  /// 本番IDを使用していても、ここに登録されたデバイスではテスト広告が表示されます
  static const List<String> testDeviceIds = [
    // 'YOUR_DEVICE_ID_HERE',
  ];

  // ============================================================
  // 取得用メソッド
  // ============================================================

  /// 現在のプラットフォームのアプリID
  static String get appId {
    if (_isNotMobile) return '';
    return Platform.isAndroid ? admobAppIdAndroid : admobAppIdIOS;
  }

  /// 現在のプラットフォームのバナー広告ユニットID
  static String get bannerAdUnitId {
    if (_isNotMobile) {
      throw UnsupportedError('Ads not supported on this platform');
    }
    return Platform.isAndroid ? admobBannerIdAndroid : admobBannerIdIOS;
  }

  /// テスト用IDを使用しているかどうか
  static bool get isUsingTestIds {
    return admobAppIdAndroid.contains('3940256099942544') ||
        admobAppIdIOS.contains('3940256099942544');
  }

  static bool get _isNotMobile {
    if (kIsWeb) return true;
    try {
      return !Platform.isAndroid && !Platform.isIOS;
    } catch (e) {
      return true;
    }
  }
}
