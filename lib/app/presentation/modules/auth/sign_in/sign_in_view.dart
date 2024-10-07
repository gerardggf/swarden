import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/extensions/firebase_response_extensions.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';

import '../../../../core/const/assets.dart';
import '../../../../core/const/colors.dart';
import '../../../../core/generated/translations.g.dart';
import '../../../global/dialogs/dialogs.dart';
import '../../../global/widgets/swarden_button.dart';
import '../auth_view.dart';
import '../forgot_password/forgot_password_view.dart';
import '../register/register_view.dart';
import 'sign_in_controller.dart';

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
                    SwardenButton(
                      onPressed: _submit,
                      child: state.fetching
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
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
                          color: AppColors.light,
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
        SWardenDialogs.snackBar(
          context: context,
          text: failure.toText(),
          color: Colors.orange,
        );
      },
      right: (data) {
        context.pushReplacementNamed(AuthView.routeName);
        SWardenDialogs.snackBar(
          context: context,
          text: texts.auth.loggedIn,
        );
      },
    );
  }
}
