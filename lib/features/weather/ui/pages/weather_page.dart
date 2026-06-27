import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_watch/commons/extension.dart';
import 'package:smart_watch/commons/widgets/watch_base_layout.dart';
import 'package:smart_watch/features/weather/logic/weather_bloc.dart';
import 'package:smart_watch/features/clock/logic/clock_bloc.dart';
import 'package:smart_watch/features/clock/logic/clock_state.dart';
import 'package:smart_watch/features/weather/ui/widgets/weather_display.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(GetWeather());
  }

  @override
  Widget build(BuildContext context) {
    return WatchBaseLayout(
      child: GestureDetector(
        onPanUpdate: (_) => Navigator.of(context).pop(),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, weatherState) {
            switch (weatherState.status) {
              case WeatherStatus.initial:
              case WeatherStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case WeatherStatus.failure:
                return _buildError(weatherState);
              case WeatherStatus.success:
                return BlocBuilder<ClockBloc, ClockState>(
                  builder: (context, clockState) {
                    return WeatherDisplay(
                      weather: weatherState.weather!,
                      forecast: weatherState.forecast,
                      time: clockState.time,
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }

  Widget _buildError(WeatherState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(state.errorIcon ?? Icons.error, color: context.primaryWhite, size: 40),
        const SizedBox(height: 16),
        Text(
          state.errorMessage ?? "An error occurred",
          textAlign: TextAlign.center,
          style: TextStyle(color: context.primaryWhite, fontSize: 16),
        ),
      ],
    );
  }
}
