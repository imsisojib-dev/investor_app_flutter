import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investor_app_flutter/src/config/extensions/widget_extensions.dart';
import 'package:investor_app_flutter/src/config/routes/routes.dart';
import 'package:investor_app_flutter/src/core/enums/e_bottomnavigation.dart';
import 'package:investor_app_flutter/src/features/campaign/presentation/widgets/campaign_card.dart';
import 'package:investor_app_flutter/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:investor_app_flutter/src/features/home/presentation/bloc/home_state.dart';
import 'package:investor_app_flutter/src/features/home/presentation/widgets/home_header_section.dart';
import 'package:investor_app_flutter/src/features/home/presentation/widgets/video_card_advanced.dart';
import 'package:investor_app_flutter/src/shared/theme/app_theme_extension.dart';
import 'package:investor_app_flutter/src/shared/widgets/app_bottomnavigationbar.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  SystemUiOverlayStyle? _originalStyle;

  @override
  void initState() {
    super.initState();
    // Save current style
    _originalStyle = SystemChrome.latestStyle;

    // Set custom style for this screen
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light));
  }

  @override
  void dispose() {
    // Restore original style when leaving the screen
    if (_originalStyle != null) {
      SystemChrome.setSystemUIOverlayStyle(_originalStyle!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Column(
        children: [
          HomeHeaderSection(),
          // Expanded(
          //   child: CustomScrollView(
          //     physics: const BouncingScrollPhysics(),
          //     slivers: [
          //       _featuredCampaigns(theme),
          //       _aboutUsSection(theme),
          //       //_newCampaignsSection(theme),
          //     ],
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigationBar(state: EBottomNavigationBar.home),
    );
  }

  Widget _featuredCampaigns(ThemeData theme) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (_, state) => state is HomeStateCampaigns || state is HomeStateCampaignsError || state is HomeStateCampaignsFetching,
        builder: (_, state) {
          switch (state) {
            case HomeStateCampaignsFetching():
              return const Center(child: CircularProgressIndicator());

            case HomeStateCampaigns():
              return Container(
                color: theme.appColors.white,
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Featured', style: theme.textTheme.titleMedium).padding(EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
                    CarouselSlider.builder(
                      itemCount: state.campaigns.length,
                      itemBuilder: (_, index, pageIndex) {
                        return CampaignCard(
                          viewmodel: state.campaigns[index],
                          onTap: () {
                            Navigator.pushNamed(context, Routes.campaignDetailsScreen);
                          },
                        );
                      },
                      options: CarouselOptions(enlargeCenterPage: false, autoPlay: true, height: 188.h),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            case HomeStateCampaignsError():
              return Container(child: Text(state.message));

            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget _aboutUsSection(ThemeData theme) {
    return SliverToBoxAdapter(
      child: Container(
        color: theme.appColors.white,
        margin: EdgeInsets.only(bottom: 8),
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
                  onTap: () {},
                );
              },
              options: CarouselOptions(enlargeCenterPage: false, autoPlay: false, height: 132.h, viewportFraction: 0.6, enableInfiniteScroll: true),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Widget _newCampaignsSection(ThemeData theme) {
  //   return SliverToBoxAdapter(
  //     child: Container(
  //       color: theme.appColors.white,
  //       margin: EdgeInsets.only(bottom: 16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('New Campaign', style: theme.textTheme.titleMedium).padding(EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
  //           CarouselSlider.builder(
  //             itemCount: 5,
  //             itemBuilder: (_, index, pageIndex) {
  //               return CampaignCard(
  //                 onTap: () {
  //                   Navigator.pushNamed(context, Routes.campaignDetailsScreen);
  //                 },
  //               );
  //             },
  //             options: CarouselOptions(enlargeCenterPage: false, autoPlay: true, height: 188.h),
  //           ),
  //           const SizedBox(height: 24),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
