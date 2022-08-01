import 'package:smart_watch/core/data/repositories/weather_repository.dart';
import 'package:weather/weather.dart';

class GetWeatherUseCase {
  GetWeatherUseCase({required this.repository});

  final WeatherRepository? repository;

  Future<Weather?> getWeather(double latitude, double longitude) async{
    return await repository?.getWeather(latitude, longitude);
  }

  Future<List<Weather>?> getWeatherForecast(double latitude, double longitude) async{
    return await repository?.getWeatherForecast(latitude, longitude);
  }
}
