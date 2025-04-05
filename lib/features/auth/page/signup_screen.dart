import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/auth_status.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/util/colors.dart';
import '../../../core/util/icons.dart';
import '../../../generated/assets.dart';
import '../provider/auth_notifier.dart';
import '../widgets/gradient_button.dart';
import '../widgets/text_form.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode verPasswordFocusNode = FocusNode();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isVisible = false;
  InputBorder outlineBorder = const OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25)),
    borderSide: BorderSide(
      color: defaultBlue2,
    ),
  );

  @override
  void dispose() {
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    verPasswordFocusNode.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    verPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // final authStatus = ref.watch(authProvider);
    ref.listen<AuthStatus>(authProvider, (previous, next) {
      if (next == AuthStatus.authenticated) {
        context.go(AppRoutes.home);
      }
    });

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child:Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Image(
                    height: 180,
                    image: AssetImage(Assets.assetsOnboarding1),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  defaultTextForm(
                    controller: nameController,
                    type: TextInputType.text,
                    focusNode: nameFocusNode,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.name],
                    textInputAction: TextInputAction.next,
                    label: 'Full Name',
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: grey,
                    ),
                    prefix: const Icon(
                      mailOutlineOutlined,
                      color: indigoAccent,
                    ),
                    onSubmit: (_) {
                      FocusScope.of(context).requestFocus(emailFocusNode);
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    border:outlineBorder,
                    focusedBorder: outlineBorder,
                    enableBorder: outlineBorder,
                  ),
                  const SizedBox(height: 15,),
                  defaultTextForm(
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
                    border:outlineBorder,
                    focusedBorder: outlineBorder,
                    enableBorder: outlineBorder,
                  ),
                  const SizedBox(height: 15,),
                  defaultTextForm(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    focusNode: passwordFocusNode,
                    textInputAction: TextInputAction.next,
                    label: 'Password',
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: grey,
                    ),
                    prefix: const Icon(
                      keyOutlined,
                      color: indigoAccent,
                    ),
                    onSubmit: (_) {
                      FocusScope.of(context).requestFocus(verPasswordFocusNode);
                    },
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
                      if (value.length < 8) {
                        return 'Short password';
                      }
                      return null;
                    },
                    border: outlineBorder,
                    focusedBorder: outlineBorder,
                    enableBorder: outlineBorder,
                  ),
                  const SizedBox(height: 15,),
                  defaultTextForm(
                    controller: verPasswordController,
                    type: TextInputType.visiblePassword,
                    focusNode: verPasswordFocusNode,
                    textInputAction: TextInputAction.done,
                    label: 'confirm Password',
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
                        return 'Please enter confirm password';
                      }
                      if(passwordController.value.text != value){
                        return 'Mast match' ;
                      }
                      return null;
                    },
                    border: outlineBorder,
                    focusedBorder: outlineBorder,
                    enableBorder: outlineBorder,
                  ),
                  const SizedBox(height: 20),
                  defaultGradientBottom(
                    text: ' Sign Up',
                    width: 350, height: 50,
                    context: context,
                    color1: indigoAccent,
                    color2: defaultBlue2,
                    function: (){
                      if (formKey.currentState!.validate()) {
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account ?' ,
                          style: TextStyle(fontSize: 15,)),
                      Flexible(
                        child: TextButton(
                          onPressed: () {
                            context.go(AppRoutes.login);
                          },
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
