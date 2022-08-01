import 'package:flutter/material.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/commons/size/size.dart';
import 'package:smart_watch/commons/widgets/heart.dart';
import 'package:smart_watch/commons/widgets/pointers.dart';

class ClockPage extends StatefulWidget {
  final VoidCallback? heartClicked;
  final Function(DragUpdateDetails)? horizontalSlideControl;
  final Function(DragUpdateDetails)? verticalSlideControl;

  const ClockPage({Key? key, required this.heartClicked, required this.horizontalSlideControl, required this.verticalSlideControl,}) : super(key: key);

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack(),
      body: GestureDetector(
        onHorizontalDragUpdate: widget.horizontalSlideControl,
        onVerticalDragUpdate: widget.verticalSlideControl,
        child: SizedBox(
          width: width(context) * .72,
          height: width(context) * .72,
          child: StreamBuilder(
            stream: Stream.periodic(Duration(seconds: 1)),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: width(context) * .72,
                    height: width(context) * .72,
                    decoration: BoxDecoration(
                        color: primaryBlack(),
                        borderRadius: BorderRadius.circular(140.0)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Pointers.minutesPointer(),
                        Pointers.hourPointer(),
                        Pointers.secondsPointer(),
                        Positioned(
                          bottom: 30,
                          child: GestureDetector(
                            onTap: widget.heartClicked!,
                            child: HeartWidget(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
