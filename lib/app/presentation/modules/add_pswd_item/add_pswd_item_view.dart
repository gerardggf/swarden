import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/core/generated/translations.g.dart';
import 'package:swarden/app/domain/models/pswd_item_model.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_button.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_text_field.dart';

import '../../../domain/repositories/account_repository.dart';
import '../../global/dialogs/dialogs.dart';

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

  final _addPswdItemKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              child: const Text('Add password item'),
              onPressed: () async {
                await addPswdItem();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addPswdItem() async {
    final result = await ref.read(accountRepositoryProvider).addPswdItem(
          PswdItemModel(
            //will be overwritten later
            id: '',
            name: _nameController.text,
            username: _usernameController.text,
            pswd: _passwordController.text,
            creationDate: Timestamp.now(),
            lastUpdated: Timestamp.now(),
            url: _urlController.text,
          ),
        );
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
