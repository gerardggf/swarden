import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/core/extensions/date_extension.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/domain/repositories/account_repository.dart';
import 'package:swarden/app/presentation/global/widgets/error_info_widget.dart';

import '../../../core/const/assets.dart';
import '../../../core/generated/translations.g.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../../global/controllers/session_controller.dart';
import '../../global/dialogs/dialogs.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  static const String routeName = 'profile';

  //TODO:traducir

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(sessionControllerProvider);
    if (user == null) {
      return const ErrorInfoWidget(
        text: 'No user logged',
        icon: Icon(Icons.person_off),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    Assets.icon,
                    height: 80,
                    width: 80,
                  ),
                ),
                10.w,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          user.username,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Account created on ${FirebaseAuth.instance.currentUser!.metadata.creationTime!.toDDMMYYYY()}',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Changer user name'),
            onTap: () async {
              final newUsername = await SWardenDialogs.textFieldDialog(
                context: context,
                text: 'New username',
                hintText: 'Username',
                currentText: user.username,
              );
              final result = await ref
                  .read(accountRepositoryProvider)
                  .updateUserAccountInfo(
                    user.copyWith(username: newUsername),
                  );
              if (result) {
                ref.read(sessionControllerProvider.notifier).setUser(
                      user.copyWith(username: newUsername),
                    );
              }
            },
          ),
          ListTile(
            title: Text(texts.auth.logout),
            leading: const Icon(Icons.logout),
            onTap: () async {
              final result = await SWardenDialogs.dialog(
                context: context,
                title: 'Cerrar sesión',
                content: const Text(
                  '¿Seguro que quieres cerrar sesión?',
                ),
              );
              if (result != true) return;
              ref.read(sessionControllerProvider.notifier).setUser(null);
              await ref.read(authenticationRepositoryProvider).signOut();
            },
          ),
        ],
      ),
    );
  }
}
