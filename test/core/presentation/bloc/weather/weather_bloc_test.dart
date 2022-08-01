import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_watch/core/data/datasources/weather_remote_datasource.dart';
import 'package:smart_watch/core/data/repositories/weather_repository.dart';
import 'package:smart_watch/core/domain/usecases/get_weather_usecase.dart';
import 'package:smart_watch/core/presentation/bloc/weather/weather_bloc.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  late WeatherBloc weatherBloc;

  setUp(() => weatherBloc = WeatherBloc(weatherUseCase: GetWeatherUseCase(repository: WeatherRepository(remoteDatasource: WeatherRemoteDatasource()))));

  group("Test all weather options", () {
    
    test("should return the initial State", (){
      expect(InitialState(), weatherBloc.state);
    });
    
    blocTest<WeatherBloc, WeatherState>(
        "should call the GetWeather event and emit the ProgressState",
        build: () => weatherBloc,
        act: (bloc) => bloc.add(GetWeather()),
        expect: ()=> [ProgressState()]
    );

    blocTest<WeatherBloc, WeatherState>(
        "should call the GetWeatherForecast event and emit the FailureState because there is no location permission",
        build: () => weatherBloc,
        act: (bloc) => bloc.add(GetWeatherForecast()),
        expect: ()=> [isInstanceOf<FailureState>()]
    );
  });
}