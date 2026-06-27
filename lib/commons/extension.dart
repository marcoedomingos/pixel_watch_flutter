import 'package:flutter/material.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/commons/size/viewport_scope.dart';

extension StringExtension on String {
  String get capitalizeEveryFirstLetter {
    if (isEmpty) return this;
    return split(" ")
        .where((phrase) => phrase.isNotEmpty)
        .map((phrase) => "${phrase[0].toUpperCase()}${phrase.substring(1).toLowerCase()}")
        .join(" ");
  }
}

extension WatchContextExtension on BuildContext {
  Size get _layoutSize => ViewportScope.maybeOf(this) ?? MediaQuery.sizeOf(this);

  double get width => _layoutSize.width;
  double get height => _layoutSize.height;

  /// Returns the smaller of the two dimensions, useful for circular layouts.
  double get minSide => width < height ? width : height;

  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  Color get primaryBlack => AppColors.primaryBlack;
  Color get secondaryBlack => AppColors.secondaryBlack;
  Color get primaryGrey => AppColors.primaryGrey;
  Color get primaryRed => AppColors.primaryRed;
  Color get primaryWhite => AppColors.primaryWhite;
  Color get creamWhite => AppColors.creamWhite;
}
