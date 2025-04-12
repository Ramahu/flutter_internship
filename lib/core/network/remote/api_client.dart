import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:intern/core/network/remote/cache_interceptor.dart';

import '../../../app_configs.dart';
import '../../../features/auth/Service/auth_interceptor.dart';

class ApiClient {
  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: AppConfigs.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 5),
      receiveDataWhenStatusError: true,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));

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
      CacheInterceptor().dioCacheInterceptor,
    ]);
  }

  late Dio dio;

  Future<Response> postRequest(
      {required String endpoint, required dynamic data}) async {
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
    Map<String, dynamic>? queryParams,
    bool isCached = false,
  }) async {
    try {
      final cacheOptions = isCached
          ? CacheInterceptor().options
          : const CacheOptions(policy: CachePolicy.noCache, store: null);

      Response response = await dio.get(
        endpoint,
        queryParameters: queryParams,
        options: cacheOptions.toOptions(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> putRequest(
      {required String endpoint, required dynamic data}) async {
    try {
      Response response = await dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteRequest({required String endpoint}) async {
    try {
      Response response = await dio.delete(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
