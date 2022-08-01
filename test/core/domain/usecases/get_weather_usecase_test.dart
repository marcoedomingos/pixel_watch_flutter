import 'package:flutter_test/flutter_test.dart';
import 'package:smart_watch/core/data/datasources/weather_remote_datasource.dart';
import 'package:smart_watch/core/data/repositories/weather_repository.dart';
import 'package:smart_watch/core/domain/usecases/get_weather_usecase.dart';
import 'package:weather/weather.dart';
void main(){
  late GetWeatherUseCase useCase;
  const latitude = -8.83833;
  const longitude = 13.2344;


  setUp((){
    useCase = GetWeatherUseCase(repository: WeatherRepository(remoteDatasource: WeatherRemoteDatasource()));
  });

  group("Test all possible usecases", () {
    test("should get the current weather with the given location", () async{
      final weather = await useCase.getWeather(-0, -0);
      expect(weather, isInstanceOf<Weather>());
    });

    test("should get the forecast with the given location", () async{
      final forecast = await useCase.getWeatherForecast(latitude, longitude);
      expect(forecast, isNotEmpty);
    });
  });
}