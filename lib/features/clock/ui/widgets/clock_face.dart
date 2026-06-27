import 'package:flutter/material.dart';
import 'package:smart_watch/commons/widgets/heart.dart';
import 'package:smart_watch/commons/widgets/pointers.dart';

class ClockFace extends StatelessWidget {
  final DateTime time;
  final VoidCallback? heartClicked;

  const ClockFace({
    Key? key,
    required this.time,
    this.heartClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Pointers.minutesPointer(time),
        Pointers.hourPointer(time),
        Pointers.secondsPointer(time),
        Positioned(
          bottom: 30,
          child: GestureDetector(
            onTap: heartClicked,
            child: const HeartWidget(),
          ),
        ),
      ],
    );
  }
}
