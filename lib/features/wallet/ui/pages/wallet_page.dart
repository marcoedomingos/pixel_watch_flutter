import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_watch/commons/extension.dart';
import 'package:smart_watch/commons/widgets/watch_base_layout.dart';
import 'package:smart_watch/features/weather/logic/weather_bloc.dart';
import 'package:smart_watch/features/clock/logic/clock_bloc.dart';
import 'package:smart_watch/features/clock/logic/clock_state.dart';
import 'package:smart_watch/features/weather/ui/widgets/weather_display.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return WatchBaseLayout(
      child: GestureDetector(
        onPanUpdate: (_) => Navigator.of(context).pop(),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, weatherState) {
            if (weatherState.status == WeatherStatus.initial || weatherState.status == WeatherStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (weatherState.status == WeatherStatus.success && weatherState.weather != null) {
              return BlocBuilder<ClockBloc, ClockState>(
                builder: (context, clockState) {
                  return WeatherDisplay(
                    weather: weatherState.weather!,
                    forecast: weatherState.forecast,
                    time: clockState.time,
                  );
                },
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(weatherState.errorIcon ?? Icons.error, color: context.primaryWhite),
                  const SizedBox(height: 16),
                  Text(
                    weatherState.errorMessage ?? "Error",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: context.primaryWhite, fontSize: 16),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
