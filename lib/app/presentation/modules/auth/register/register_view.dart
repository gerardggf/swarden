import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swarden/app/core/extensions/firebase_response_extensions.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox_extension.dart';
import 'package:swarden/app/presentation/global/widgets/swarden_text_field.dart';

import '../../../../core/const/colors.dart';
import '../../../../core/generated/translations.g.dart';
import '../../../global/dialogs/dialogs.dart';
import '../../../global/functions/validators.dart';
import '../../../global/widgets/swarden_button.dart';
import '../auth_view.dart';
import 'register_controller.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  static const String routeName = 'register';

  @override
  ConsumerState<RegisterView> createState() => _ParticularRegisterWidgetState();
}

class _ParticularRegisterWidgetState extends ConsumerState<RegisterView> {
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _repeatPasswordController = TextEditingController(),
      _nameController = TextEditingController(),
      _lastNameController = TextEditingController(),
      _usernameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _repeatPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _particularFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);
    final notifier = ref.read(registerControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(texts.auth.register),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _particularFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              10.h,
              SwardenTextField(
                icon: Icons.person,
                labelText: '${texts.auth.name}*',
                onChanged: (value) {
                  notifier.updateName(value);
                },
                controller: _nameController,
                validator: (text) => Validators.validateIsNotEmpty(text),
              ),
              15.h,
              SwardenTextField(
                icon: Icons.people,
                labelText: '${texts.auth.lastName}*',
                onChanged: (value) {
                  notifier.updateLastName(value);
                },
                controller: _lastNameController,
                validator: (text) => Validators.validateIsNotEmpty(text),
              ),
              //15.h,
              // SwardenTextField(
              //   icon: Icons.location_on,
              //   labelText: texts.auth.address,
              //   onChanged: (value) {
              //     notifier.updateAddress(value);
              //   },
              //   controller: _addressController,
              // ),
              // 15.h,
              // SwardenTextField(
              //   icon: Icons.location_city,
              //   labelText: texts.auth.city,
              //   onChanged: (value) {
              //     notifier.updateCity(value);
              //   },
              //   controller: _cityController,
              // ),
              15.h,
              SwardenTextField(
                icon: Icons.email_outlined,
                labelText: '${texts.auth.email}*',
                onChanged: (value) {
                  notifier.updateEmail(value);
                },
                controller: _emailController,
                validator: (text) => Validators.validateEmail(text),
              ),
              15.h,
              SwardenTextField(
                icon: Icons.password,
                labelText: '${texts.auth.password}*',
                onChanged: (value) {
                  notifier.updatePassword(value);
                },
                obscureText: true,
                controller: _passwordController,
                validator: (text) => Validators.validatePassword(text),
              ),
              15.h,
              SwardenTextField(
                icon: Icons.password,
                labelText: '${texts.auth.repeatPassword}*',
                obscureText: true,
                controller: _repeatPasswordController,
                validator: (text) => Validators.validateRepeatPassword(
                  text,
                  _passwordController.text,
                ),
              ),
              30.h,
              if (state.fetching)
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.light,
                  ),
                )
              else
                SwardenButton(
                  onPressed: _submit,
                  child: Text(texts.auth.register),
                ),
              30.h,
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      texts.auth.alreadyOnboard,
                      style: const TextStyle(
                        color: AppColors.light,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        texts.auth.signIn,
                        style: const TextStyle(
                          color: AppColors.light,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.h,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_particularFormKey.currentState!.validate()) {
      return;
    }
    // if (!ref.read(registerControllerProvider).acceptsPolicy) {
    //   SWardenDialogs.snackBar(
    //     context: context,
    //     text: texts.auth.youMustAcceptThePrivacyPolicy,
    //     color: Colors.orange,
    //   );
    //   return;
    // }

    final notifier = ref.read(registerControllerProvider.notifier);
    notifier.updateFetching(true);
    final result = await notifier.register();
    notifier.updateFetching(false);
    if (!mounted) return;

    result.when(
      left: (failure) {
        SWardenDialogs.snackBar(
          context: context,
          text: failure.toText(),
          color: Colors.orange,
        );
      },
      right: (right) {
        SWardenDialogs.snackBar(
          context: context,
          text: texts.auth.accountCreated,
        );
        context.pop();
        context.pushReplacementNamed(AuthView.routeName);
      },
    );
  }
}
