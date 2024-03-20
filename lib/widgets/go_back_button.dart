import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/is_ios_or_macos_platform_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      minSize: 0,
      child: Icon(
        kIsCupertino ? Icons.arrow_back_ios : Icons.arrow_back,
        color: context.colorScheme.onBackground,
        size: 22,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
