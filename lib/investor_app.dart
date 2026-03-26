import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investor_app_flutter/src/config/routes/navigation_observer.dart';
import 'package:investor_app_flutter/src/config/routes/router_helper.dart';
import 'package:investor_app_flutter/src/config/routes/routes.dart';
import 'package:investor_app_flutter/src/core/constants/app_constants.dart';
import 'package:investor_app_flutter/src/core/theme/bloc/bloc_app_theme.dart';
import 'package:investor_app_flutter/src/core/theme/app_theme.dart';

class InvestorApp extends StatefulWidget {
  const InvestorApp({super.key});

  @override
  State<InvestorApp> createState() => _InvestorAppState();
}

class _InvestorAppState extends State<InvestorApp> {
  @override
  void initState() {
    super.initState();
    RouterHelper().setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, app) {
        return BlocBuilder<BlocAppTheme, StateAppTheme>(
          builder: (_, themeState) {
            return MaterialApp(
              //navigatorKey: navigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return ScrollConfiguration(
                  //Removes the whole common's scroll glow
                  behavior: AppBehavior(),
                  child: child!,
                );
              },
              title: AppConstants.appName,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeState.themeMode,
              initialRoute: Routes.homeScreen,
              onGenerateRoute: RouterHelper.router.generator,
              navigatorObservers: [AppNavObserver()],
            );
          },
        );
      },
    );
  }
}

//to avoid scroll glow in whole common
class AppBehavior extends ScrollBehavior {
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
