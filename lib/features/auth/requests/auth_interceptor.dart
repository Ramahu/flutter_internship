import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/local/secure_storage.dart';
import '../../../core/router/app_router.dart';

class AuthInterceptor extends Interceptor {
  final secureStorage = SecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler)
  async {

    String? token = await secureStorage.getData(key: 'token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    if (err.response?.statusCode == 401) {
      rootNavigatorKey.currentContext?.go('/login');
      log('Unauthorized: Token may be expired.');
    }
    return super.onError(err, handler);
  }
}
