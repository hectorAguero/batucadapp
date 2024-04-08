import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/is_ios_or_macos_platform_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/features/home/widgets/settings_modal_sheet.dart';

class AppCupertinoSliverNavigationBar extends StatelessWidget {
  const AppCupertinoSliverNavigationBar({
    required this.largeTitle,
    this.leading,
    this.stretch,
    this.heroTag = const _HeroTag(null),
    this.transitionBetweenRoutes = true,
    this.border = const Border(),
    this.backgroundColor = Colors.transparent,
    super.key,
  });

  final String largeTitle;
  final Widget? leading;
  final bool? stretch;
  final Border border;
  final Color backgroundColor;
  final Object heroTag;
  final bool transitionBetweenRoutes;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      backgroundColor: backgroundColor,
      largeTitle: Text(largeTitle),
      brightness: Theme.of(context).brightness,
      stretch: stretch ?? false,
      leading: leading,
      heroTag: heroTag,
      transitionBetweenRoutes: transitionBetweenRoutes,
      border: border,
      trailing: context.querySize.isSmallScreen
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.zero,
              alignment: Alignment.centerRight,
              onPressed: () => showSettingModalSheet(context),
              child: Icon(
                kIsCupertino ? CupertinoIcons.settings : Icons.settings,
              ),
            )
          : null,
    );
  }
}

@immutable
class _HeroTag {
  const _HeroTag(this.navigator);

  final NavigatorState? navigator;

  // Let the Hero tag be described in tree dumps.
  @override
  String toString() =>
      'Default Hero tag for Cupertino navigation bars with navigator $navigator';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _HeroTag && other.navigator == navigator;
  }

  @override
  int get hashCode => identityHashCode(navigator);
}
