import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intern/core/keys/keys.dart';

import '../../../core/log/app_log.dart';
import '../../../core/services/local_storage/secure_storage.dart';
import '../service/auth_requests.dart';

class AuthNotifier extends StateNotifier<AsyncValue<bool>> {
  AuthNotifier() : super(const AsyncValue.loading());
  final secureStorage = SecureStorage();
  final authRequests = AuthRequests();

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      var response = await authRequests.login(
        email: email,
        password: password,
      );
      if (response['success']) {
        await secureStorage.saveData(key: tokenKey, value: response['token']);
        state = const AsyncValue.data(true);
      } else {
        state = const AsyncValue.data(false);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void logout() async {
    try {
      await secureStorage.delete(key: tokenKey);
      AppLog.success('Logged out successfully');
      state = const AsyncValue.data(false);
    } catch (e, st) {
      AppLog.error('Error logging out: $e');
      state = AsyncValue.error(e, st);
    }
  }

  void clearCache() async {
    await authRequests.clearCache();
  }

  Future<void> setLoggedIn(bool value) async {
    state = AsyncData(value);
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<bool>>((ref) {
  return AuthNotifier();
});
