import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/core/extensions/date_extension.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';

import '../../../core/const/assets.dart';
import '../../global/controllers/session_controller.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  static const String routeName = 'profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                          ref.watch(sessionControllerProvider)?.username ?? '-',
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
        ],
      ),
    );
  }
}
