import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings.dart';

/// SharedPreferencesを使用した設定の永続化サービス
class StorageService {
  static const String _settingsKey = 'app_settings';
  
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  /// SharedPreferencesのインスタンスを取得してServiceを作成
  static Future<StorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  /// 設定を保存
  Future<bool> saveSettings(AppSettings settings) async {
    final jsonString = jsonEncode(settings.toJson());
    return await _prefs.setString(_settingsKey, jsonString);
  }

  /// 設定を読み込み
  AppSettings loadSettings() {
    final jsonString = _prefs.getString(_settingsKey);
    if (jsonString == null) {
      return AppSettings.defaultSettings();
    }
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return AppSettings.fromJson(json);
    } catch (e) {
      return AppSettings.defaultSettings();
    }
  }

  /// ワット数を追加
  Future<AppSettings> addWattage(int wattage) async {
    final settings = loadSettings();
    if (settings.wattageOptions.contains(wattage)) {
      return settings; // 既に存在する場合は何もしない
    }
    final newOptions = [...settings.wattageOptions, wattage]..sort();
    final newSettings = settings.copyWith(wattageOptions: newOptions);
    await saveSettings(newSettings);
    return newSettings;
  }

  /// ワット数を削除（最低2種類必要）
  Future<AppSettings?> removeWattage(int wattage) async {
    final settings = loadSettings();
    if (settings.wattageOptions.length <= 2) {
      return null; // 最低2種類必要
    }
    final newOptions = settings.wattageOptions.where((w) => w != wattage).toList();
    
    // デフォルト値の調整
    int newDefaultSource = settings.defaultSourceWattage;
    int newDefaultTarget = settings.defaultTargetWattage;
    
    if (!newOptions.contains(newDefaultSource)) {
      newDefaultSource = newOptions.first;
    }
    if (!newOptions.contains(newDefaultTarget)) {
      newDefaultTarget = newOptions.length > 1 ? newOptions[1] : newOptions.first;
    }
    
    final newSettings = settings.copyWith(
      wattageOptions: newOptions,
      defaultSourceWattage: newDefaultSource,
      defaultTargetWattage: newDefaultTarget,
    );
    await saveSettings(newSettings);
    return newSettings;
  }

  /// デフォルトの変換元ワット数を設定
  Future<AppSettings> setDefaultSourceWattage(int wattage) async {
    final settings = loadSettings();
    if (!settings.wattageOptions.contains(wattage)) {
      return settings;
    }
    final newSettings = settings.copyWith(defaultSourceWattage: wattage);
    await saveSettings(newSettings);
    return newSettings;
  }

  /// デフォルトの変換先ワット数を設定
  Future<AppSettings> setDefaultTargetWattage(int wattage) async {
    final settings = loadSettings();
    if (!settings.wattageOptions.contains(wattage)) {
      return settings;
    }
    final newSettings = settings.copyWith(defaultTargetWattage: wattage);
    await saveSettings(newSettings);
    return newSettings;
  }

  /// 広告削除状態を設定
  Future<AppSettings> setAdsRemoved(bool removed) async {
    final settings = loadSettings();
    final newSettings = settings.copyWith(adsRemoved: removed);
    await saveSettings(newSettings);
    return newSettings;
  }
}
