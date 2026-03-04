import 'package:flutter/material.dart';

class ScreenError extends StatelessWidget{
  const ScreenError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ERROR!'),
      ),
    );
  }
}