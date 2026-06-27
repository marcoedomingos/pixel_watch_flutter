part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class GetWeather extends WeatherEvent {}

class GetWeatherForecast extends WeatherEvent {
  final double latitude;
  final double longitude;

  const GetWeatherForecast(this.latitude, this.longitude);

  @override
  List<Object?> get props => [latitude, longitude];
}
