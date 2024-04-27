import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nebben/app/presentation/global/extensions/num_to_sizedbox.dart';
import 'package:nebben/app/presentation/views/auth/register/register_controller.dart';
import 'package:nebben/app/presentation/views/auth/register/widgets/company_register_widget.dart';
import 'package:nebben/app/presentation/views/auth/register/widgets/particular_register_widget.dart';

import '../../../../core/const/colors.dart';
import '../../../../core/generated/translations.g.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  static const String routeName = 'register';

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: AbsorbPointer(
            absorbing: state.fetching,
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      5.w,
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_left,
                          size: 30,
                          color: AppColors.light,
                        ),
                      ),
                      20.w,
                      Text(
                        texts.auth.register,
                        style: const TextStyle(
                          color: AppColors.light,
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: TabBar(
                    labelColor: AppColors.light,
                    indicatorColor: AppColors.light,
                    tabs: [
                      Tab(
                        text: texts.auth.particular.toUpperCase(),
                      ),
                      Tab(
                        text: texts.auth.company.toUpperCase(),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      ParticularRegisterWidget(),
                      CompanyRegisterWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
