import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_watch/features/weather/data/weather_remote_datasource.dart';
import 'package:smart_watch/features/weather/data/weather_repository.dart';
import 'package:smart_watch/features/weather/data/get_weather_usecase.dart';
import 'package:smart_watch/features/weather/logic/weather_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late WeatherBloc weatherBloc;

  setUp(() {
    weatherBloc = WeatherBloc(
      weatherUseCase: GetWeatherUseCase(
        repository: WeatherRepository(
          remoteDatasource: WeatherRemoteDatasource(),
        ),
      ),
    );
  });

  group("Test all weather options", () {
    test("should return the initial State", () {
      expect(weatherBloc.state, const WeatherState(status: WeatherStatus.initial));
    });

    blocTest<WeatherBloc, WeatherState>(
      "should call the GetWeather event and emit loading status",
      build: () => weatherBloc,
      act: (bloc) => bloc.add(GetWeather()),
      expect: () => [
        const WeatherState(status: WeatherStatus.loading),
        // It might emit failure state eventually due to no geolocator in test environment
        isA<WeatherState>().having((s) => s.status, 'status', WeatherStatus.failure),
      ],
    );
  });
}
