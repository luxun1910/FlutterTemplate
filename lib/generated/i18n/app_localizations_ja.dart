// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'ワット数変換';

  @override
  String get calculatorTitle => 'ワット数変換';

  @override
  String get settingsTitle => '設定';

  @override
  String get sourceSection => '変換前';

  @override
  String get resultSection => '変換結果';

  @override
  String get wattageLabel => 'ワット数';

  @override
  String get targetWattageLabel => '変換先ワット数';

  @override
  String get minutesLabel => '分';

  @override
  String get secondsLabel => '秒';

  @override
  String get heatInstruction => '温めてください';

  @override
  String get wattageSettingsSection => 'ワット数設定';

  @override
  String get defaultSettingsSection => 'デフォルト設定';

  @override
  String get adSettingsSection => '広告設定';

  @override
  String get otherSection => 'その他';

  @override
  String get addWattage => 'ワット数を追加';

  @override
  String get addWattageDialog => 'ワット数を追加';

  @override
  String get wattageUnit => 'W';

  @override
  String get cancel => 'キャンセル';

  @override
  String get add => '追加';

  @override
  String get delete => '削除';

  @override
  String get confirm => '確認';

  @override
  String deleteWattageConfirm(int wattage) {
    return '${wattage}W を削除しますか？';
  }

  @override
  String wattageAdded(int wattage) {
    return '${wattage}W を追加しました';
  }

  @override
  String wattageDeleted(int wattage) {
    return '${wattage}W を削除しました';
  }

  @override
  String get deleteFailed => '削除できませんでした';

  @override
  String get minimumWattageError => '最低2種類のワット数が必要です';

  @override
  String get defaultSourceWattage => '変換元のデフォルト';

  @override
  String get defaultTargetWattage => '変換先のデフォルト';

  @override
  String get removeAds => '広告を削除';

  @override
  String get purchased => '購入済み';

  @override
  String removeAdsPrice(String price) {
    return '$price で広告を削除できます';
  }

  @override
  String get purchase => '購入';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get restoreSuccess => '購入を復元しました';

  @override
  String get restoreFailed => '購入の復元に失敗しました';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get couldNotOpenUrl => 'URLを開けませんでした';

  @override
  String get minuteUnit => '分';

  @override
  String get secondUnit => '秒';

  @override
  String timeFormatMinSec(int minutes, int seconds) {
    return '$minutes分$seconds秒';
  }

  @override
  String timeFormatMinOnly(int minutes) {
    return '$minutes分';
  }

  @override
  String timeFormatSecOnly(int seconds) {
    return '$seconds秒';
  }
}
