import 'package:flutter/material.dart';
import 'package:investor_app_flutter/src/config/di/injection_container.dart';
import 'package:investor_app_flutter/src/config/environment/environment.dart';

import 'investor_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(Environment.dev);
  await initApp();
}

