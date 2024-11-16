import 'package:flutter/material.dart';
import 'package:swarden/app/core/const/colors.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox_extension.dart';

class SwardenTextField extends StatelessWidget {
  const SwardenTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.validator,
    this.icon,
    this.onChanged,
    this.obscureText = false,
    this.textCapitalization,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validator;
  final IconData? icon;
  final bool obscureText;
  final void Function(String value)? onChanged;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Icon(icon),
        if (icon != null) 15.w,
        Expanded(
          child: TextFormField(
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            obscureText: obscureText,
            controller: controller,
            onChanged: onChanged,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            cursorColor: AppColors.light,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            validator: validator,
          ),
        ),
      ],
    );
  }
}
