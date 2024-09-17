import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth/auth_view.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({
    super.key,
    this.error,
  });

  final String? error;

  static const String routeName = 'splash';

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        // final user = await ref
        //     .read(authenticationRepositoryProvider)
        //     .getUser(currentUserId);
        // if (user != null) {
        //   ref.read(sessionControllerProvider.notifier).setUser(user);
        // }
      }
      if (!mounted) return;
      if (!mounted) return;
      context.pushReplacementNamed(AuthView.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   Assets.logo,
            //   width: 100,
            //   height: 100,
            // ),
            // 40.h,
            const Text('sWarden'),
            if (widget.error != null)
              Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  widget.error!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
