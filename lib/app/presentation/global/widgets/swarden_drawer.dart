import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/const/assets.dart';
import 'package:swarden/app/core/const/colors.dart';
import 'package:swarden/app/core/extensions/date_extension.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox_extension.dart';
import 'package:swarden/app/domain/repositories/authentication_repository.dart';
import 'package:swarden/app/presentation/global/controllers/session_controller.dart';
import 'package:swarden/app/presentation/global/dialogs/dialogs.dart';
import 'package:swarden/app/presentation/modules/profile/profile_view.dart';

import '../../../core/generated/translations.g.dart';

//TODO:traducri pag

class SWardenDrawer extends ConsumerWidget {
  const SWardenDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: AppColors.bg,
      child: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.pop();
                context.pushNamed(ProfileView.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        Assets.icon,
                        height: 50,
                        width: 50,
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
                              ref.watch(sessionControllerProvider)?.username ??
                                  '-',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (ref.watch(sessionControllerProvider) != null)
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
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(texts.profile.profile),
              onTap: () {
                context.pop();
                context.pushNamed(ProfileView.routeName);
              },
            ),
            ListTile(
              title: Text(texts.auth.logout),
              leading: const Icon(Icons.logout),
              onTap: () async {
                final result = await SWardenDialogs.dialog(
                  context: context,
                  title: texts.auth.logout,
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
      ),
    );
  }
}
