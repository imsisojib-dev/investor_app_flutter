import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investor_app_flutter/src/config/extensions/widget_extensions.dart';
import 'package:investor_app_flutter/src/core/theme/app_theme_extension.dart';
import 'package:investor_app_flutter/src/features/home/presentation/widgets/campaign_card.dart';

class HomeContentSection extends StatelessWidget {
  const HomeContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: theme.appColors.white,
            margin: EdgeInsets.only(
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Featured', style: theme.textTheme.titleMedium).padding(EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
                CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (_, index, pageIndex) {
                    return CampaignCard();
                  },
                  options: CarouselOptions(enlargeCenterPage: false, autoPlay: true, height: 185.h),
                ),
                const SizedBox(height: 24,),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            color: theme.appColors.white,
            margin: EdgeInsets.only(
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Learn About Us', style: theme.textTheme.titleMedium).padding(EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
                CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (_, index, pageIndex) {
                    return CampaignCard();
                  },
                  options: CarouselOptions(enlargeCenterPage: false, autoPlay: false, height: 185.h),
                ),
                const SizedBox(height: 24,),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            color: theme.appColors.white,
            margin: EdgeInsets.only(
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New Campaign', style: theme.textTheme.titleMedium).padding(EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
                CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (_, index, pageIndex) {
                    return CampaignCard();
                  },
                  options: CarouselOptions(enlargeCenterPage: false, autoPlay: true, height: 185.h),
                ),
                const SizedBox(height: 24,),
              ],
            ),
          ),
        ),


      ],
    );
  }
}
