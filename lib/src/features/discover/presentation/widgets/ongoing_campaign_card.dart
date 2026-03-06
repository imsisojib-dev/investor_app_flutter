import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:investor_app_flutter/src/core/constants/asset_svgs.dart';
import 'package:investor_app_flutter/src/core/theme/app_theme_extension.dart';
import 'package:investor_app_flutter/src/shared/widgets/dotted_line.dart';

class OngoingCampaignCard extends StatelessWidget {
  final bool showExtraProfit;
  final VoidCallback onTap;

  const OngoingCampaignCard({super.key, required this.onTap, required this.showExtraProfit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: theme.appColors.white),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: GestureDetector(
            onTap: () {
              onTap.call();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40.r,
                      width: 40.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: theme.appColors.borderColor),
                      ),
                      child: ClipRRect(borderRadius: BorderRadius.circular(4), child: Image.asset('assets/pngs/dummy_company_logo.png')),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Shamolima Limited', style: theme.textTheme.titleSmall),
                        Text('Transport & Logistics', style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  'Serving 100+ industry renowned  corporate clients',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _highlightItem(theme, assetSvg: AssetSvgs.watch, title: '4 days left'),
                    _highlightItem(theme, assetSvg: AssetSvgs.calendar, title: '3 months'),
                    _highlightItem(theme, assetSvg: AssetSvgs.returnType, title: 'Fixed return'),
                    _highlightItem(theme, assetSvg: AssetSvgs.riskGrade, title: 'Risk Grade: B'),
                  ],
                ),
                SizedBox(height: 12.h),
                DottedLine(color: theme.appColors.borderColor, dotSize: 1.5),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: '15%', style: theme.textTheme.titleLarge),
                              TextSpan(
                                text: ' annualized',
                                style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        Text('Get up to 32,456 in 10 months', style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary)),
                      ],
                    ),

                    TextButton(
                      onPressed: () {
                        onTap.call();
                      },
                      child: Row(
                        children: [
                          Text('Details', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.secondary)),
                          Icon(Icons.arrow_right_alt, color: theme.colorScheme.secondary, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (showExtraProfit)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
              //decoration: BoxDecoration(color: theme.colorScheme.secondary),
              decoration: BoxDecoration(color: Color(0xff219EBC)),
              child: Text(
                'Extra profit activated. Expires soon!',
                style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textYellow,),
              ),
            ),
          ),
      ],
    );
  }

  Widget _highlightItem(ThemeData theme, {required String assetSvg, required String title}) {
    return Row(
      children: [
        SvgPicture.asset(assetSvg, height: 14.r),
        SizedBox(width: 4.w),
        Text(title, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.secondary)),
      ],
    );
  }
}
