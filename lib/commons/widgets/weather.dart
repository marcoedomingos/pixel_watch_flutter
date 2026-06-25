import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/features/weather/logic/weather_bloc.dart';

class WeatherWidget extends StatefulWidget {
  final double size;

  const WeatherWidget({Key? key, required this.size}) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(GetWeather());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size * 5,
      height: widget.size * 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Card(
            elevation: 0,
            color: AppColors.primaryBlack,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: CircularProgressIndicator(
                backgroundColor: Colors.white10,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
              ),
            ),
          ),
          Positioned(
            top: -2,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
              color: AppColors.primaryBlack,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.sunny,
                  color: const Color(0xfffffdd0),
                  size: widget.size * 1.3,
                ),
              ),
            ),
          ),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              final temperature = state.status == WeatherStatus.success
                  ? state.weather?.temperature?.celsius?.round().toString()
                  : "--";
              
              return Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "$temperatureº",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.size * 1.2,
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
