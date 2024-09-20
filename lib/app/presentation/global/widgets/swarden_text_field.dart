import 'package:flutter/material.dart';
import 'package:swarden/app/core/const/colors.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';

class SwardenTextField extends StatelessWidget {
  const SwardenTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.validator,
    this.icon,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validator;
  final IconData? icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Icon(icon),
        10.w,
        Expanded(
          child: TextFormField(
            obscureText: obscureText,
            controller: controller,
            cursorColor: AppColors.light,
            decoration: InputDecoration(
              focusColor: AppColors.light,
              label: labelText == null ? null : Text(labelText!),
              labelStyle: const TextStyle(
                color: Colors.black54,
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.light),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.light),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
