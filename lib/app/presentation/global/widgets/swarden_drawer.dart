import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/core/const/assets.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';
import 'package:swarden/app/domain/repositories/authentication_repository.dart';
import 'package:swarden/app/presentation/global/controllers/session_controller.dart';

class SWardenDrawer extends ConsumerWidget {
  const SWardenDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10).copyWith(top: 50),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      Assets.icon,
                      width: 60,
                    ),
                  ),
                  10.w,
                  Expanded(
                    child: Text(
                      ref.watch(sessionControllerProvider)?.username ?? '-',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
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
