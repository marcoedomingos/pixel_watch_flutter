import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class WeatherRemoteDatasource {
  final String _apiKey = "a306a0556da13ae81a1011353ce9f0d1";
  WeatherFactory? weatherFactory;

  Future<void> _initialize() async{
    weatherFactory ??= WeatherFactory(_apiKey);
  }

  Future<Weather?> getWeatherByLocation(double latitude, double longitude) async {
    await _initialize();
    return await weatherFactory!.currentWeatherByLocation(latitude, longitude);
  }

  Future<List<Weather>?> getWeatherForecastByLocation(double latitude, double longitude) async {
    await _initialize();
    return await weatherFactory!.fiveDayForecastByLocation(latitude, longitude);
  }
}
