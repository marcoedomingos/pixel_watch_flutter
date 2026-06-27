import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_watch/commons/extension.dart';
import 'package:smart_watch/commons/widgets/watch_base_layout.dart';
import 'package:smart_watch/features/heart_rate/logic/heartbeat_bloc.dart';
import 'package:smart_watch/features/heart_rate/ui/widgets/bpm_display.dart';

class HeartRatePage extends StatefulWidget {
  const HeartRatePage({Key? key}) : super(key: key);

  @override
  State<HeartRatePage> createState() => _HeartRatePageState();
}

class _HeartRatePageState extends State<HeartRatePage> {
  @override
  Widget build(BuildContext context) {
    return WatchBaseLayout(
      child: GestureDetector(
        onPanEnd: (_) => Navigator.of(context).pop(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Heart Rate",
              style: TextStyle(
                fontSize: 18,
                color: context.primaryWhite,
              ),
            ),
            BlocBuilder<HeartbeatBloc, HeartbeatState>(
              builder: (context, state) => BpmDisplay(bpm: state.displayBpm),
            ),
          ],
        ),
      ),
    );
  }
}
