import 'package:flutter/material.dart';
import 'package:investor_app_flutter/core/data/enums/e_bottomnavigation.dart';
import 'package:investor_app_flutter/core/presentation/widgets/app_bottomnavigationbar.dart';

class ScreenDiscover extends StatelessWidget{
  const ScreenDiscover({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover'),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(
        state: EBottomNavigationBar.discover,
      ),
    );
  }
}