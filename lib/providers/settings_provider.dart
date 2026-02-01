import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/settings.dart';
import '../services/storage_service.dart';

/// StorageServiceのプロバイダー
final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError('StorageServiceは初期化時にオーバーライドされます');
});

/// 設定の状態管理
class SettingsNotifier extends Notifier<AppSettings> {
  late final StorageService _storageService;

  @override
  AppSettings build() {
    _storageService = ref.read(storageServiceProvider);
    return _storageService.loadSettings();
  }

  /// 広告削除状態を設定
  Future<void> setAdsRemoved(bool removed) async {
    final newSettings = await _storageService.setAdsRemoved(removed);
    state = newSettings;
  }

  /// 設定を再読み込み
  void reload() {
    state = _storageService.loadSettings();
  }
}

/// 設定プロバイダー
final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);

/// ワット数オプションのプロバイダー
final wattageOptionsProvider = Provider<List<int>>((ref) {
  return ref.watch(settingsProvider).wattageOptions;
});

/// デフォルト変換元ワット数のプロバイダー
final defaultSourceWattageProvider = Provider<int>((ref) {
  return ref.watch(settingsProvider).defaultSourceWattage;
});

/// デフォルト変換先ワット数のプロバイダー
final defaultTargetWattageProvider = Provider<int>((ref) {
  return ref.watch(settingsProvider).defaultTargetWattage;
});

/// 広告削除状態のプロバイダー
final adsRemovedProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).adsRemoved;
});
