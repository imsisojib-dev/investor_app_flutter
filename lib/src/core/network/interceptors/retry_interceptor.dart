import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:investor_app_flutter/src/core/network/network_info.dart';

@lazySingleton
class RetryInterceptor extends Interceptor {
  final INetworkInfo _networkInfo;

  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  // only retry these status codes
  static const List<int> _retryStatusCodes = [408, 500, 502, 503, 504];

  RetryInterceptor(this._networkInfo);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final attempt = err.requestOptions.extra['retryCount'] as int? ?? 0;

    final shouldRetry = _shouldRetry(err) && attempt < _maxRetries;

    if (!shouldRetry) return handler.next(err);

    final isOnline = await _networkInfo.isConnected;
    if (!isOnline) return handler.next(err);

    await Future.delayed(_retryDelay * (attempt + 1));  // exponential backoff

    err.requestOptions.extra['retryCount'] = attempt + 1;

    try {
      final dio = Dio(BaseOptions(baseUrl: err.requestOptions.baseUrl));
      final response = await dio.fetch(err.requestOptions);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  bool _shouldRetry(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout) return true;
    if (err.type == DioExceptionType.receiveTimeout) return true;
    if (err.type == DioExceptionType.connectionError) return true;

    final statusCode = err.response?.statusCode;
    if (statusCode != null && _retryStatusCodes.contains(statusCode)) return true;

    return false;
  }
}