part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather? weather;
  final List<Weather>? forecast;
  final IconData? errorIcon;
  final String? errorMessage;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
    this.forecast,
    this.errorIcon,
    this.errorMessage,
  });

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    List<Weather>? forecast,
    IconData? errorIcon,
    String? errorMessage,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      forecast: forecast ?? this.forecast,
      errorIcon: errorIcon ?? this.errorIcon,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, weather, forecast, errorIcon, errorMessage];
}
