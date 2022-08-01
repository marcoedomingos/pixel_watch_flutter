import 'package:get_it/get_it.dart';
import 'package:smart_watch/core/data/datasources/weather_remote_datasource.dart';
import 'package:smart_watch/core/data/repositories/weather_repository.dart';
import 'package:smart_watch/core/domain/usecases/get_weather_usecase.dart';
import 'package:smart_watch/core/presentation/bloc/heartbeat/heartbeat_bloc.dart';
import 'package:smart_watch/core/presentation/bloc/home/home_bloc.dart';
import 'package:smart_watch/core/presentation/bloc/weather/weather_bloc.dart';

final injectionInstance = GetIt.instance;

// Is better to use a Future and not a Void, this way it decrease the chance of the ui build before all the injection are made
Future<void> init() async {
  injectionInstance.registerSingleton(HeartbeatBloc());

  injectionInstance.registerSingleton(HomeBloc());

  injectionInstance.registerSingleton(WeatherRemoteDatasource());

  injectionInstance.registerSingleton(WeatherRepository(remoteDatasource: injectionInstance()));

  injectionInstance.registerSingleton(GetWeatherUseCase(repository: injectionInstance()));

  injectionInstance.registerSingleton(WeatherBloc(weatherUseCase: injectionInstance()));
}