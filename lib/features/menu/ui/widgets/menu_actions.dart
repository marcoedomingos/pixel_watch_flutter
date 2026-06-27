import 'package:flutter/material.dart';
import 'package:smart_watch/commons/widgets/fitbit.dart';
import 'package:smart_watch/commons/widgets/heart.dart';
import 'package:smart_watch/commons/widgets/weather.dart';

class MenuActions extends StatelessWidget {
  final VoidCallback? heartClicked;
  final VoidCallback? weatherClicked;
  final VoidCallback? fitbitClicked;

  const MenuActions({
    Key? key,
    this.heartClicked,
    this.weatherClicked,
    this.fitbitClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: heartClicked,
            child: const HeartWidget(),
          ),
          GestureDetector(
            onTap: fitbitClicked,
            child: const FitbitWidget(size: 10),
          ),
          GestureDetector(
            onTap: weatherClicked,
            child: const WeatherWidget(size: 10),
          ),
        ],
      ),
    );
  }
}
