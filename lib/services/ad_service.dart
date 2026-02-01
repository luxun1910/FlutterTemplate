import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../config/ad_config.dart';
import '../utils/platform_utils.dart';

/// Google AdMobの広告サービス
class AdService {
  BannerAd? _bannerAd;
  bool _isInitialized = false;

  /// バナー広告ユニットID（AdConfigから取得）
  static String get bannerAdUnitId => AdConfig.bannerAdUnitId;

  /// AdMobを初期化
  Future<void> initialize() async {
    if (!PlatformUtils.isMobileAdSupported) return;
    if (_isInitialized) return;
    await MobileAds.instance.initialize();
    _isInitialized = true;
  }

  /// バナー広告を読み込み
  Future<BannerAd?> loadBannerAd({
    required Function(BannerAd) onAdLoaded,
    required Function(LoadAdError) onAdFailedToLoad,
  }) async {
    if (!PlatformUtils.isMobileAdSupported) return null;

    if (!_isInitialized) {
      await initialize();
    }

    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          onAdLoaded(ad as BannerAd);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          onAdFailedToLoad(error);
        },
        onAdOpened: (ad) {},
        onAdClosed: (ad) {},
      ),
    );

    await _bannerAd!.load();
    return _bannerAd;
  }

  /// バナー広告を破棄
  void disposeBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
  }
}
