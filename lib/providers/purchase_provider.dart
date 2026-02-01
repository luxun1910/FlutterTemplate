import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/purchase_service.dart';
import 'settings_provider.dart';

/// PurchaseServiceのプロバイダー
final purchaseServiceProvider = Provider<PurchaseService>((ref) {
  return PurchaseService();
});

/// 課金状態の管理
class PurchaseNotifier extends Notifier<PurchaseState> {
  late final PurchaseService _purchaseService;
  late final SettingsNotifier _settingsNotifier;

  @override
  PurchaseState build() {
    _purchaseService = ref.read(purchaseServiceProvider);
    _settingsNotifier = ref.read(settingsProvider.notifier);
    ref.onDispose(() => _purchaseService.dispose());
    return const PurchaseState();
  }

  /// 初期化
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);

    await _purchaseService.initialize(
      onPurchaseUpdated: (adsRemoved) {
        _settingsNotifier.setAdsRemoved(adsRemoved);
        state = state.copyWith(isPurchased: adsRemoved);
      },
    );

    state = state.copyWith(
      isAvailable: _purchaseService.isAvailable,
      isLoading: false,
    );
  }

  /// 広告削除を購入
  Future<void> purchaseRemoveAds() async {
    state = state.copyWith(isLoading: true);

    try {
      await _purchaseService.purchaseRemoveAds();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }

    state = state.copyWith(isLoading: false);
  }

  /// 購入を復元。広告削除が復元された場合に true、それ以外は false。
  Future<bool> restorePurchases() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final restored = await _purchaseService.restorePurchases();
      state = state.copyWith(isLoading: false);
      return restored;
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      return false;
    }
  }

  /// 広告削除を強制消費（Android のみ）。購入テスト再実行用。成功で true。
  Future<bool> forceConsumeRemoveAds() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final ok = await _purchaseService.forceConsumeRemoveAds();
      if (ok) {
        _settingsNotifier.setAdsRemoved(false);
        state = state.copyWith(isPurchased: false);
      }
      state = state.copyWith(isLoading: false);
      return ok;
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      return false;
    }
  }
}

/// 課金状態
class PurchaseState {
  final bool isAvailable;
  final bool isLoading;
  final bool isPurchased;
  final String? error;

  const PurchaseState({
    this.isAvailable = false,
    this.isLoading = false,
    this.isPurchased = false,
    this.error,
  });

  PurchaseState copyWith({
    bool? isAvailable,
    bool? isLoading,
    bool? isPurchased,
    String? error,
  }) {
    return PurchaseState(
      isAvailable: isAvailable ?? this.isAvailable,
      isLoading: isLoading ?? this.isLoading,
      isPurchased: isPurchased ?? this.isPurchased,
      error: error,
    );
  }
}

/// 課金状態プロバイダー
final purchaseProvider = NotifierProvider<PurchaseNotifier, PurchaseState>(
  PurchaseNotifier.new,
);
