import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/core/const/assets.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/domain/repositories/authentication_repository.dart';
import 'package:swarden/app/presentation/global/controllers/session_controller.dart';
import 'package:swarden/app/presentation/global/dialogs/dialogs.dart';

import '../../../core/generated/translations.g.dart';

class SWardenDrawer extends ConsumerWidget {
  const SWardenDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset(Assets.icon),
                  ),
                  10.w,
                  Expanded(
                    child: Text(
                      ref.watch(sessionControllerProvider)?.username ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
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
                ref.read(authenticationRepositoryProvider).signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
