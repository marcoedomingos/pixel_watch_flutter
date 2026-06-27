import 'package:flutter/material.dart';

/// Pins layout to a fixed design size when the watch runs inside another app
/// (e.g. the portfolio Ubuntu simulation) instead of full-screen on a phone.
class ViewportScope extends InheritedWidget {
  const ViewportScope({
    required this.size,
    required super.child,
    super.key,
  });

  final Size size;

  static Size? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ViewportScope>()
        ?.size;
  }

  @override
  bool updateShouldNotify(ViewportScope oldWidget) =>
      size != oldWidget.size;
}
