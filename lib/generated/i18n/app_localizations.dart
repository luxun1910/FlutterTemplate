import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Wattage Converter'**
  String get appTitle;

  /// Title of the calculator screen
  ///
  /// In en, this message translates to:
  /// **'Wattage Converter'**
  String get calculatorTitle;

  /// Title of the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Section title for source wattage input
  ///
  /// In en, this message translates to:
  /// **'Before Conversion'**
  String get sourceSection;

  /// Section title for conversion result
  ///
  /// In en, this message translates to:
  /// **'Conversion Result'**
  String get resultSection;

  /// Label for wattage dropdown
  ///
  /// In en, this message translates to:
  /// **'Wattage'**
  String get wattageLabel;

  /// Label for target wattage dropdown
  ///
  /// In en, this message translates to:
  /// **'Target Wattage'**
  String get targetWattageLabel;

  /// Label for minutes input
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutesLabel;

  /// Label for seconds input
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get secondsLabel;

  /// Instruction text below the result
  ///
  /// In en, this message translates to:
  /// **'heat for this duration'**
  String get heatInstruction;

  /// Section title for wattage settings
  ///
  /// In en, this message translates to:
  /// **'Wattage Settings'**
  String get wattageSettingsSection;

  /// Section title for default settings
  ///
  /// In en, this message translates to:
  /// **'Default Settings'**
  String get defaultSettingsSection;

  /// Section title for ad settings
  ///
  /// In en, this message translates to:
  /// **'Ad Settings'**
  String get adSettingsSection;

  /// Section title for other settings
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get otherSection;

  /// Button text to add wattage
  ///
  /// In en, this message translates to:
  /// **'Add Wattage'**
  String get addWattage;

  /// Dialog title for adding wattage
  ///
  /// In en, this message translates to:
  /// **'Add Wattage'**
  String get addWattageDialog;

  /// Wattage unit
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get wattageUnit;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Add button text
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Confirm dialog title
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Confirmation message for deleting wattage
  ///
  /// In en, this message translates to:
  /// **'Delete {wattage}W?'**
  String deleteWattageConfirm(int wattage);

  /// Snackbar message when wattage is added
  ///
  /// In en, this message translates to:
  /// **'{wattage}W has been added'**
  String wattageAdded(int wattage);

  /// Snackbar message when wattage is deleted
  ///
  /// In en, this message translates to:
  /// **'{wattage}W has been deleted'**
  String wattageDeleted(int wattage);

  /// Snackbar message when deletion fails
  ///
  /// In en, this message translates to:
  /// **'Could not delete'**
  String get deleteFailed;

  /// Error message when trying to delete with less than 2 options
  ///
  /// In en, this message translates to:
  /// **'At least 2 wattage options are required'**
  String get minimumWattageError;

  /// Label for default source wattage selector
  ///
  /// In en, this message translates to:
  /// **'Default Source Wattage'**
  String get defaultSourceWattage;

  /// Label for default target wattage selector
  ///
  /// In en, this message translates to:
  /// **'Default Target Wattage'**
  String get defaultTargetWattage;

  /// Title for remove ads option
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get removeAds;

  /// Text shown when ads are already removed
  ///
  /// In en, this message translates to:
  /// **'Purchased'**
  String get purchased;

  /// Price description for removing ads
  ///
  /// In en, this message translates to:
  /// **'Remove ads for {price}'**
  String removeAdsPrice(String price);

  /// Purchase button text
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// Restore purchases button text
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// Snackbar when restore purchases succeeds
  ///
  /// In en, this message translates to:
  /// **'Purchases restored'**
  String get restoreSuccess;

  /// Snackbar when restore purchases fails
  ///
  /// In en, this message translates to:
  /// **'Failed to restore purchases'**
  String get restoreFailed;

  /// Privacy policy link text
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Error message when URL cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not open URL'**
  String get couldNotOpenUrl;

  /// Abbreviation for minutes
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minuteUnit;

  /// Abbreviation for seconds
  ///
  /// In en, this message translates to:
  /// **'sec'**
  String get secondUnit;

  /// Time format with minutes and seconds
  ///
  /// In en, this message translates to:
  /// **'{minutes}min {seconds}sec'**
  String timeFormatMinSec(int minutes, int seconds);

  /// Time format with only minutes
  ///
  /// In en, this message translates to:
  /// **'{minutes}min'**
  String timeFormatMinOnly(int minutes);

  /// Time format with only seconds
  ///
  /// In en, this message translates to:
  /// **'{seconds}sec'**
  String timeFormatSecOnly(int seconds);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
