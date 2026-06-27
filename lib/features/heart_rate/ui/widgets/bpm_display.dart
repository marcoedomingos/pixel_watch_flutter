import 'package:flutter/material.dart';
import 'package:smart_watch/commons/extension.dart';

class BpmDisplay extends StatelessWidget {
  final String bpm;

  const BpmDisplay({Key? key, required this.bpm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          bpm,
          style: TextStyle(
            fontSize: context.width * 0.72 * 0.4,
            color: context.primaryWhite,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "BPM",
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue,
              ),
            ),
            Icon(
              Icons.favorite,
              color: Colors.blue,
            )
          ],
        )
      ],
    );
  }
}
