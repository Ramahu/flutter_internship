import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/auth_status.dart';
import '../../../core/network/local/secure_storage.dart';
import '../requests/auth_requests.dart';


class AuthNotifier extends StateNotifier<AuthStatus> {
  AuthNotifier() : super(AuthStatus.unauthenticated);
  final secureStorage = SecureStorage();

  void login(String email, String password) async{
      final authRequests = AuthRequests();
      var response = await authRequests.login(
        email: email,
        password: password,
      );
      if (response['success']) {
        state = AuthStatus.authenticated;

        await secureStorage.saveData(key: 'token',
            value: response['token']);

      } else {
        state = AuthStatus.unauthenticated;
      }
  }

  void logout() {
    state = AuthStatus.unauthenticated;
  }

  bool isAuth() {
    return state == AuthStatus.authenticated;
  }

}

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier();
});
