import 'package:flutter/material.dart';
import 'package:smart_watch/commons/extension.dart';
import 'package:smart_watch/commons/widgets/pointers.dart';

class MenuHeader extends StatelessWidget {
  final DateTime time;

  const MenuHeader({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today,
              color: context.creamWhite,
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(
              Pointers.getDate(time).toUpperCase(),
              style: TextStyle(
                color: context.creamWhite,
                fontSize: context.minSide * .04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Pointers.fullHour(context, time),
      ],
    );
  }
}
