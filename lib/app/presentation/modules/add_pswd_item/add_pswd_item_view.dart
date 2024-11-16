import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox_extension.dart';
import 'package:swarden/app/core/extensions/text_styles_extension.dart';
import 'package:swarden/app/core/generated/translations.g.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_button.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_text_field.dart';

import '../../global/dialogs/dialogs.dart';
import 'add_pswd_item_controller.dart';

class AddPswdItemView extends ConsumerStatefulWidget {
  const AddPswdItemView({super.key});

  static const String routeName = 'add-pswd-item';

  @override
  ConsumerState<AddPswdItemView> createState() => _AddPswdItemViewState();
}

class _AddPswdItemViewState extends ConsumerState<AddPswdItemView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //TODO:traducir

  final _addPswdItemKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addPswdItemControllerProvider);
    final notifier = ref.read(addPswdItemControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add password'),
      ),
      body: Form(
        key: _addPswdItemKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            20.h,
            SwardenTextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              icon: Icons.web,
              labelText: texts.auth.name,
              onChanged: (value) {
                notifier.updateName(value);
              },
            ),
            SwardenTextField(
              controller: _urlController,
              icon: Icons.public_outlined,
              labelText: 'URL',
              onChanged: (value) {
                notifier.updateUrl(value);
              },
            ),
            SwardenTextField(
              controller: _usernameController,
              icon: Icons.person_outline,
              labelText: '${texts.auth.email} / Username',
              onChanged: (value) {
                notifier.updateUsername(value);
              },
            ),
            Row(
              children: [
                Expanded(
                  child: SwardenTextField(
                    controller: _passwordController,
                    icon: Icons.password_outlined,
                    labelText: texts.auth.password,
                    obscureText: !state.hidePswd,
                    onChanged: (value) {
                      notifier.updatePassword(value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    notifier.updateHidePswd(!state.hidePswd);
                  },
                  icon: Icon(
                    state.hidePswd ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ],
            ),
            25.h,
            Row(
              children: [
                const Icon(Icons.fingerprint),
                15.w,
                Expanded(
                  child: Text(
                    'Utilizar biometría',
                    style: context.bodyThemeL,
                  ),
                ),
                Switch(
                  value: state.useBiometrics,
                  onChanged: (value) => notifier.updateUseBiometrics(value),
                ),
              ],
            ),
            25.h,
            SwardenButton(
              child: const Text('Add password item'),
              onPressed: () async {
                await _addPswdItem();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addPswdItem() async {
    final result =
        await ref.read(addPswdItemControllerProvider.notifier).submit();
    if (!mounted) return;
    if (result) {
      SWardenDialogs.snackBar(
        context: context,
        text: 'Password added',
      );
      context.pop();
    } else {
      SWardenDialogs.snackBar(
        context: context,
        text: 'Something went wrong',
        color: Colors.red,
      );
    }
  }
}
