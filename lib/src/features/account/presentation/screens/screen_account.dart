import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investor_app_flutter/src/config/extensions/widget_extensions.dart';
import 'package:investor_app_flutter/src/core/constants/asset_pngs.dart';
import 'package:investor_app_flutter/src/core/enums/e_bottomnavigation.dart';
import 'package:investor_app_flutter/src/core/theme/app_theme_extension.dart';
import 'package:investor_app_flutter/src/shared/widgets/app_bottomnavigationbar.dart';

class ScreenAccount extends StatelessWidget {
  const ScreenAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.appColors.scaffoldSecondaryBg,
      appBar: AppBar(title: Text('Profile'), centerTitle: false, automaticallyImplyLeading: false),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: Container(
              color: theme.appColors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                children: [
                  _buildTile(context, assetPng: AssetPngs.profile, title: 'Personal Details'),
                  Divider(color: theme.appColors.dividerColor, thickness: 1),
                  _buildTile(context, assetPng: AssetPngs.language, title: 'App Language'),
                  Divider(color: theme.appColors.dividerColor, thickness: 1),
                  _buildTile(
                    context,
                    assetPng: AssetPngs.security,
                    title: 'Account Security',
                    description: "Manage your account security settings, including Face ID, PIN configuration, and PIN reset options.",
                  ),
                  Divider(color: theme.appColors.dividerColor, thickness: 1),
                  _buildTile(
                    context,
                    assetPng: AssetPngs.protection,
                    title: 'Protection Pool',
                    description: "Not enrolled yet. A unique community-based Shariah-compliant fund.",
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Connect & Share',
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.appColors.textSecondary),
                ).padding(EdgeInsets.symmetric(horizontal: 24.w, vertical: 12)),
                Container(
                  color: theme.appColors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    children: [
                      _buildTile(context, assetPng: AssetPngs.review, title: 'Leave us a review'),
                      Divider(color: theme.appColors.dividerColor, thickness: 1),
                      _buildTile(context, assetPng: AssetPngs.faq, title: 'Ask a Question'),
                      Divider(color: theme.appColors.dividerColor, thickness: 1),
                      _buildTile(context, assetPng: AssetPngs.share, title: 'Share App Link with Friends & Family'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigationBar(state: EBottomNavigationBar.account),
    );
  }

  Widget _buildTile(BuildContext context, {required String assetPng, required String title, String? description, VoidCallback? onTap}) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset(assetPng, height: 16.r),
                SizedBox(width: 12.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                      if (description?.isNotEmpty ?? false) const SizedBox(height: 4),
                      if (description?.isNotEmpty ?? false)
                        Text(description!, style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Icon(Icons.arrow_forward_ios_sharp, color: theme.appColors.iconSecondary, size: 10),
        ],
      ).padding(EdgeInsets.symmetric(vertical: 8)),
    );
  }
}
