import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:investor_app_flutter/src/core/enums/e_bottomnavigation.dart';
import 'package:investor_app_flutter/src/features/home/presentation/widgets/home_content_section.dart';
import 'package:investor_app_flutter/src/features/home/presentation/widgets/home_header_section.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
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
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Column(
        children: [
          HomeHeaderSection(),
          Expanded(
            child: HomeContentSection(),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigationBar(state: EBottomNavigationBar.home),
    );
  }
}
