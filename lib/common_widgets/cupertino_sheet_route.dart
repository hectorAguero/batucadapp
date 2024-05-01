// ignore_for_file: avoid_non_null_assertion, avoid_returning_widgets,
// ignore_for_file: avoid_unnecessary_type_assertions
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sheet/route.dart';
import 'package:sheet/sheet.dart';

/// Value extracted from the official sketch iOS UI kit
/// It is the top offset that will be displayed from the bottom route
const double _kPreviousRouteVisibleOffset = 10;

/// Value extracted from the official sketch iOS UI kit
const Radius _kCupertinoSheetTopRadius = Radius.circular(10);

/// Estimated Round corners for iPhone X, XR, 11, 11 Pro
/// https://kylebashour.com/posts/finding-the-real-iphone-x-corner-radius
/// It used to animate the bottom route with a top radius that matches
/// the frame radius. If the device doesn't have round corners it will use
/// Radius.zero
const Radius _kRoundedDeviceRadius = Radius.circular(38.5);

/// Minimal distance from the top of the screen to the top of the previous route
/// It will be used ff the top safe area is less than this value.
/// In iPhones the top SafeArea is more or equal to this distance.
const double _kSheetMinimalOffset = 10;

/// Value extracted from the official sketch iOS UI kit for iPhone X, XR, 11,
/// The status bar height is bigger for devices with rounded corners, this is
/// used to detect if an iPhone has round corners or not
const double _kRoundedDeviceStatusBarHeight = 20;

const Curve _kCupertinoSheetCurve = Curves.easeOutExpo;
const Curve _kCupertinoTransitionCurve = Curves.linear;

/// Wraps the child into a cupertino modal sheet appearance. This is used to
/// create a [SheetRoute].
///
/// Clip the child widget to rectangle with top rounded corners and adds
/// top padding and top safe area.
class _CupertinoSheetDecorationBuilder extends StatelessWidget {
  const _CupertinoSheetDecorationBuilder({
    required this.child,
    required this.topRadius,
    this.backgroundColor,
  });

  /// The child contained by the modal sheet
  final Widget child;

  /// The color to paint behind the child
  final Color? backgroundColor;

  /// The top corners of this modal sheet are rounded by this Radius
  final Radius topRadius;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.only(top: topPadding + _kPreviousRouteVisibleOffset),
      child: CupertinoUserInterfaceLevel(
        data: CupertinoUserInterfaceLevelData.elevated,
        child: Builder(
          builder: (BuildContext context) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: topRadius),
                    color: backgroundColor ??
                        CupertinoColors.systemBackground.resolveFrom(context),
                  ),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// A modal route that overlays a widget over the current route and animates
/// it from the bottom with a cupertino modal sheet appearance
///
/// Clip the child widget to rectangle with top rounded corners and adds
/// top padding and top safe area.
///
/// * [AppCupertinoSheetPage], which is the [Page] version of this class
class CupertinoSheetRoute<T> extends SheetRoute<T> {
  final SheetController _sheetController = SheetController();

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  CupertinoSheetRoute({
    required WidgetBuilder builder,
    super.stops,
    double initialStop = 1,
    super.settings,
    Color? backgroundColor,
    super.maintainState = true,
    super.draggable = true,
    super.fit,
  }) : super(
          builder: (_) {
            return _CupertinoSheetDecorationBuilder(
              backgroundColor: backgroundColor,
              topRadius: _kCupertinoSheetTopRadius,
              child: Builder(builder: builder),
            );
          },
          animationCurve: _kCupertinoSheetCurve,
          initialExtent: initialStop,
        );

  @override
  SheetController createSheetController() {
    return _sheetController;
  }

  @override
  Widget buildSheet(BuildContext context, Widget child) {
    SheetPhysics? effectivePhysics = BouncingSheetPhysics(
      parent: SnapSheetPhysics(
        stops: stops ?? <double>[0, 1],
        parent: physics,
      ),
    );
    if (!draggable) {
      effectivePhysics = const NeverDraggableSheetPhysics();
    }
    final size = MediaQuery.sizeOf(context);
    final topPadding = MediaQuery.paddingOf(context).top;
    final topMargin = math.max(_kSheetMinimalOffset, topPadding) +
        _kPreviousRouteVisibleOffset;

    return Sheet.raw(
      initialExtent: initialExtent,
      decorationBuilder: decorationBuilder,
      fit: fit,
      maxExtent: size.height - topMargin,
      physics: effectivePhysics,
      controller: sheetController,
      child: child,
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final double topOffset = math.max(_kSheetMinimalOffset, topPadding);

    return AnimatedBuilder(
      animation: secondaryAnimation,
      child: CupertinoUserInterfaceLevel(
        data: CupertinoUserInterfaceLevelData.elevated,
        child: child,
      ),
      builder: (_, Widget? child) {
        final progress = secondaryAnimation.value;
        final scale = 1 - progress / 10;
        final distanceWithScale =
            (topOffset + _kPreviousRouteVisibleOffset) * 0.9;
        final offset = Offset(0, progress * (topOffset - distanceWithScale));

        return Transform.translate(
          offset: offset,
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: child,
          ),
        );
      },
    );
  }

