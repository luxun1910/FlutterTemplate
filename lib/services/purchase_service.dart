import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../config/purchase_config.dart';

/// アプリ内課金サービス
class PurchaseService {
  static String get removeAdsProductId => PurchaseConfig.removeAdsProductId;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  bool _isAvailable = false;
  List<ProductDetails> _products = [];

  /// 復元結果を返すための Completer（復元中のみ使用）
  Completer<bool>? _restoreCompleter;
  static const _restoreTimeout = Duration(seconds: 3);

  /// 課金が利用可能かどうか
  bool get isAvailable => _isAvailable;

  /// 利用可能な商品
  List<ProductDetails> get products => _products;

  /// 初期化
  Future<void> initialize({
    required Function(bool adsRemoved) onPurchaseUpdated,
  }) async {
    _isAvailable = await _inAppPurchase.isAvailable();

    if (!_isAvailable) return;

    // 購入状態の監視
    _subscription = _inAppPurchase.purchaseStream.listen(
      (purchaseDetailsList) {
        _handlePurchaseUpdates(purchaseDetailsList, onPurchaseUpdated);
      },
      onError: (error) {
        // エラーハンドリング
      },
    );

    // 商品情報の取得
    await _loadProducts();
  }

  /// 商品情報を読み込み
  Future<void> _loadProducts() async {
    final Set<String> productIds = {removeAdsProductId};
    final response = await _inAppPurchase.queryProductDetails(productIds);

    if (response.notFoundIDs.isNotEmpty) {
      // 商品が見つからない場合のログ
    }

    _products = response.productDetails;
  }

  /// 購入状態の更新を処理
  void _handlePurchaseUpdates(
    List<PurchaseDetails> purchaseDetailsList,
    Function(bool) onPurchaseUpdated,
  ) {
    for (final purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // 購入処理中
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // エラー処理
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          // 購入完了または復元
          if (purchaseDetails.productID == removeAdsProductId) {
            onPurchaseUpdated(true);
            // 復元待ち中なら「広告削除が復元された」として成功で完了
            if (purchaseDetails.status == PurchaseStatus.restored &&
                _restoreCompleter != null &&
                !_restoreCompleter!.isCompleted) {
              _restoreCompleter!.complete(true);
            }
          }
        }

        // 購入完了の確認
        if (purchaseDetails.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  /// 広告削除を購入
  Future<bool> purchaseRemoveAds() async {
    if (!_isAvailable) return false;

    final product = _products.firstWhere(
      (p) => p.id == removeAdsProductId,
      orElse: () => throw Exception('Product not found'),
    );

    final purchaseParam = PurchaseParam(productDetails: product);
    return await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  /// 購入を復元。広告削除が実際に復元された場合に true、それ以外は false。
  Future<bool> restorePurchases() async {
    if (!_isAvailable) return false;

    _restoreCompleter = Completer<bool>();

    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      _restoreCompleter!.complete(false);
      rethrow;
    }

    // ストアの復元結果は purchaseStream で非同期に届くため、
    // タイムアウトまで待って「広告削除」が復元されたかで成否を判定する
    final result = await _restoreCompleter!.future
        .timeout(_restoreTimeout, onTimeout: () => false);
    _restoreCompleter = null;
    return result;
  }

  /// リソースを解放
  void dispose() {
    _subscription?.cancel();
  }
}
