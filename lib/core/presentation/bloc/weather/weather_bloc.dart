import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:smart_watch/core/domain/usecases/get_weather_usecase.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase? weatherUseCase;
  List<Weather>? forecast = [];
  LocationPermission? locationPermission;
  Position? position;
  Weather? weather;

  WeatherBloc({required this.weatherUseCase}) : super(InitialState()) {
    on<GetWeather>((event, emit) async {
      emit(ProgressState());
      final initialized = await _getCurrentPosition();
      if (initialized == true) {
        try {
          weather = await weatherUseCase!.getWeather(position!.latitude, position!.longitude);
          add(GetWeatherForecast());
        } catch (error) {
          emit(FailureState(
            iconData: Icons.location_off,
            message: "No Location\nPermission",
          ));
        }
      } else {
        emit(FailureState(
          iconData: Icons.location_off,
          message: "No Location\nPermission",
        ));
      }
    });

    on<GetWeatherForecast>((event, emit) async {
      try {

        forecast = await weatherUseCase!.getWeatherForecast(position!.latitude, position!.longitude);
        forecast = List.from(reducedForecast()!);
        emit(SuccessState(
          country: weather!.country,
          area: weather!.areaName,
          description: weather!.weatherDescription,
          weatherIcon: weather!.weatherIcon,
          temperature: weather!.temperature!.celsius,
          maxTemperature: weather!.tempMax!.celsius,
          minTemperature: weather!.tempMin!.celsius,
        ));
      } catch (error) {
        emit(FailureState(
          iconData: Icons.location_off,
          message: "No Location\nPermission",
        ));
      }
    });
  }

  Future<bool?> _getCurrentPosition() async {
    bool succeed = false;
    await Geolocator.requestPermission().then((value) async {
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.always ||
          locationPermission == LocationPermission.whileInUse) {
        position = await Geolocator.getCurrentPosition();
        succeed = true;
      }
    });
    return succeed;
  }

  List<Weather>? reducedForecast(){
    List<Weather>? newForecast = [];
    for (var currentWeather in forecast!) {
      final date = DateTime.parse(currentWeather.date!.toString().substring(0, 10));
      if(newForecast.isNotEmpty){
        if(newForecast.where((element) => DateTime.parse(element.date!.toString().substring(0, 10)) == date).isEmpty) {
          newForecast.add(forecast!.firstWhere((element) => DateTime.parse(element.date!.toString().substring(0, 10)) == date));
        }
      }else{
        newForecast.add(forecast!.firstWhere((element) => DateTime.parse(element.date!.toString().substring(0, 10)) == date));
      }
    }
    return newForecast;
  }
}
