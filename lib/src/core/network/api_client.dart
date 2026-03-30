import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:investor_app_flutter/src/core/errors/exceptions.dart';

import 'dio_client.dart';

abstract class IApiClient {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Response> post(String path, {dynamic data});
  Future<Response> put(String path, {dynamic data});
  Future<Response> patch(String path, {dynamic data});
  Future<Response> delete(String path);
  Future<Response> upload(String path, FormData formData, {Function(int, int)? onSendProgress});
}

@LazySingleton(as: IApiClient)
class ApiClient implements IApiClient {
  final DioClient _dioClient;

  ApiClient(this._dioClient);

  Dio get _dio => _dioClient.dio;

  @override
  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<Response> patch(String path, {dynamic data}) async {
    try {
      return await _dio.patch(path, data: data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<Response> upload(
      String path,
      FormData formData, {
        Function(int, int)? onSendProgress,
      }) async {
    try {
      return await _dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  AppException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(message: 'Request timed out. Please try again.');

      case DioExceptionType.connectionError:
        return NetworkException(message: 'No internet connection.');

      case DioExceptionType.badResponse:
        return _handleStatusCode(e.response?.statusCode, e.response?.data);

      case DioExceptionType.cancel:
        return RequestCancelledException(message: 'Request was cancelled.');

      default:
        return UnknownException(message: 'Something went wrong. Please try again.');
    }
  }

  AppException _handleStatusCode(int? statusCode, dynamic data) {
    final message = data?['message'] as String? ?? 'Unknown error occurred';

    switch (statusCode) {
      case 400: return BadRequestException(message: message);
      case 401: return UnauthorizedException(message: message);
      case 403: return ForbiddenException(message: message);
      case 404: return NotFoundException(message: message);
      case 409: return ConflictException(message: message);
      case 422: return ValidationException(message: message, errors: data?['errors']);
      case 429: return TooManyRequestsException(message: message);
      case 500:
      case 502:
      case 503: return ServerException(message: message);
      default:  return UnknownException(message: message);
    }
  }

}