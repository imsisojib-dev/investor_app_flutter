import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/presentation/blocs/app_theme/bloc_app_theme.dart';
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

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<BlocAppTheme>(
          create: (BuildContext context) => BlocAppTheme(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

