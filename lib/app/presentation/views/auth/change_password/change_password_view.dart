import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/extensions/firebase_results_extensions.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_button.dart';

import '../../../../core/const/colors.dart';
import '../../../../core/generated/translations.g.dart';
import '../../../../domain/enums/firebase_results.dart';
import '../../../global/dialogs/dialogs.dart';
import 'change_password_controller.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({super.key});

  static const String routeName = 'change-password';

  @override
  ConsumerState<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(changePasswordControllerProvider.notifier);
    return SafeArea(
      child: Scaffold(
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
                          // Image.asset(
                          //   Assets.logo,
                          //   height: 60,
                          //   width: 60,
                          // ),
                          20.h,
                          Text(
                            texts.auth.changePassword,
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
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          texts.auth
                              .weWillSendYouAnEmailFromWhichYouCanChangeYourPassword,
                          style: const TextStyle(
                            color: AppColors.light,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        20.h,
                        TextField(
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
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.keyboard_arrow_left,
                  color: AppColors.light,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (ref.read(changePasswordControllerProvider).email.isEmpty) {
      SWardenDialogs.snackBar(
        context: context,
        text: texts.auth.theFieldCannotBeEmpty,
        color: Colors.orange,
      );
      return;
    }
    final result = await ref
        .read(changePasswordControllerProvider.notifier)
        .changePassword();
    if (!mounted) return;
    if (result == FirebaseResult.success) {
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
