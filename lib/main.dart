import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'investor_app.dart';

void main() async{
  await initApp();
}

Future<void> initApp()async {

  WidgetsFlutterBinding.ensureInitialized();

  //register font
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/outfit/OFL.txt');
    yield LicenseEntryWithLineBreaks(['assets/fonts/outfit'], license);
  });

  runApp(const MyApp());
}

