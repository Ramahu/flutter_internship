import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/log/app_log.dart';

import 'auth_notifier.dart';

class LoginNotifier extends ChangeNotifier {
  LoginNotifier(this.ref);
  final Ref ref;

  final formKey = GlobalKey<FormState>();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<void> login() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        emailFocusNode.unfocus();
        passwordFocusNode.unfocus();

        await ref
            .read(authNotifierProvider.notifier)
            .login(emailController.text, passwordController.text);

        emailController.text = '';
        passwordController.text = '';
      }
    } catch (e) {
      AppLog.error('error logging in: $e');
    }
  }
}

final loginProvider = ChangeNotifierProvider<LoginNotifier>(
  LoginNotifier.new,
);
