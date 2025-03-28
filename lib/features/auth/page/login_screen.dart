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

  bool isVisible = false;
  InputBorder noneBorder = InputBorder.none;

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // final authStatus = ref.watch(authProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
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
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                defaultTextForm(
                  width: 350,
                  height: 50,
                  bgColor:  isDarkMode ? grey[800] :grey[200],
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  focusNode: emailFocusNode,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  autofillHints: [AutofillHints.email],
                  textInputAction: TextInputAction.next,
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
                  border:noneBorder,
                  focusedBorder: noneBorder,
                  enableBorder: noneBorder,
                ),
                const SizedBox(height: 20,),
                defaultTextForm(
                  width:350,
                  height: 50,
                  bgColor:  isDarkMode ? grey[800] :grey[200],
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
                  isPassword: isVisible?false : true,
                  maxLines: 1,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  autofillHints: [AutofillHints.password],
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  border: noneBorder,
                  focusedBorder: noneBorder,
                  enableBorder: noneBorder,
                ),
                const SizedBox(height: 20),
                defaultGradientBottom(
                  text: ' Log In',
                  width: 350, height: 50,
                  context: context,
                  color1: indigoAccent,
                  color2: defaultBlue2,
                  function: (){
                    ref.read(authProvider.notifier).login(emailController.text,
                        passwordController.text);
                    context.go(AppRoutes.home);
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Need an account ?' ,
                        style: TextStyle(fontSize: 15,)),
                    Flexible(
                      child: TextButton(
                        onPressed: () {
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
    );
  }
}
