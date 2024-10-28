import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';

import '../../core/const/assets.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../global/controllers/session_controller.dart';
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
    _init();
  }

  void _init() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;
        if (currentUserId != null) {
          final user = await ref
              .read(authenticationRepositoryProvider)
              .getUser(currentUserId);
          if (user != null) {
            ref.read(sessionControllerProvider.notifier).setUser(user);
          }
        }
        if (!mounted) return;
        context.pushReplacementNamed(AuthView.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.logo,
              width: MediaQuery.sizeOf(context).width * 0.6,
            ),
            if (widget.error != null) 20.h,
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
