import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/enums/auth_status.dart';
import '../requests/auth_requests.dart';


class AuthNotifier extends StateNotifier<AuthStatus> {
  AuthNotifier() : super(AuthStatus.unauthenticated);
  final secureStorage = const FlutterSecureStorage();

  void login(String email, String password) async{
      final authRequests = AuthRequests();
      var response = await authRequests.login(
        email: email,
        password: password,
      );
      if (response['success']) {
        state = AuthStatus.authenticated;
        log('${response['message']}');

        await secureStorage.write(key: 'token', value: response['token']);

      } else {
        state = AuthStatus.unauthenticated;
        log('${response['message']}');
      }
  }

  void logout() async{
    state = AuthStatus.unauthenticated;
  }

  bool isLoggedIn() {
    return state == AuthStatus.authenticated;
  }

}

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier();
});
