import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:investor_app_flutter/src/config/assets/asset_svgs.dart';
import 'package:investor_app_flutter/src/config/routes/routes.dart';
import 'package:investor_app_flutter/src/core/enums/e_bottomnavigation.dart';
import 'package:investor_app_flutter/src/core/theme/app_colors.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final EBottomNavigationBar? state;

  const AppBottomNavigationBar({super.key, this.state});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  Widget _buildNavigationItem({required String title, required svgAsset, bool active = false, Function? onPressed}) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () {
        onPressed?.call();
      },
      icon: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAsset,
            height: 24,
            colorFilter: ColorFilter.mode(active ? AppColors.primary : AppColors.lightTextSecondary, BlendMode.srcIn),
          ),
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(color: active ? AppColors.primary : AppColors.lightTextSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.bottom + 10,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom, top: 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [BoxShadow(color: const Color(0xff000000).withOpacity(.05), spreadRadius: 5, blurRadius: 5, offset: const Offset(0, -1))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavigationItem(
            title: "Home",
            svgAsset: AssetSvgs.home,
            active: widget.state == EBottomNavigationBar.home,
            onPressed: () {
              if (widget.state == EBottomNavigationBar.home) return;

              Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
            },
          ),
          _buildNavigationItem(
            title: "Discover",
            svgAsset: AssetSvgs.discover,
            active: widget.state == EBottomNavigationBar.discover,
            onPressed: () {
              if (widget.state == EBottomNavigationBar.discover) return;
              Navigator.pushNamed(context, Routes.discoverScreen);
            },
          ),
          _buildNavigationItem(
            title: "Portfolio",
            svgAsset: AssetSvgs.portfolio,
            active: widget.state == EBottomNavigationBar.portfolio,
            onPressed: () {
              if (widget.state == EBottomNavigationBar.portfolio) return;
              Navigator.pushNamed(context, Routes.portfolioScreen);
            },
          ),
          _buildNavigationItem(
            title: "Account",
            svgAsset: AssetSvgs.profile,
            active: widget.state == EBottomNavigationBar.account,
            onPressed: () {
              if (widget.state == EBottomNavigationBar.account) return;

              Navigator.pushNamed(context, Routes.accountScreen);
            },
          ),
        ],
      ),
    );
  }
}
