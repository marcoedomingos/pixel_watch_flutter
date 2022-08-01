import 'package:smart_watch/core/data/datasources/weather_remote_datasource.dart';
import 'package:smart_watch/core/domain/repositories/iweather_repository.dart';
import 'package:weather/weather.dart';

class WeatherRepository extends IWeatherRepository {
  WeatherRepository({required this.remoteDatasource});

  WeatherRemoteDatasource? remoteDatasource;

  @override
  Future<Weather?> getWeather(double latitude, double longitude) async{
    return await remoteDatasource?.getWeatherByLocation(latitude, longitude);
  }

  @override
  Future<List<Weather>?> getWeatherForecast(double latitude, double longitude) async{
    return await remoteDatasource?.getWeatherForecastByLocation(latitude, longitude);
  }
}
