import 'package:flutter/material.dart';
import 'package:swarden/app/core/const/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.light,
      ),
    );
  }
}
