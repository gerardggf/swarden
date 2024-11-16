import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox_extension.dart';
import 'package:swarden/app/core/extensions/text_styles_extension.dart';
import 'package:swarden/app/core/generated/translations.g.dart';
import 'package:swarden/app/domain/models/pswd_item_model.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_button.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_text_field.dart';
import 'package:swarden/app/presentation/modules/auth/auth_view.dart';
import 'package:swarden/app/presentation/modules/edit_pswd_item/edit_pswd_item_controller.dart';
import 'package:swarden/app/presentation/modules/pswd_item/pswd_item_view.dart';

import '../../../domain/repositories/account_repository.dart';
import '../../global/dialogs/dialogs.dart';

class EditPswdItemView extends ConsumerStatefulWidget {
  const EditPswdItemView(this.pswdItem, {super.key});

  final PswdItemModel pswdItem;

  static const String routeName = 'edit-pswd-item';

  @override
  ConsumerState<EditPswdItemView> createState() => _EditPswdItemViewState();
}

class _EditPswdItemViewState extends ConsumerState<EditPswdItemView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final notifier = ref.read(editPswdItemControllerProvider.notifier);
        _nameController.text = widget.pswdItem.name;
        notifier.updateName(_nameController.text);
        _urlController.text = widget.pswdItem.url ?? '';
        notifier.updateUrl(_urlController.text);
        _usernameController.text = widget.pswdItem.username;
        notifier.updateUsername(_usernameController.text);
        _passwordController.text = (await ref
                .read(decryptFutureProvider(widget.pswdItem.pswd).future)) ??
            '';
        notifier.updatePassword(_passwordController.text);
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _editPswdItemKey = GlobalKey<FormState>();

//TODO:traducir pag
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editPswdItemControllerProvider);
    final notifier = ref.read(editPswdItemControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit password'),
      ),
      body: Form(
        key: _editPswdItemKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            20.h,
            SwardenTextField(
              controller: _nameController,
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
              child: const Text('Edit password item'),
              onPressed: () async {
                await _editPswdItem();
              },
            ),
            20.h,
            TextButton.icon(
              onPressed: () async {
                final result = await SWardenDialogs.dialog(
                  context: context,
                  title: 'Eliminar registro',
                  content: const Text('¿Quieres eliminar este registro?'),
                );
                if (result != true || !context.mounted) return;
                final result2 = await SWardenDialogs.dialog(
                  context: context,
                  title: 'Eliminar registro',
                  content: const Text('¿Estás seguro/a?'),
                );
                if (result2 == true) {
                  ref.read(accountRepositoryProvider).deletePswdItem(
                        widget.pswdItem.id,
                      );
                  if (!context.mounted) return;
                  SWardenDialogs.snackBar(
                    context: context,
                    text: 'Contraseña eliminada',
                  );
                  context.goNamed(AuthView.routeName);
                }
              },
              label: const Text(
                'Eliminar registro',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editPswdItem() async {
    final result = await ref
        .read(editPswdItemControllerProvider.notifier)
        .submit(widget.pswdItem);
    if (!mounted) return;
    if (result) {
      SWardenDialogs.snackBar(
        context: context,
        text: 'Password edited',
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
