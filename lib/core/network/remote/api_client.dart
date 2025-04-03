import 'dart:async';

import 'package:dio/dio.dart';

import '../../../app_configs.dart';

class ApiClient {
  static late final Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfigs.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        receiveDataWhenStatusError: true,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<Response> postRequest(
      {String? token ,
      required String endpoint,
      required dynamic data }) async {
    try {
      if (token != null && token.isNotEmpty) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      } else
        {
          dio.options.headers['Authorization'] = 'Bearer';
        }
      final Response response = await dio.post(
        endpoint,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getRequest(
    {required String token,
      required String endpoint,
    Map<String, dynamic>? queryParams }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> putRequest(
    {required String token,
      required String endpoint,
    required dynamic data }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteRequest(
    {required String token,
      required String endpoint }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio.delete(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
