import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/domain/repositories/authentication_repository.dart';
import 'package:swarden/app/presentation/global/controllers/session_controller.dart';

class SWardenDrawer extends ConsumerWidget {
  const SWardenDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          Text(ref.watch(sessionControllerProvider)?.username ?? ''),
          const Spacer(),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              ref.read(sessionControllerProvider.notifier).setUser(null);
              ref.read(authenticationRepositoryProvider).signOut();
            },
          )
        ],
      ),
    );
  }
}
