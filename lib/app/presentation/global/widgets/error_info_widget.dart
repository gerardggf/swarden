import 'package:flutter/material.dart';
import 'package:swarden/app/core/extensions/num_to_sizedbox.dart';

import '../../../core/generated/translations.g.dart';

class ErrorInfoWidget extends StatelessWidget {
  const ErrorInfoWidget({
    super.key,
    this.text,
    this.icon,
  });

  final String? text;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ??
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 34,
                ),
            15.h,
            Text(
              text ?? texts.global.anErrorHasOccurred,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
