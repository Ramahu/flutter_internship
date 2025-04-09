import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/util/colors.dart';
import '../../../core/util/icons.dart';
import '../../../generated/assets.dart';
import '../provider/auth_notifier.dart';
import '../widgets/gradient_button.dart';
import '../widgets/text_form.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isVisible = false;
  InputBorder outlineBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
    borderSide: BorderSide(
      color: defaultBlue2,
    ),
  );

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    height: 190,
                    image: AssetImage(Assets.assetsOnboarding1),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  defaultTextForm(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.email],
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    label: 'Email Address',
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: grey,
                    ),
                    prefix: const Icon(
                      mailOutlineOutlined,
                      color: indigoAccent,
                    ),
                    onSubmit: (_) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email address';
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
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    focusNode: passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    label: 'Password',
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: grey,
                    ),
                    prefix: const Icon(
                      keyOutlined,
                      color: indigoAccent,
                    ),
                    suffix: isVisible ? visibility : visibilityOff,
                    suffixPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    isPassword: isVisible ? false : true,
                    maxLines: 1,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.password],
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    border: outlineBorder,
                    focusedBorder: outlineBorder,
                    enableBorder: outlineBorder,
                  ),
                  const SizedBox(height: 20),
                  defaultGradientButton(
                    text: ' Log In',
                    width: 350,
                    height: 50,
                    color1: indigoAccent,
                    color2: defaultBlue2,
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ref.read(authProvider.notifier).login(
                            emailController.text, passwordController.text);
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Need an account ?',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      Flexible(
                        child: TextButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppRoutes.signup);
                          },
                          child: const Text('Sign Up'),
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
