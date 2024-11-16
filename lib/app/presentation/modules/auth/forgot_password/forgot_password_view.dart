import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/extensions/firebase_response_extensions.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox_extension.dart';
import '../../../../core/const/assets.dart';
import '../../../../core/const/colors.dart';
import '../../../../core/generated/translations.g.dart';
import '../../../../domain/firebase_response/firebase_response.dart';
import '../../../global/dialogs/dialogs.dart';
import '../../../global/widgets/swarden_button.dart';
import '../register/register_view.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  static const String routeName = 'forgot-password';

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(forgotPasswordControllerProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.logo,
                        ),
                        30.h,
                        Text(
                          texts.auth.forgotYourPassword,
                          style: const TextStyle(
                            color: AppColors.light,
                            fontSize: 26,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        onTapOutside: (_) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: _emailController,
                        cursorColor: AppColors.light,
                        decoration:
                            InputDecoration(labelText: texts.auth.email),
                        onChanged: (value) {
                          notifier.updateEmail(value);
                        },
                      ),
                      40.h,
                      SwardenButton(
                        onPressed: _submit,
                        child: Text(texts.auth.send),
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
                        texts.auth.alreadyOnboard,
                        style: const TextStyle(
                          color: AppColors.light,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          texts.auth.signIn,
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
                          context.pushReplacementNamed(RegisterView.routeName);
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
          Positioned(
            top: MediaQuery.of(context).padding.top + 5,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.keyboard_arrow_left,
                size: 30,
                color: AppColors.light,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (ref.read(forgotPasswordControllerProvider).email.isEmpty) {
      SWardenDialogs.snackBar(
        context: context,
        text: texts.auth.theFieldCannotBeEmpty,
        color: Colors.orange,
      );
      return;
    }
    final result = await ref
        .read(forgotPasswordControllerProvider.notifier)
        .forgotPassword();
    if (!mounted) return;
    if (result == const FirebaseResponse.success()) {
      SWardenDialogs.snackBar(
        context: context,
        text: texts.auth.emailSentSuccessfully,
        milliseconds: 4000,
      );
      context.pop();
    } else {
      SWardenDialogs.snackBar(
        context: context,
        text: result.toText(),
        color: Colors.orange,
      );
    }
  }
}
