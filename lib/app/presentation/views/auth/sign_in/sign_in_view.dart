import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nebben/app/core/const/firebase_errors_extension.dart';
import 'package:nebben/app/core/generated/translations.g.dart';
import 'package:nebben/app/presentation/global/dialogs.dart';
import 'package:nebben/app/presentation/global/extensions/num_to_sizedbox.dart';
import 'package:nebben/app/presentation/global/widgets/nebben_button.dart';
import 'package:nebben/app/presentation/views/auth/auth_view.dart';
import 'package:nebben/app/presentation/views/auth/sign_in/sign_in_controller.dart';

import '../../../../core/const/assets.dart';
import '../../../../core/const/colors.dart';
import '../forgot_password/forgot_password_view.dart';
import '../register/register_view.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  static const String routeName = 'sign-in';

  @override
  ConsumerState<SignInView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<SignInView> {
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signInControllerProvider);
    final notifier = ref.read(signInControllerProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AbsorbPointer(
        absorbing: state.fetching,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (state.fetching)
                        const SizedBox(
                          height: 60,
                          width: 60,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                              color: AppColors.light,
                            ),
                          ),
                        )
                      else
                        Image.asset(
                          Assets.logo,
                          height: 60,
                          width: 60,
                        ),
                      20.h,
                      Text(
                        texts.auth.welcomeBack,
                        style: const TextStyle(
                          color: AppColors.light,
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      cursorColor: AppColors.light,
                      decoration: InputDecoration(
                        labelText: texts.auth.email,
                      ),
                      onChanged: (value) {
                        notifier.updateEmail(value);
                      },
                    ),
                    30.h,
                    TextField(
                      controller: _passwordController,
                      cursorColor: AppColors.light,
                      decoration: InputDecoration(
                        labelText: texts.auth.password,
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        notifier.updatePassword(value);
                      },
                    ),
                    40.h,
                    NebbenButton(
                      onPressed: _submit,
                      child: Text(
                        texts.auth.signIn,
                      ),
                    ),
                    15.h,
                    TextButton(
                      onPressed: () {
                        context.pushNamed(ForgotPasswordView.routeName);
                      },
                      child: Text(
                        texts.auth.forgotYourPassword,
                        style: const TextStyle(
                          color: AppColors.light,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      texts.auth.needAnAccount,
                      style: const TextStyle(
                        color: AppColors.light,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(RegisterView.routeName);
                      },
                      child: Text(
                        texts.auth.register,
                        style: const TextStyle(
                          color: AppColors.logo,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final notifier = ref.read(signInControllerProvider.notifier);
    notifier.updateFetching(true);
    FocusManager.instance.primaryFocus?.unfocus();

    final result = await notifier.signIn();
    notifier.updateFetching(false);

    if (!mounted) return;

    result.when(
      left: (failure) {
        NebbenDialogs.snackBar(
          context: context,
          text: failure.toText(),
          color: Colors.orange,
        );
      },
      right: (data) {
        context.pushReplacementNamed(AuthView.routeName);
        NebbenDialogs.snackBar(
          context: context,
          text: texts.auth.loggedIn,
        );
      },
    );
  }
}
