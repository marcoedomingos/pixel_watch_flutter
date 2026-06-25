import 'package:get_it/get_it.dart';
import 'package:smart_watch/features/clock/logic/clock_bloc.dart';
import 'package:smart_watch/features/heart_rate/logic/heartbeat_bloc.dart';
import 'package:smart_watch/features/home/logic/home_bloc.dart';
import 'package:smart_watch/features/weather/data/get_weather_usecase.dart';
import 'package:smart_watch/features/weather/data/weather_remote_datasource.dart';
import 'package:smart_watch/features/weather/data/weather_repository.dart';
import 'package:smart_watch/features/weather/logic/weather_bloc.dart';

final injectionInstance = GetIt.instance;

Future<void> init() async {
  injectionInstance.registerSingleton(ClockBloc());
  injectionInstance.registerSingleton(HeartbeatBloc());
  injectionInstance.registerSingleton(HomeBloc());

  injectionInstance.registerSingleton(WeatherRemoteDatasource());
  injectionInstance.registerSingleton(
    WeatherRepository(remoteDatasource: injectionInstance()),
  );
  injectionInstance.registerSingleton(
    GetWeatherUseCase(repository: injectionInstance()),
  );

  injectionInstance.registerSingleton(
    WeatherBloc(weatherUseCase: injectionInstance()),
  );
}
