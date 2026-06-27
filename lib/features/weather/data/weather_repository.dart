import 'package:smart_watch/features/weather/data/iweather_repository.dart';
import 'package:smart_watch/features/weather/data/weather_remote_datasource.dart';
import 'package:weather/weather.dart';

class WeatherRepository extends IWeatherRepository {
  WeatherRepository({required this.remoteDatasource});

  WeatherRemoteDatasource? remoteDatasource;

  @override
  Future<Weather?> getWeather(double latitude, double longitude) async {
    return await remoteDatasource?.getWeatherByLocation(latitude, longitude);
  }

  @override
  Future<List<Weather>?> getWeatherForecast(double latitude, double longitude) async {
    return await remoteDatasource?.getWeatherForecastByLocation(latitude, longitude);
  }
}
