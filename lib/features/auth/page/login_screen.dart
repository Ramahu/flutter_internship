import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/util/icons.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../provider/login_notifier.dart';
import '../widgets/gradient_button.dart';
import '../widgets/text_form.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  final outlineBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
    borderSide: BorderSide(
      color: AppColors.defaultBlue2,
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Form(
              key: loginState.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    height: 190,
                    image: AssetImage(Assets.assetsOnboarding1),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context).login,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  defaultTextForm(
                    controller: loginState.emailController,
                    type: TextInputType.emailAddress,
                    focusNode: loginState.emailFocusNode,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.email],
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    label: AppLocalizations.of(context).emailAddress,
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: AppColors.grey,
                    ),
                    prefix: const Icon(
                      mailOutlineOutlined,
                      color: AppColors.indigoAccent,
                    ),
                    onSubmit: (_) {
                      FocusScope.of(context)
                          .requestFocus(loginState.passwordFocusNode);
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context).pleaseEnterEmail;
                      }
                      return null;
                    },
                    border: outlineBorder,
                    focusedBorder: outlineBorder,
                    enableBorder: outlineBorder,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextForm(
                    controller: loginState.passwordController,
                    type: TextInputType.visiblePassword,
                    focusNode: loginState.passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    label: AppLocalizations.of(context).password,
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: AppColors.grey,
                    ),
                    prefix: const Icon(
                      keyOutlined,
                      color: AppColors.indigoAccent,
                    ),
                    suffix: loginState.isPasswordVisible
                        ? visibility
                        : visibilityOff,
                    suffixPressed: loginNotifier.togglePasswordVisibility,
                    isPassword: loginState.isPasswordVisible ? false : true,
                    maxLines: 1,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.password],
                    validate: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context).pleaseEnterPassword;
                      }
                      return null;
                    },
                    border: outlineBorder,
                    focusedBorder: outlineBorder,
                    enableBorder: outlineBorder,
                  ),
                  const SizedBox(height: 20),
                  defaultGradientButton(
                    text: AppLocalizations.of(context).login,
                    width: 280,
                    height: 50,
                    color1: AppColors.indigoAccent,
                    color2: AppColors.defaultBlue2,
                    function: loginNotifier.login,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context).needAccount,
                          style: const TextStyle(
                            fontSize: 15,
                          )),
                      Flexible(
                        child: TextButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppRoutes.signup.path);
                          },
                          child: Text(AppLocalizations.of(context).signUp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
