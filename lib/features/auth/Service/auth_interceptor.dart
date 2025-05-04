import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/keys/keys.dart';
import '../../../core/network/local/secure_storage.dart';
import '../provider/auth_notifier.dart';

class AuthInterceptor extends Interceptor {
  final secureStorage = SecureStorage();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await secureStorage.getData(key: tokenKey);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      ProviderScope.containerOf(rootNavigatorKey.currentContext!)
          .read(authProvider.notifier)
          .logout();
    }
    return handler.next(err);
  }
}
