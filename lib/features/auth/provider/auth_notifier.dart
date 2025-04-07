import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intern/core/util/storage_keys.dart';

import '../../../core/network/local/secure_storage.dart';
import '../requests/auth_requests.dart';

class AuthNotifier extends StateNotifier<AsyncValue<bool>> {
  AuthNotifier() : super(const AsyncValue.loading());
  final secureStorage = SecureStorage();

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final authRequests = AuthRequests();
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
    await secureStorage.delete(key: tokenKey);
    state = const AsyncValue.data(false);
  }

  Future<void> setLoggedIn(bool value) async {
    state = AsyncData(value);
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<bool>>((ref) {
  return AuthNotifier();
});
