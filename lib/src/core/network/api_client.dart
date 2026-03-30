import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

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
      throw Exception(e);
    }
  }

  @override
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> patch(String path, {dynamic data}) async {
    try {
      return await _dio.patch(path, data: data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      throw Exception(e);
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
      throw Exception(e);
    }
  }
}