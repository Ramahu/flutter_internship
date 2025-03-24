import 'package:flutter/material.dart';
import '../generated/assets.dart';
import '../util/colors.dart';
import '../util/icons.dart';
import '../util/navigator.dart';
import 'widgets/gradient_button.dart';
import 'widgets/text_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  void _handleLogin() {
    print('Login pressed with: ${emailController.text}, ${passwordController.text}');
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                    mail_outline_outlined,
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
                    key_outlined,
                    color: indigoAccent,
                  ),
                  suffix: isVisible ? visibility : visibility_off,
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
                  function: _handleLogin,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Need an account ?" , style: TextStyle(fontSize: 15,)),
                    Flexible(
                      child: TextButton(
                        onPressed: () {
                          // navigateAndReplace(context, const SignUp());
                        },
                        child: const Text("Sign Up"),
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
