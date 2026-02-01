import 'package:flutter/material.dart';
import 'package:sample_project/generated/i18n/app_localizations.dart';

/// アプリ設定のデータモデル
class AppSettings {
  /// 利用可能なワット数のリスト
  final List<int> wattageOptions;

  /// デフォルトの変換元ワット数
  final int defaultSourceWattage;

  /// デフォルトの変換先ワット数
  final int defaultTargetWattage;

  /// 広告が削除されているかどうか
  final bool adsRemoved;

  const AppSettings({
    required this.wattageOptions,
    required this.defaultSourceWattage,
    required this.defaultTargetWattage,
    required this.adsRemoved,
  });

  /// デフォルト設定
  factory AppSettings.defaultSettings() {
    return const AppSettings(
      wattageOptions: [500, 600, 800],
      defaultSourceWattage: 500,
      defaultTargetWattage: 600,
      adsRemoved: false,
    );
  }

  /// コピーして一部を変更
  AppSettings copyWith({
    List<int>? wattageOptions,
    int? defaultSourceWattage,
    int? defaultTargetWattage,
    bool? adsRemoved,
  }) {
    return AppSettings(
      wattageOptions: wattageOptions ?? this.wattageOptions,
      defaultSourceWattage: defaultSourceWattage ?? this.defaultSourceWattage,
      defaultTargetWattage: defaultTargetWattage ?? this.defaultTargetWattage,
      adsRemoved: adsRemoved ?? this.adsRemoved,
    );
  }

  /// JSONからの変換
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final wattageOptions =
        (json['wattageOptions'] as List<dynamic>?)
            ?.map((e) => e as int)
            .toList() ??
        [500, 600];
    return AppSettings(
      wattageOptions: wattageOptions,
      defaultSourceWattage:
          json['defaultSourceWattage'] as int? ?? wattageOptions.first,
      defaultTargetWattage:
          json['defaultTargetWattage'] as int? ??
          (wattageOptions.length > 1
              ? wattageOptions[1]
              : wattageOptions.first),
      adsRemoved: json['adsRemoved'] as bool? ?? false,
    );
  }

  /// JSONへの変換
  Map<String, dynamic> toJson() {
    return {
      'wattageOptions': wattageOptions,
      'defaultSourceWattage': defaultSourceWattage,
      'defaultTargetWattage': defaultTargetWattage,
      'adsRemoved': adsRemoved,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppSettings) return false;
    return _listEquals(wattageOptions, other.wattageOptions) &&
        defaultSourceWattage == other.defaultSourceWattage &&
        defaultTargetWattage == other.defaultTargetWattage &&
        adsRemoved == other.adsRemoved;
  }

  @override
  int get hashCode =>
      wattageOptions.hashCode ^
      defaultSourceWattage.hashCode ^
      defaultTargetWattage.hashCode ^
      adsRemoved.hashCode;

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// 時間を表すクラス
class CookingTime {
  final int minutes;
  final int seconds;

  const CookingTime({required this.minutes, required this.seconds});

  /// 秒数に変換
  int get totalSeconds => minutes * 60 + seconds;

  /// 秒数から作成
  factory CookingTime.fromSeconds(int totalSeconds) {
    return CookingTime(minutes: totalSeconds ~/ 60, seconds: totalSeconds % 60);
  }

  /// ローカライズされたフォーマット文字列
  String formatted(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (minutes > 0 && seconds > 0) {
      return l10n.timeFormatMinSec(minutes, seconds);
    } else if (minutes > 0) {
      return l10n.timeFormatMinOnly(minutes);
    } else {
      return l10n.timeFormatSecOnly(seconds);
    }
  }

  @override
  String toString() => '${minutes}m ${seconds}s';
}
