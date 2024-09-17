import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/presentation/swarden_app.dart';

import '../../domain/models/pswd_item_model.dart';
import '../modules/add_pswd_item/add_pswd_item_view.dart';
import '../modules/auth/auth_view.dart';
import '../modules/auth/change_password/change_password_view.dart';
import '../modules/auth/forgot_password/forgot_password_view.dart';
import '../modules/auth/register/register_view.dart';
import '../modules/auth/sign_in/sign_in_view.dart';
import '../modules/home/home_view.dart';
import '../modules/profile/profile_view.dart';
import '../modules/pswd_item/pswd_item_view.dart';
import '../modules/splash_view.dart';

mixin RoutesMixin on State<SWardenApp> {
  final router = GoRouter(
    routes: [
      GoRoute(
        name: SplashView.routeName,
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        name: AuthView.routeName,
        path: '/auth',
        builder: (context, state) => const AuthView(),
      ),
      GoRoute(
        name: SignInView.routeName,
        path: '/sign-in',
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        name: RegisterView.routeName,
        path: '/register',
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        name: ForgotPasswordView.routeName,
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        name: ChangePasswordView.routeName,
        path: '/change-password',
        builder: (context, state) => const ChangePasswordView(),
      ),
      GoRoute(
        name: HomeView.routeName,
        path: '/home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        name: ProfileView.routeName,
        path: '/profile',
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        name: PswdItemView.routeName,
        path: '/pswd-item',
        builder: (context, state) =>
            PswdItemView(state.extra! as PswdItemModel),
      ),
      GoRoute(
          name: AddPswdItemView.routeName,
          path: '/add-pswd-item',
          builder: (context, state) => const AddPswdItemView()),
    ],
  );
}
