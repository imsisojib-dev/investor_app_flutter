import 'package:flutter/material.dart';
import 'package:investor_app_flutter/src/core/enums/e_bottomnavigation.dart';
import 'package:investor_app_flutter/src/shared/widgets/app_bottomnavigationbar.dart';

class ScreenPortfolio extends StatelessWidget{
  const ScreenPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio'),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(
        state: EBottomNavigationBar.portfolio,
      ),
    );
  }
}