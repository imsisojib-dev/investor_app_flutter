import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investor_app_flutter/src/config/di/injection_container.dart';
import 'package:investor_app_flutter/src/config/routes/routes.dart';
import 'package:investor_app_flutter/src/features/account/presentation/screens/screen_account.dart';
import 'package:investor_app_flutter/src/features/campaign/presentation/screen_campaign_details.dart';
import 'package:investor_app_flutter/src/features/discover/presentation/screens/screen_discover.dart';
import 'package:investor_app_flutter/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:investor_app_flutter/src/features/home/presentation/bloc/home_event.dart';
import 'package:investor_app_flutter/src/features/home/presentation/screens/screen_home.dart';
import 'package:investor_app_flutter/src/features/portfolio/presentation/screens/screen_portfolio.dart';
import 'package:investor_app_flutter/src/shared/screens/screen_error.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  ///HOME
  static final Handler _homeScreenHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) {
      return BlocProvider(
        create: (_)=> HomeBloc(getIt())..add(HomeEventInitial()),
        child: const ScreenHome(),
      );
    },
  );

  ///DISCOVER
  static final Handler _discoverScreenHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) {
      return const ScreenDiscover();
    },
  );

  ///PORTFOLIO
  static final Handler _portfolioScreenHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) {
      return const ScreenPortfolio();
    },
  );

  ///ACCOUNT
  static final Handler _accountScreenHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) {
      return const ScreenAccount();
    },
  );

  ///CAMPAIGN
  static final Handler _campaignDetailsScreenHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) {
      return const ScreenCampaignDetails();
    },
  );

  ///ERROR
  static final Handler _notFoundHandler = Handler(handlerFunc: (context, parameters) => const ScreenError());

  void setupRouter() {
    router.notFoundHandler = _notFoundHandler;

    //main-nav flow
    router.define(Routes.homeScreen, handler: _homeScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.discoverScreen, handler: _discoverScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.portfolioScreen, handler: _portfolioScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.accountScreen, handler: _accountScreenHandler, transitionType: TransitionType.fadeIn);

    router.define(Routes.campaignDetailsScreen, handler: _campaignDetailsScreenHandler, transitionType: TransitionType.cupertino);
  }
}
