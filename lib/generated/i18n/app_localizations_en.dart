// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Wattage Converter';

  @override
  String get calculatorTitle => 'Wattage Converter';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get sourceSection => 'Before Conversion';

  @override
  String get resultSection => 'Conversion Result';

  @override
  String get wattageLabel => 'Wattage';

  @override
  String get targetWattageLabel => 'Target Wattage';

  @override
  String get minutesLabel => 'Minutes';

  @override
  String get secondsLabel => 'Seconds';

  @override
  String get heatInstruction => 'heat for this duration';

  @override
  String get wattageSettingsSection => 'Wattage Settings';

  @override
  String get defaultSettingsSection => 'Default Settings';

  @override
  String get adSettingsSection => 'Ad Settings';

  @override
  String get otherSection => 'Other';

  @override
  String get addWattage => 'Add Wattage';

  @override
  String get addWattageDialog => 'Add Wattage';

  @override
  String get wattageUnit => 'W';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String deleteWattageConfirm(int wattage) {
    return 'Delete ${wattage}W?';
  }

  @override
  String wattageAdded(int wattage) {
    return '${wattage}W has been added';
  }

  @override
  String wattageDeleted(int wattage) {
    return '${wattage}W has been deleted';
  }

  @override
  String get deleteFailed => 'Could not delete';

  @override
  String get minimumWattageError => 'At least 2 wattage options are required';

  @override
  String get defaultSourceWattage => 'Default Source Wattage';

  @override
  String get defaultTargetWattage => 'Default Target Wattage';

  @override
  String get removeAds => 'Remove Ads';

  @override
  String get purchased => 'Purchased';

  @override
  String removeAdsPrice(String price) {
    return 'Remove ads for $price';
  }

  @override
  String get purchase => 'Purchase';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get restoreSuccess => 'Purchases restored';

  @override
  String get restoreFailed => 'Failed to restore purchases';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get couldNotOpenUrl => 'Could not open URL';

  @override
  String get minuteUnit => 'min';

  @override
  String get secondUnit => 'sec';

  @override
  String timeFormatMinSec(int minutes, int seconds) {
    return '${minutes}min ${seconds}sec';
  }

  @override
  String timeFormatMinOnly(int minutes) {
    return '${minutes}min';
  }

  @override
  String timeFormatSecOnly(int seconds) {
    return '${seconds}sec';
  }
}
