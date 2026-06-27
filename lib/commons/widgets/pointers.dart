import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_watch/commons/extension.dart';

class Pointers {
  static String getDate(DateTime time) => DateFormat("MMMd").format(time);

  static Widget fullHour(BuildContext context, DateTime time, {double? fontSize}) {
    return Text(
      DateFormat("Hm").format(time),
      style: TextStyle(
        color: context.creamWhite,
        fontSize: fontSize ?? context.minSide * 0.2,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget hourPointer(DateTime time) {
    const double height = 270;
    final hour = time.hour.toDouble();
    final angle = (-pi * (hour / -12)) * 2;
    return RotatedBox(
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: const Offset(0, 20),
          child: Center(
            child: Container(
              height: height * 0.3,
              width: 20,
              transform: Matrix4.translationValues(0, 10, 0),
              decoration: BoxDecoration(
                color: const Color(0xfffffdd0),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget minutesPointer(DateTime time) {
    const double height = 270;
    final minutes = time.minute.toDouble();
    final angle = (-pi * (minutes / -60)) * 2;
    return RotatedBox(
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: const Offset(0, 20),
          child: Container(
            height: height * 0.4,
            width: 4,
            transform: Matrix4.translationValues(0, 30, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
      ),
    );
  }

  static Widget secondsPointer(DateTime time) {
    const double height = 270;
    final seconds = time.second.toDouble();
    final angle = (-pi * (seconds / -60)) * 2;
    return RotatedBox(
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: const Offset(0, 20),
          child: Container(
            height: height * 0.4,
            width: 2,
            transform: Matrix4.translationValues(0, 30, 0),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
      ),
    );
  }
}
