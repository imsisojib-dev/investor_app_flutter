import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investor_app_flutter/src/config/extensions/widget_extensions.dart';
import 'package:investor_app_flutter/src/core/theme/app_theme_extension.dart';

class CampaignCard extends StatelessWidget {
  final VoidCallback onTap;
  const CampaignCard({super.key, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: (){
        onTap.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.appColors.white,
          boxShadow: [BoxShadow(blurRadius: 10, spreadRadius: 0, color: theme.appColors.shadowColor, offset: Offset(0, 4))],
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.only(
          left: 8.w,
          right: 8.w,
          bottom: 4.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: Image.asset(
                'assets/pngs/dummy_transport_company.png',
                height: 124.h,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shamolima Ltd.', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(child: Icon(Icons.location_on, color: const Color(0xff00BA63), size: 14)),
                          WidgetSpan(child: const SizedBox(width: 4)),
                          TextSpan(
                            text: 'Dhaka',
                            style: theme.textTheme.bodySmall?.copyWith(fontSize: 10, color: theme.appColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).padding(EdgeInsets.symmetric(horizontal: 8.w)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '18%',
                            style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: ' annualized',
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary),
                          ),
                        ],
                      ),
                    ),

                    CircleAvatar(
                      radius: 2,
                      backgroundColor: Color(0xffD9D9D9),
                    ),

                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '6',
                            style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: ' months',
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary),
                          ),
                        ],
                      ),
                    ),

                    CircleAvatar(
                      radius: 2,
                      backgroundColor: Color(0xffD9D9D9),
                    ),

                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Fixed return',
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).padding(EdgeInsets.symmetric(horizontal: 8.w, vertical: 4)),
                const SizedBox(height: 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
