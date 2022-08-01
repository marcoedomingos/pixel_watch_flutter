import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/core/injection_container/injection_container.dart';
import 'package:smart_watch/core/presentation/bloc/weather/weather_bloc.dart';

class WeatherWidget extends StatefulWidget {
  final double size;

  const WeatherWidget({Key? key, required this.size}) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final bloc = injectionInstance<WeatherBloc>();
  double size = 50;

  @override
  void initState() {
    super.initState();
    setState(() {
      size = widget.size;
      bloc.add(GetWeather());
    });
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
            color: primaryBlack(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80)),
              color: primaryBlack(),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.sunny,
                  color: Color(0xfffffdd0),
                  size: size * 1.3,
                ),
              ),
            ),
          ),
          BlocProvider.value(
              value: bloc,
              child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                if (state is SuccessState) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        "${state.temperature!.round()}º",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.size * 1.2,
                        ),
                      )
                    ],
                  );
                } else {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        "--",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.size * 1.2,
                        ),
                      )
                    ],
                  );
                }
              }))
        ],
      ),
    );
  }
}
