import 'package:injectable/injectable.dart';
import 'package:investor_app_flutter/src/config/environment/environment.dart' as env;


@Singleton(env: [env.Environment.prod])
class TestSingleton {
  String name = 'Hi gys';
}