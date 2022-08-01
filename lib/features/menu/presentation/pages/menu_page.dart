import 'package:flutter/material.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/commons/size/size.dart';
import 'package:smart_watch/commons/widgets/fitbit.dart';
import 'package:smart_watch/commons/widgets/heart.dart';
import 'package:smart_watch/commons/widgets/pointers.dart';
import 'package:smart_watch/commons/widgets/weather.dart';

class MenuPage extends StatefulWidget {
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
    required this.horizontalSlideControl, required this.verticalSlideControl,
  }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final pointers = Pointers();

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
                        Positioned(
                          top: 20,
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Color(0xfffffdd0),
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text(
                                pointers.date.toUpperCase(),
                                style: TextStyle(
                                  color: Color(0xfffffdd0),
                                  fontSize: width(context) * .04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Pointers.fullHour(context),
                        Positioned(
                          bottom: 30,
                          child: SizedBox(
                            width: 270,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: widget.heartClicked,
                                  child: HeartWidget(),
                                ),
                                GestureDetector(
                                  onTap: widget.fitbitClicked,
                                  child: FitbitWidget(size: 10),
                                ),
                                GestureDetector(
                                  onTap: widget.weatherClicked,
                                  child: WeatherWidget(size: 10),
                                ),
                              ],
                            ),
                          ),
                        )
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
