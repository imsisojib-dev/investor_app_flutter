import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:investor_app_flutter/src/config/routes/routes.dart';
import 'package:investor_app_flutter/src/core/constants/asset_svgs.dart';
import 'package:investor_app_flutter/src/core/enums/e_bottomnavigation.dart';
import 'package:investor_app_flutter/src/shared/theme/app_theme_extension.dart';
import 'package:investor_app_flutter/src/features/discover/presentation/widgets/ongoing_campaign_card.dart';
import 'package:investor_app_flutter/src/shared/widgets/app_bottomnavigationbar.dart';

class ScreenDiscover extends StatelessWidget {
  const ScreenDiscover({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.appColors.scaffoldSecondaryBg,
      appBar: AppBar(
        title: Text('Ongoing Campaigns (08)'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: () {}, icon: SvgPicture.asset(AssetSvgs.filter))],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: const SizedBox(height: 8)),
          SliverList.separated(
            itemCount: 8,
            itemBuilder: (_, index) {
              return OngoingCampaignCard(
                showExtraProfit: index%2==1,
                onTap: (){
                  Navigator.pushNamed(context, Routes.campaignDetailsScreen,);
                },
              );
            },
            separatorBuilder: (_, index) {
              return const SizedBox(height: 8);
            },
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigationBar(state: EBottomNavigationBar.discover),
    );
  }
}
