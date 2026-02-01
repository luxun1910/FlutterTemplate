import 'dart:io';
import 'package:flutter/foundation.dart';

/// プラットフォーム判定の共通ユーティリティ
///
/// 広告（AdMob）など、Android/iOS のみでサポートする機能の判定に使用します。
abstract final class PlatformUtils {
  PlatformUtils._();

  /// 広告がサポートされているプラットフォーム（Android / iOS）かどうか
  static bool get isMobileAdSupported {
    if (kIsWeb) return false;
    try {
      return Platform.isAndroid || Platform.isIOS;
    } catch (_) {
      return false;
    }
  }
}
