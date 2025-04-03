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
        print('✅ Login Successful: ${response['data']}');
      } else {
        print('❌ Login Failed: ${response['message']}');
      }
      // await CacheHelper.saveData(key: 'isLoggedIn',
      //     value: true);
      state = AuthStatus.authenticated;

  }

  void logout() async{
    await CacheHelper.saveData(key: 'isLoggedIn',
        value: false);
    state = AuthStatus.unauthenticated;
  }

  bool isLoggedIn() {
    // bool isLoggedIn = CacheHelper.getData(key: 'isLoggedIn') ?? false;
    return state == AuthStatus.authenticated;
    // return isLoggedIn;
  }

}

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier();
});
