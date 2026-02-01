import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ad_service.dart';
import 'settings_provider.dart';

/// AdServiceのプロバイダー
final adServiceProvider = Provider<AdService>((ref) {
  return AdService();
});

/// 広告状態の管理
class AdNotifier extends Notifier<AdState> {
  late final AdService _adService;

  @override
  AdState build() {
    _adService = ref.read(adServiceProvider);
    ref.onDispose(() => _adService.disposeBannerAd());
    return const AdState();
  }

  /// バナー広告を読み込み
  Future<void> loadBannerAd() async {
    // 広告が削除されている場合は読み込まない（購入状態は都度取得）
    final adsRemoved = ref.read(adsRemovedProvider);
    if (adsRemoved) {
      state = state.copyWith(shouldShowAd: false);
      return;
    }

    state = state.copyWith(isLoading: true);

    await _adService.loadBannerAd(
      onAdLoaded: (ad) {
        state = state.copyWith(
          bannerAd: ad,
          isLoading: false,
          shouldShowAd: true,
        );
      },
      onAdFailedToLoad: (error) {
        state = state.copyWith(
          isLoading: false,
          error: error.message,
          shouldShowAd: false,
        );
      },
    );
  }

  /// バナー広告を破棄
  void disposeBannerAd() {
    _adService.disposeBannerAd();
    state = const AdState();
  }
}

/// 広告状態
class AdState {
  final BannerAd? bannerAd;
  final bool isLoading;
  final bool shouldShowAd;
  final String? error;

  const AdState({
    this.bannerAd,
    this.isLoading = false,
    this.shouldShowAd = true,
    this.error,
  });

  AdState copyWith({
    BannerAd? bannerAd,
    bool? isLoading,
    bool? shouldShowAd,
    String? error,
  }) {
    return AdState(
      bannerAd: bannerAd ?? this.bannerAd,
      isLoading: isLoading ?? this.isLoading,
      shouldShowAd: shouldShowAd ?? this.shouldShowAd,
      error: error,
    );
  }
}

/// 広告状態プロバイダー
final adProvider = NotifierProvider<AdNotifier, AdState>(AdNotifier.new);

/// 広告を表示すべきかどうかのプロバイダー
final shouldShowAdProvider = Provider<bool>((ref) {
  final adsRemoved = ref.watch(adsRemovedProvider);
  final adState = ref.watch(adProvider);
  return !adsRemoved && adState.shouldShowAd;
});
