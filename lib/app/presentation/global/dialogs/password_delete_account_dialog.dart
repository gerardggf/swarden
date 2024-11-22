import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/const/colors.dart';
import 'package:swarden/app/core/extensions/firebase_response_extensions.dart';
import 'package:swarden/app/domain/firebase_response/firebase_response.dart';
import 'package:swarden/app/presentation/global/dialogs/dialogs.dart';
import 'package:swarden/app/presentation/modules/auth/auth_view.dart';

import '../../../core/generated/translations.g.dart';
import '../../modules/profile/profile_controller.dart';

//TODO:traducir
Future<void> showDeleteAccountDialog(
    BuildContext context, WidgetRef ref) async {
  final notifier = ref.read(profileControllerProvider.notifier);
  //Throws first info dialog
  final doIt1 = await SWardenDialogs.dialog(
    context: context,
    title: 'deleteAccount',
    content: const Text('areYouSureYouWantToDeleteYourAccount'),
  );
  if (doIt1 != true || !context.mounted) return;
  //Pops first dialog and throws second info dialog
  final doIt2 = await SWardenDialogs.dialog(
    context: context,
    title: 'deleteAccount',
    content: const Text(
        'yourDataWillBeDeletedButNotTheRoutesYouHaveCreatedHoweverTheyWillRemainAnonymousIfYouWantToDeleteThemPleaseDoItManually'),
  );
  if (doIt2 != true || !context.mounted) return;
  //Pops second dialog and have to enter your password
  final password = await showDialog<String?>(
    context: context,
    builder: (_) => const PasswordDeleteAccountDialog(),
  );
  if (password == null) return;
  final isCorrectPswd = await notifier.isCorrectPassword(password);
  //If the password is incorrect, the user has to repeat the steps to
  //delete the account. In case the password is corect, the account will
  //be permanently deleted

  if (!isCorrectPswd && context.mounted) {
    SWardenDialogs.snackBar(
      context: context,
      text: 'wrongPassword',
      color: Colors.orange,
      milliseconds: 4000,
    );
    return;
  }
  //deletes the firebase auth & firebase firestore account
  final result = await notifier.deleteAccount(password);
  if (!context.mounted) return;
  //Shows the respective snackbar and push the user to the main screen if
  //the deletion is successful.
  if (result != const FirebaseResponse.success()) {
    context.pop();
    SWardenDialogs.snackBar(
      context: context,
      text: result.toText(),
      color: Colors.orange,
      milliseconds: 4000,
    );
  } else {
    SWardenDialogs.snackBar(
      context: context,
      text: 'accountSuccessfullyDeleted',
    );
    context.goNamed(
      AuthView.routeName,
    );
  }
}

class PasswordDeleteAccountDialog extends StatefulWidget {
  const PasswordDeleteAccountDialog({
    super.key,
  });

  @override
  State<PasswordDeleteAccountDialog> createState() =>
      _PasswordDeleteAccountDialogState();
}

class _PasswordDeleteAccountDialogState
    extends State<PasswordDeleteAccountDialog> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      title: Text(
        texts.profile.enterYourPasswordToVerifyTheDeletionOfYourAccount,
        style: const TextStyle(fontSize: 18),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            obscureText: true,
            controller: _textController,
            decoration: InputDecoration(
              hintText: texts.auth.password,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            texts.global.cancel,
            style: const TextStyle(color: AppColors.light),
          ),
        ),
        TextButton(
          onPressed: () async {
            context.pop(_textController.text);
          },
          child: Text(
            texts.global.confirm,
            style: const TextStyle(color: AppColors.light),
          ),
        ),
      ],
    );
  }
}
