import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../keys/keys.dart';
import '../../services/local_storage/secure_storage.dart';
import '../../../features/auth/provider/auth_notifier.dart';

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
          .read(authNotifierProvider.notifier)
          .logout();
    }
    return handler.next(err);
  }
}
