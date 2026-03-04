import 'package:flutter/material.dart';
import 'package:investor_app_flutter/core/data/enums/e_bottomnavigation.dart';
import 'package:investor_app_flutter/core/presentation/widgets/app_bottomnavigationbar.dart';

class ScreenAccount extends StatelessWidget{
  const ScreenAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(
        state: EBottomNavigationBar.account,
      ),
    );
  }
}