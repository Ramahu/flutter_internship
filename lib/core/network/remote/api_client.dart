import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../app_configs.dart';
import '../../../features/auth/requests/auth_interceptor.dart';

class ApiClient {

  ApiClient() {
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
        )
    );

    dio.interceptors.addAll([
      AuthInterceptor(),
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90,
          enabled: kDebugMode,
          ),
    ]);
  }

  late Dio dio;


  Future<Response> postRequest({
    required String endpoint,
    required dynamic data
  }) async {
    try {
      final Response response = await dio.post(
        endpoint,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParams
  }) async {
    try {
      Response response = await dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> putRequest({
    required String endpoint,
    required dynamic data
  }) async {
    try {
      Response response = await dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteRequest({
    required String endpoint
  }) async {
    try {
      Response response = await dio.delete(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
