part of 'weather_bloc.dart';

abstract class WeatherEvent{}

class GetWeather extends WeatherEvent {}

class GetWeatherForecast extends WeatherEvent {}