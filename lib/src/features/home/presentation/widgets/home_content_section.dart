import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investor_app_flutter/src/config/extensions/widget_extensions.dart';
import 'package:investor_app_flutter/src/config/routes/routes.dart';
import 'package:investor_app_flutter/src/shared/theme/app_theme_extension.dart';
import 'package:investor_app_flutter/src/features/campaign/presentation/widgets/campaign_card.dart';
import 'package:investor_app_flutter/src/features/home/presentation/widgets/video_card_advanced.dart';

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
                    return CampaignCard(
                      onTap: (){
                        Navigator.pushNamed(context, Routes.campaignDetailsScreen);
                      },
                    );
                  },
                  options: CarouselOptions(enlargeCenterPage: false, autoPlay: true, height: 188.h),
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
                    return VideoCardAdvanced(
                      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                      thumbnailUrl: 'https://picsum.photos/400/225?random=1',
                      title: 'Know about the Risk Grade',
                      onTap: () {

                      },
                    );
                  },
                  options: CarouselOptions(
                    enlargeCenterPage: false,
                    autoPlay: false,
                    height: 132.h,
                    viewportFraction: 0.6,
                    enableInfiniteScroll: true,
                  ),
                ),
                const SizedBox(height: 16,),
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
                    return CampaignCard(
                      onTap: (){
                        Navigator.pushNamed(context, Routes.campaignDetailsScreen);
                      },
                    );
                  },
                  options: CarouselOptions(enlargeCenterPage: false, autoPlay: true, height: 188.h),
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
