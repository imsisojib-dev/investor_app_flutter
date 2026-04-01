import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:investor_app_flutter/src/core/network/interceptors/retry_interceptor.dart';

@lazySingleton
class DioClient {
  late final Dio dio;

  DioClient(
      String baseUrl,
      RetryInterceptor retryInterceptor,
      ) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      retryInterceptor
    ]);
  }
}