  @override
  bool canDriveSecondaryTransitionForPreviousRoute(
    Route<dynamic> previousRoute,
  ) {
    return previousRoute is! CupertinoSheetRoute;
  }

  @override
  Widget buildSecondaryTransitionForPreviousRoute(
    BuildContext context,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final Animation<double> delayAnimation = CurvedAnimation(
      parent: _sheetController.animation,
      curve: Interval(
        initialExtent == 1 ? 0 : initialExtent,
        1,
      ),
    );

    final Animation<double> secondaryAnimation = CurvedAnimation(
      parent: _sheetController.animation,
      curve: Interval(0, initialExtent),
    );

    return CupertinoSheetBottomRouteTransition(
      body: child,
      sheetAnimation: delayAnimation,
      secondaryAnimation: secondaryAnimation,
    );
  }
}

/// Animation for previous route when a [CupertinoSheetRoute] enters/exits
class CupertinoSheetBottomRouteTransition extends StatelessWidget {
  const CupertinoSheetBottomRouteTransition({
    required this.sheetAnimation,
    required this.secondaryAnimation,
    required this.body,
    super.key,
  });

  final Widget body;

  final Animation<double> sheetAnimation;
  final Animation<double> secondaryAnimation;

  // Currently iOS does not provide any way to detect the radius of the
  // screen device. Right not we detect if the safe area has the size
  // for the device that contain a notch as they are the ones right
  // now that has corners with radius
  Radius _getRadiusForDevice(double topPadding) {
    // Round corners for iPhone devices from X to the newest version
    final isRoundedDevice = defaultTargetPlatform == TargetPlatform.iOS &&
        topPadding > _kRoundedDeviceStatusBarHeight;

    return isRoundedDevice ? _kRoundedDeviceRadius : Radius.zero;
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final double topOffset = math.max(_kSheetMinimalOffset, topPadding);
    final deviceCorner = _getRadiusForDevice(MediaQuery.paddingOf(context).top);

    final curvedAnimation = CurvedAnimation(
      parent: sheetAnimation,
      curve: _kCupertinoTransitionCurve,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AnimatedBuilder(
        animation: secondaryAnimation,
        child: body,
        builder: (BuildContext context, Widget? child) {
          final progress = curvedAnimation.value;
          final scale = 1 - progress / 10;
          final radius = progress == 0
              ? Radius.zero
              : Radius.lerp(deviceCorner, _kCupertinoSheetTopRadius, progress)!;

          return Stack(
            children: <Widget>[
              Container(color: CupertinoColors.black),
              Transform.translate(
                offset: Offset(0, progress * topOffset),
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: radius),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        (CupertinoTheme.brightnessOf(context) == Brightness.dark
                                ? CupertinoColors.inactiveGray
                                : Colors.black)
                            .withOpacity(secondaryAnimation.value * 0.1),
                        BlendMode.srcOver,
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// A modal page that overlays a widget over the current route and animates
/// it from the bottom with a cupertino modal sheet appearance
///
/// Clip the child widget to rectangle with top rounded corners and adds
/// top padding and top safe area.
///
/// The type `T` specifies the return type of the route which can be supplied as
/// the route is popped from the stack via [Navigator.pop] by providing the
/// optional `result` argument.
///
/// See also:
///
///
///  * [CupertinoSheetRoute], which is the [PageRoute] version of this class
class AppCupertinoSheetPage<T> extends Page<T> {
  /// The content to be shown in the [Route] created by this page.
  final Widget child;

  /// {@macro flutter.widgets.modalRoute.maintainState}
  final bool maintainState;

  final SheetFit fit;

  /// Creates a material page.
  const AppCupertinoSheetPage({
    required this.child,
    this.maintainState = true,
    this.fit = SheetFit.loose,
    super.key,
    super.name,
    super.arguments,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return _PageBasedCupertinoSheetRoute<T>(page: this);
  }
}

// A page-based version of SheetRoute.
//
// This route uses the builder from the page to build its content. This ensures
// the content is up to date after page updates.
class _PageBasedCupertinoSheetRoute<T> extends CupertinoSheetRoute<T> {
  AppCupertinoSheetPage<T> get _page => settings as AppCupertinoSheetPage<T>;

  @override
  bool get maintainState => _page.maintainState;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
  _PageBasedCupertinoSheetRoute({
    required AppCupertinoSheetPage<T> page,
    super.stops,
    super.initialStop,
    super.backgroundColor,
    super.maintainState,
  }) : super(
          settings: page,
          fit: page.fit,
          builder: (BuildContext context) {
            return (ModalRoute.of(context)!.settings
                    as AppCupertinoSheetPage<T>)
                .child;
          },
        );
}
