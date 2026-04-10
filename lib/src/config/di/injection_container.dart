import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:investor_app_flutter/src/config/di/injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)

Future<void> configureDependencies(String env) async{
  getIt.init(environment: env);
}