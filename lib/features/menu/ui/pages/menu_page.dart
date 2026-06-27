import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_watch/commons/widgets/watch_base_layout.dart';
import 'package:smart_watch/features/clock/logic/clock_bloc.dart';
import 'package:smart_watch/features/clock/logic/clock_state.dart';
import 'package:smart_watch/features/menu/ui/widgets/menu_actions.dart';
import 'package:smart_watch/features/menu/ui/widgets/menu_header.dart';

class MenuPage extends StatelessWidget {
  final VoidCallback? heartClicked;
  final VoidCallback? weatherClicked;
  final VoidCallback? fitbitClicked;
  final Function(DragUpdateDetails)? horizontalSlideControl;
  final Function(DragUpdateDetails)? verticalSlideControl;

  const MenuPage({
    Key? key,
    required this.heartClicked,
    required this.weatherClicked,
    required this.fitbitClicked,
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
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 20,
                  child: MenuHeader(time: state.time),
                ),
                Positioned(
                  bottom: 30,
                  child: MenuActions(
                    heartClicked: heartClicked,
                    weatherClicked: weatherClicked,
                    fitbitClicked: fitbitClicked,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
