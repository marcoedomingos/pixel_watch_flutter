import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_watch/features/weather/data/get_weather_usecase.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase weatherUseCase;

  WeatherBloc({required this.weatherUseCase}) : super(const WeatherState()) {
    on<GetWeather>(_onGetWeather);
    on<GetWeatherForecast>(_onGetWeatherForecast);
  }

  Future<void> _onGetWeather(GetWeather event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    final position = await _getCurrentPosition();
    if (position != null) {
      try {
        final weather = await weatherUseCase.getWeather(position.latitude, position.longitude);
        if (weather != null) {
          emit(state.copyWith(
            status: WeatherStatus.success,
            weather: weather,
          ));
          add(GetWeatherForecast(position.latitude, position.longitude));
        } else {
          emit(state.copyWith(
            status: WeatherStatus.failure,
            errorIcon: Icons.error_outline,
            errorMessage: "Could not fetch weather data",
          ));
        }
      } catch (error) {
        emit(state.copyWith(
          status: WeatherStatus.failure,
          errorIcon: Icons.cloud_off,
          errorMessage: "Weather service error",
        ));
      }
    } else {
      emit(state.copyWith(
        status: WeatherStatus.failure,
        errorIcon: Icons.location_off,
        errorMessage: "No Location Permission",
      ));
    }
  }

  Future<void> _onGetWeatherForecast(GetWeatherForecast event, Emitter<WeatherState> emit) async {
    try {
      final forecast = await weatherUseCase.getWeatherForecast(event.latitude, event.longitude);
      if (forecast != null) {
        final reduced = _reduceForecast(forecast);
        emit(state.copyWith(forecast: reduced));
      }
    } catch (_) {}
  }

  Future<Position?> _getCurrentPosition() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        return await Geolocator.getCurrentPosition();
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  List<Weather> _reduceForecast(List<Weather> forecast) {
    final Map<String, Weather> dailyForecast = {};
    for (var weather in forecast) {
      if (weather.date != null) {
        final dateKey = weather.date!.toString().substring(0, 10);
        if (!dailyForecast.containsKey(dateKey)) {
          dailyForecast[dateKey] = weather;
        }
      }
    }
    return dailyForecast.values.toList();
  }
}
