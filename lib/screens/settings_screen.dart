import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../generated/i18n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/settings_provider.dart';
import '../providers/purchase_provider.dart';
import '../widgets/banner_ad_widget.dart';
import '../config/app_config.dart';
import '../config/purchase_config.dart';

/// 設定画面
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final TextEditingController _wattageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 課金サービスの初期化
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(purchaseProvider.notifier).initialize();
    });
  }

  @override
  void dispose() {
    _wattageController.dispose();
    super.dispose();
  }

  Future<void> _restorePurchases(AppLocalizations l10n) async {
    final success = await ref
        .read(purchaseProvider.notifier)
        .restorePurchases();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? l10n.restoreSuccess : l10n.restoreFailed),
        ),
      );
    }
  }

  Future<void> _launchPrivacyPolicy() async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse(AppConfig.privacyPolicyUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.couldNotOpenUrl)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final purchaseState = ref.watch(purchaseProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // ここに設定セクションを追加
                  const SizedBox(height: 32),
                  // 広告設定セクション
                  _SectionHeader(title: l10n.adSettingsSection),
                  const SizedBox(height: 12),
                  _buildAdRemovalSection(
                    settings.adsRemoved,
                    purchaseState,
                    l10n,
                  ),
                  const SizedBox(height: 32),

                  // その他セクション
                  _SectionHeader(title: l10n.otherSection),
                  const SizedBox(height: 12),
                  _buildPrivacyPolicyButton(l10n),
                ],
              ),
            ),
            // バナー広告
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildAdRemovalSection(
    bool adsRemoved,
    PurchaseState purchaseState,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.removeAds,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      adsRemoved
                          ? l10n.purchased
                          : l10n.removeAdsPrice(
                              PurchaseConfig.removeAdsDefaultPrice,
                            ),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (!adsRemoved)
                ElevatedButton(
                  onPressed: purchaseState.isLoading
                      ? null
                      : () => ref
                            .read(purchaseProvider.notifier)
                            .purchaseRemoveAds(),
                  child: purchaseState.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.purchase),
                )
              else
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
          if (!adsRemoved) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: purchaseState.isLoading
                  ? null
                  : () => _restorePurchases(l10n),
              child: Text(l10n.restorePurchases),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicyButton(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(l10n.privacyPolicy),
        trailing: const Icon(Icons.open_in_new),
        onTap: _launchPrivacyPolicy,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
