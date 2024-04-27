import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nebben/app/core/const/firebase_errors_extension.dart';
import 'package:nebben/app/core/const/global.dart';
import 'package:nebben/app/core/generated/translations.g.dart';
import 'package:nebben/app/presentation/global/extensions/num_to_sizedbox.dart';
import 'package:nebben/app/presentation/global/functions/validators.dart';
import 'package:nebben/app/presentation/views/auth/auth_view.dart';

import '../../../../../core/const/colors.dart';
import '../../../../global/dialogs.dart';
import '../../../../global/functions/launch_url.dart';
import '../../../../global/widgets/nebben_button.dart';
import '../register_controller.dart';

class ParticularRegisterWidget extends ConsumerStatefulWidget {
  const ParticularRegisterWidget({super.key});

  @override
  ConsumerState<ParticularRegisterWidget> createState() =>
      _ParticularRegisterWidgetState();
}

class _ParticularRegisterWidgetState
    extends ConsumerState<ParticularRegisterWidget> {
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _repeatPasswordController = TextEditingController(),
      _nameController = TextEditingController(),
      _lastNameController = TextEditingController(),
      _addressController = TextEditingController(),
      _cityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
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
    return Form(
      key: _particularFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            10.h,
            _buildFormWidget(
              title: '${texts.auth.name}*',
              onChanged: (value) {
                notifier.updateName(value);
              },
              controller: _nameController,
              validator: (text) => Validators.validateIsNotEmpty(text),
            ),
            15.h,
            _buildFormWidget(
              title: '${texts.auth.lastName}*',
              onChanged: (value) {
                notifier.updateLastName(value);
              },
              controller: _lastNameController,
              validator: (text) => Validators.validateIsNotEmpty(text),
            ),
            15.h,
            _buildFormWidget(
              title: '${texts.auth.address}*',
              onChanged: (value) {
                notifier.updateAddress(value);
              },
              controller: _addressController,
              validator: (text) => Validators.validateIsNotEmpty(text),
            ),
            15.h,
            _buildFormWidget(
              title: '${texts.auth.city}*',
              onChanged: (value) {
                notifier.updateCity(value);
              },
              controller: _cityController,
              validator: (text) => Validators.validateIsNotEmpty(text),
            ),
            15.h,
            _buildFormWidget(
              title: '${texts.auth.email}*',
              onChanged: (value) {
                notifier.updateEmail(value);
              },
              controller: _emailController,
              validator: (text) => Validators.validateEmail(text),
            ),
            15.h,
            _buildFormWidget(
              title: '${texts.auth.password}*',
              onChanged: (value) {
                notifier.updatePassword(value);
              },
              obscureText: true,
              controller: _passwordController,
              validator: (text) => Validators.validatePassword(text),
            ),
            15.h,
            _buildFormWidget(
              title: '${texts.auth.repeatPassword}*',
              onChanged: (value) {},
              obscureText: true,
              controller: _repeatPasswordController,
              validator: (text) => Validators.validateRepeatPassword(
                text,
                _passwordController.text,
              ),
            ),
            30.h,
            Row(
              children: [
                Checkbox(
                  activeColor: AppColors.light,
                  value: state.acceptsPolicy,
                  onChanged: (value) {
                    notifier.updateAcceptsPolicy(value ?? false);
                  },
                ),
                5.w,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: texts.auth.iHaveReadAndAgreeThe,
                        ),
                        TextSpan(
                          text: '${texts.auth.legalConditions}*',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchCustomUrl(Urls.termsOfService);
                            },
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.light,
                          ),
                        ),
                        TextSpan(
                          text: texts.auth.andThe,
                        ),
                        TextSpan(
                          text: '${texts.auth.privacyPolicy}*',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchCustomUrl(Urls.privacyPolicy);
                            },
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.light,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            15.h,
            Row(
              children: [
                Checkbox(
                  activeColor: AppColors.light,
                  value: state.acceptsMailing,
                  onChanged: (value) {
                    notifier.updateAcceptsMailing(value ?? false);
                  },
                ),
                5.w,
                Expanded(
                  child: Text(
                    texts.auth.receiveNewsAndPromos,
                  ),
                ),
              ],
            ),
            40.h,
            if (state.fetching)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.light,
                ),
              )
            else
              NebbenButton(
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
                        color: AppColors.logo,
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
    );
  }

  Widget _buildFormWidget({
    required String title,
    required void Function(String value) onChanged,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: AppColors.light,
      decoration: InputDecoration(
        labelText: title,
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }

  Future<void> _submit() async {
    if (!_particularFormKey.currentState!.validate()) {
      return;
    }
    if (!ref.read(registerControllerProvider).acceptsPolicy) {
      NebbenDialogs.snackBar(
        context: context,
        text: texts.auth.youMustAcceptThePrivacyPolicy,
        color: Colors.orange,
      );
      return;
    }

    final notifier = ref.read(registerControllerProvider.notifier);
    notifier.updateFetching(true);
    final result = await notifier.register(false);
    notifier.updateFetching(false);
    if (!mounted) return;

    result.when(
      left: (failure) {
        NebbenDialogs.snackBar(
          context: context,
          text: failure.toText(),
          color: Colors.orange,
        );
      },
      right: (right) {
        NebbenDialogs.snackBar(
          context: context,
          text: texts.auth.accountCreated,
        );
        context.pop();
        context.pushReplacementNamed(AuthView.routeName);
      },
    );
  }
}
