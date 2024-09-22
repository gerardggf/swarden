import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/core/generated/translations.g.dart';
import 'package:swarden/app/domain/models/pswd_item_model.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_button.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_text_field.dart';
import 'package:swarden/app/presentation/modules/auth/auth_view.dart';

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
    _nameController.text = widget.pswdItem.name;
    _urlController.text = widget.pswdItem.url ?? '';
    _usernameController.text = widget.pswdItem.username;
    _passwordController.text = widget.pswdItem.pswd;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _addPswdItemKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit password'),
      ),
      body: Form(
        key: _addPswdItemKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            20.h,
            SwardenTextField(
              controller: _nameController,
              icon: Icons.web,
              labelText: texts.auth.name,
            ),
            SwardenTextField(
              controller: _urlController,
              icon: Icons.public_outlined,
              labelText: 'URL',
            ),
            SwardenTextField(
              controller: _usernameController,
              icon: Icons.person_outline,
              labelText: '${texts.auth.email} / Username',
            ),
            SwardenTextField(
              controller: _passwordController,
              icon: Icons.password_outlined,
              labelText: texts.auth.password,
              obscureText: true,
            ),
            20.h,
            SwardenButton(
              child: const Text('Edit password item'),
              onPressed: () async {
                await addPswdItem();
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

  Future<void> addPswdItem() async {
    final result = await ref
        .read(accountRepositoryProvider)
        .updatePswdItem(widget.pswdItem.copyWith(
          name: _nameController.text,
          url: _urlController.text.isEmpty ? null : _urlController.text,
          username: _usernameController.text,
          pswd: _passwordController.text,
        ));
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
