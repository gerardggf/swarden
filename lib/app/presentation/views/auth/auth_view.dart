import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swarden/app/presentation/views/auth/sign_in/sign_in_view.dart';

import '../../global/widgets/error_info_widget.dart';
import '../../global/widgets/loading_widget.dart';
import '../home/home_view.dart';

// final authStateChangesStreamProvider = StreamProvider<User?>(
//   (ref) => ref.watch(firebaseAuthProvider).authStateChanges(),
// );

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  static const String routeName = 'auth';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChangesStream = ref.watch(authStateChangesStreamProvider);
    return authStateChangesStream.when(
      data: (user) {
        //print(user?.email);
        if (user != null) {
          return const HomeView();
        } else {
          return const SignInView();
        }
      },
      loading: () => const LoadingWidget(),
      error: (_, __) => const ErrorInfoWidget(),
    );
  }
}
