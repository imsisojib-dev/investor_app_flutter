import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @LazySingleton()
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  Dio get dio => Dio();
}