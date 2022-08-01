part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable{
  const WeatherState();

  @override
  List<Object> get props => [];
}

class InitialState extends WeatherState {}

class ProgressState extends WeatherState {}

class FailureState extends WeatherState {
  final IconData? iconData;
  final String? message;

  const FailureState({
    this.iconData,
    this.message,
  });

  @override
  List<Object> get props => [iconData!, message!];
}

class SuccessState extends WeatherState {
  final String? country;
  final String? area;
  final String? description;
  final String? weatherIcon;
  final double? temperature;
  final double? maxTemperature;
  final double? minTemperature;

  const SuccessState({
    required this.country,
    required this.area,
    required this.description,
    required this.weatherIcon,
    required this.temperature,
    required this.maxTemperature,
    required this.minTemperature,
  });
}
