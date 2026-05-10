import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investor_app_flutter/src/config/di/injection_container.dart';
import 'package:investor_app_flutter/src/config/extensions/widget_extensions.dart';
import 'package:investor_app_flutter/src/features/home/presentation/bloc/test_singleton.dart';
import 'package:investor_app_flutter/src/shared/theme/app_colors.dart';
import 'package:investor_app_flutter/src/shared/theme/app_theme_extension.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  Widget _buildHighlightItem(ThemeData theme, {required String value, required String title}) {
    return Column(
      children: [
        Text(value, style: theme.textTheme.titleLarge?.copyWith(color: theme.appColors.textYellow)),
        Text(title, style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.white)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 214.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: theme.colorScheme.primary),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getIt<TestSingleton>().name, style: theme.textTheme.titleLarge?.copyWith(color: theme.appColors.white)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_outlined, color: theme.appColors.textYellow),
                ),
              ],
            ).padding(EdgeInsets.symmetric(horizontal: 16.w)),

            //SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(color: AppColors.primarySecondary, borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildHighlightItem(theme, value: '5 M+', title: 'Fund raised'),
                  _buildHighlightItem(theme, value: '2 M+', title: 'Profit distributed'),
                  _buildHighlightItem(theme, value: '3 M+', title: 'Investments'),
                ],
              ),
            ),

            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('See Completed Campaigns', style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textYellow)),
                  Icon(Icons.arrow_right_alt, color: theme.appColors.textYellow),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
