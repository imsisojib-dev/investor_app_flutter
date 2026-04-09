import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // normalize error — attach server message if present
    final serverMessage = err.response?.data?['message'] as String?;

    if (serverMessage != null) {
      err = err.copyWith(
        message: serverMessage,
      );
    }

    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // treat non-2xx that Dio didn't catch as errors
    if (response.statusCode != null &&
        (response.statusCode! < 200 || response.statusCode! >= 300)) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
      );
    }

    handler.next(response);
  }
}