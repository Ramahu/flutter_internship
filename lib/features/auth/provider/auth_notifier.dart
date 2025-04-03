import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/auth_status.dart';
import '../../../core/network/local/cache_helper.dart';
import '../requests/auth_requests.dart';


class AuthNotifier extends StateNotifier<AuthStatus> {
  AuthNotifier() : super(AuthStatus.unauthenticated);

  void login(String email, String password) async{
      final authRequests = AuthRequests();
      var response = await authRequests.login(
        email: email,
        password: password,
      );
      if (response['success']) {
        state = AuthStatus.authenticated;
        log('✅ Login Successful ');
        // await CacheHelper.saveData(key: 'isLoggedIn',
        //     value: true);
      } else {
        state = AuthStatus.unauthenticated;
        log('❌ Login Failed: ${response['message']}');
      }
  }

  void logout() async{
    await CacheHelper.saveData(key: 'isLoggedIn',
        value: false);
    state = AuthStatus.unauthenticated;
  }

  bool isLoggedIn() {
    // bool isLoggedIn = CacheHelper.getData(key: 'isLoggedIn') ?? false;
    // return isLoggedIn;
    return state == AuthStatus.authenticated;
  }

}

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier();
});
