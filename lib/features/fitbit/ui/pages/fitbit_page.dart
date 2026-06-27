import 'package:flutter/material.dart';
import 'package:smart_watch/commons/extension.dart';
import 'package:smart_watch/commons/widgets/watch_base_layout.dart';
import 'package:smart_watch/features/fitbit/ui/widgets/fitbit_search_card.dart';

class FitbitPage extends StatelessWidget {
  const FitbitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WatchBaseLayout(
      child: GestureDetector(
        onPanEnd: (_) => Navigator.of(context).pop(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.minSide * .52,
              child: Text(
                "FitBit menu only available in physical watch",
                textAlign: TextAlign.center,
                style: TextStyle(color: context.primaryWhite),
              ),
            ),
            SizedBox(height: context.minSide * .02),
            const FitbitSearchCard(),
          ],
        ),
      ),
    );
  }
}
