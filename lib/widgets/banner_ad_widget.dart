import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sample_project/utils/platform_utils.dart';
import '../providers/ad_provider.dart';
import '../config/ad_config.dart';

/// バナー広告ウィジェット
/// 各インスタンスが独自のBannerAdを管理し、画面遷移時のエラーを防ぐ
class BannerAdWidget extends ConsumerStatefulWidget {
  const BannerAdWidget({super.key});

  @override
  ConsumerState<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends ConsumerState<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoading = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    if (PlatformUtils.isMobileAdSupported) {
      _loadAd();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _bannerAd?.dispose();
    _bannerAd = null;
    super.dispose();
  }

  Future<void> _loadAd() async {
    if (_isDisposed) return;

    setState(() {
      _isLoading = true;
    });

    _bannerAd = BannerAd(
      adUnitId: AdConfig.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!_isDisposed && mounted) {
            setState(() {
              _bannerAd = ad as BannerAd;
              _isLoading = false;
            });
          } else {
            ad.dispose();
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (!_isDisposed && mounted) {
            setState(() {
              _bannerAd = null;
              _isLoading = false;
            });
          }
        },
      ),
    );

    await _bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    // 広告がサポートされていないプラットフォームでは何も表示しない
    if (!PlatformUtils.isMobileAdSupported) {
      return const SizedBox.shrink();
    }

    final shouldShowAd = ref.watch(shouldShowAdProvider);

    if (!shouldShowAd) {
      return const SizedBox.shrink();
    }

    if (_bannerAd == null || _isLoading) {
      // 広告読み込み中のプレースホルダー
      return Container(height: 50, color: Colors.transparent);
    }

    return Container(
      alignment: Alignment.center,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
