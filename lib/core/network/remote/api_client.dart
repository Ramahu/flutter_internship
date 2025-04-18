// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../app_configs.dart';
import '../../../features/auth/service/auth_interceptor.dart';

final cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.forceCache,
    priority: CachePriority.high,
    maxStale: const Duration(days: 7),
    hitCacheOnErrorCodes: [401, 403, 404, 422],
    cipher: null,
    allowPostMethod: false,
    hitCacheOnNetworkFailure: true,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder);

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
      DioCacheInterceptor(options: cacheOptions),
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

  Future<void> clearCache() async {
    try {
      await cacheOptions.store?.clean(); // Clears all cache
      print('Cache cleared successfully');
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }

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

  /// Merges custom options with cache settings based on `isCached`
  Options _mergeOptions(Options? options, bool isCached) {
    // Define the caching policy based on the `isCached` flag
    final cacheOption = cacheOptions
        .copyWith(
          // Enable/disable caching
          policy: isCached ? CachePolicy.forceCache : CachePolicy.noCache,
          // Ensures cache duration remains as default
          maxStale: null,
        )
        .toOptions();

    // Merge user-defined options with the cache options
    return options?.copyWith(
          extra: {
            ...?options.extra,
            ...?cacheOption.extra
          }, // Merge extra fields
          headers: {
            ...?options.headers,
            ...?cacheOption.headers
          }, // Merge headers
        ) ??
        cacheOption; // If no custom options, return cache settings
  }

  Future<Response> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    bool isCached = false,
    Options? options,
  }) async {
    try {
      final effectiveOptions = _mergeOptions(options, true);
      Response response = await dio.get(
        endpoint,
        queryParameters: queryParams,
        options: effectiveOptions,
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
