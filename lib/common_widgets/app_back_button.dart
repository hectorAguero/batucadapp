import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../extensions/is_ios_or_macos_platform_extension.dart';
import '../extensions/theme_of_context_extension.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      minSize: 0,
      child: Icon(
        kIsCupertino ? Icons.arrow_back_ios : Icons.arrow_back,
        color: context.colorScheme.onSurface,
        size: 22,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
