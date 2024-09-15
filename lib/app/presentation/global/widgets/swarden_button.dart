import 'package:flutter/material.dart';
import 'package:swarden/app/core/const/colors.dart';

class SwardenButton extends StatelessWidget {
  const SwardenButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.light,
      ),
      onPressed: onPressed,
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    if (child is Text) {
      return Text(
        (child as Text).data ?? '',
        style: (child as Text).style?.copyWith(color: Colors.white) ??
            const TextStyle(color: Colors.white),
      );
    }
    return child;
  }
}
