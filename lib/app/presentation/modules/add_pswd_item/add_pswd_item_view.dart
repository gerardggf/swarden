import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add password'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          20.h,
          SwardenButton(
            child: const Text('Add password item'),
            onPressed: () async {
              await addPswdItem();
            },
          ),
        ],
      ),
    );
  }

  Future<void> addPswdItem() async {
    final result = await ref.read(accountRepositoryProvider).addPswdItem(
          name: 'eee',
          username: 'eeee@eee.ee',
          pswd: 'ee1ee1ee1e',
        );
    if (!mounted) return;
    if (result) {
      SWardenDialogs.snackBar(context: context, text: 'Password added');
    } else {
      SWardenDialogs.snackBar(
        context: context,
        text: 'Something went wrong',
        color: Colors.red,
      );
    }
  }
}
