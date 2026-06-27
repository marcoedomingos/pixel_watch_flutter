import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_watch/commons/widgets/watch_base_layout.dart';
import 'package:smart_watch/features/clock/logic/clock_bloc.dart';
import 'package:smart_watch/features/clock/logic/clock_state.dart';
import 'package:smart_watch/features/clock/ui/widgets/clock_face.dart';

class ClockPage extends StatelessWidget {
  final VoidCallback? heartClicked;
  final Function(DragUpdateDetails)? horizontalSlideControl;
  final Function(DragUpdateDetails)? verticalSlideControl;

  const ClockPage({
    Key? key,
    required this.heartClicked,
    required this.horizontalSlideControl,
    required this.verticalSlideControl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WatchBaseLayout(
      child: GestureDetector(
        onHorizontalDragUpdate: horizontalSlideControl,
        onVerticalDragUpdate: verticalSlideControl,
        child: BlocBuilder<ClockBloc, ClockState>(
          builder: (context, state) {
            return ClockFace(
              time: state.time,
              heartClicked: heartClicked,
            );
          },
        ),
      ),
    );
  }
}
