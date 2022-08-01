import 'package:flutter_test/flutter_test.dart';
import 'package:smart_watch/core/data/datasources/weather_remote_datasource.dart';
import 'package:weather/weather.dart';

void main(){
  late WeatherRemoteDatasource remoteDatasource;
  const latitude = -8.83833;
  const longitude = 13.2344;


  setUp((){
    remoteDatasource = WeatherRemoteDatasource();
  });
  
  group("Test all weather options", () {
    test("should get the current weather with the given location", () async{
      final weather = await remoteDatasource.getWeatherByLocation(-0, -0);
      expect(weather, isInstanceOf<Weather>());
    });

    test("should get the forecast with the given location", () async{
      final forecast = await remoteDatasource.getWeatherForecastByLocation(latitude, longitude);
      expect(forecast, isNotEmpty);
    });
  });
}