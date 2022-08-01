import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_watch/commons/size/size.dart';

class Pointers {
  final date = DateFormat("MMMd").format(DateTime.now());

  static fullHour(BuildContext context, {double? fontSize}){
    return Text(
      DateFormat("Hm").format(DateTime.now()),
      style: TextStyle(
        color: Color(0xfffffdd0),
        fontSize: fontSize ?? width(context) * 0.2,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static hourPointer() {
    const height = 270;
    final hour = DateTime.now().hour.toDouble();
    final angle = (-pi * (hour / -12)) * 2;
    return RotatedBox(
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: Offset(0, 20),
          child: Center(
            child: Container(
              height: height * 0.3,
              width: 20,
              transform: Matrix4.translationValues(0, 10, 0),
              decoration: BoxDecoration(
                color: Color(0xfffffdd0),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static minutesPointer() {
    const height = 270;
    final minutes = DateTime.now().minute.toDouble();
    final angle = (-pi * (minutes / -60)) * 2;
    return RotatedBox(
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: Offset(0, 20),
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

  static secondsPointer() {
    const height = 270;
    final seconds = DateTime.now().second.toDouble();
    final angle = (-pi * (seconds / -60)) * 2;
    return RotatedBox(
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: Offset(0, 20),
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
