import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nebben/app/core/const/firebase_errors_extension.dart';
import 'package:nebben/app/core/const/global.dart';
import 'package:nebben/app/presentation/global/dialogs.dart';
import 'package:nebben/app/presentation/global/extensions/num_to_sizedbox.dart';

import '../../../../../core/const/colors.dart';
import '../../../../../core/generated/translations.g.dart';
import '../../../../global/functions/launch_url.dart';
import '../../../../global/functions/validators.dart';
import '../../../../global/widgets/nebben_button.dart';
import '../register_controller.dart';

class CompanyRegisterWidget extends ConsumerStatefulWidget {
  const CompanyRegisterWidget({super.key});

  @override
  ConsumerState<CompanyRegisterWidget> createState() =>
      _CompanyRegisterWidgetState();
}

class _CompanyRegisterWidgetState extends ConsumerState<CompanyRegisterWidget> {
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _repeatPasswordController = TextEditingController(),
      _taxNameController = TextEditingController(),
      _cifController = TextEditingController(),
      _addressController = TextEditingController(),
      _cityController = TextEditingController();

  @override
  void dispose() {
    _taxNameController.dispose();
    _cifController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _repeatPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _companyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);
    final notifier = ref.read(registerControllerProvider.notifier);
    return Form(
      key: _companyFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            10.h,
            _buildFormWidget(
              title: '${texts.auth.taxName}*',
              onChanged: (value) {
                notifier.updateTaxName(value);
              },
              controller: _taxNameController,
              validator: (text) => Validators.validateIsNotEmpty(text),
            ),
            15.h,
            _buildFormWidget(
              title: '${texts.auth.cif}*',
              onChanged: (value) {
                notifier.updateCif(value);
              },
              controller: _cifController,
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
      cursorColor: AppColors.light,
      textCapitalization: TextCapitalization.sentences,
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
    final notifier = ref.read(registerControllerProvider.notifier);
    if (!_companyFormKey.currentState!.validate()) {
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
      },
    );
  }
}
