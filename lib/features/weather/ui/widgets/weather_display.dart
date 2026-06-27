import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_watch/commons/extension.dart';
import 'package:smart_watch/commons/widgets/pointers.dart';
import 'package:weather/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;
  final List<Weather>? forecast;
  final DateTime time;

  const WeatherDisplay({
    Key? key,
    required this.weather,
    required this.time,
    this.forecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Pointers.fullHour(context, time, fontSize: context.width * .05),
        const SizedBox(height: 8),
        Text(
          "${weather.country}, ${weather.areaName}".capitalizeEveryFirstLetter,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          (weather.weatherDescription ?? "").capitalizeEveryFirstLetter,
          style: const TextStyle(color: Colors.white),
        ),
        _buildTemperatureRow(context),
        _buildMinMaxRow(context),
        if (forecast != null && forecast!.isNotEmpty)
          _buildForecastList(context),
      ],
    );
  }

  Widget _buildTemperatureRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: "http://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png",
          width: 60,
          height: 60,
          placeholder: (context, url) => const CircularProgressIndicator(),
        ),
        Text(
          "${weather.temperature?.celsius?.round() ?? 0}º",
          style: const TextStyle(fontSize: 32, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildMinMaxRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${weather.tempMax?.celsius?.round() ?? 0}º",
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Text(
          "${weather.tempMin?.celsius?.round() ?? 0}º",
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildForecastList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: forecast!.length,
          itemBuilder: (context, index) {
            final item = forecast![index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  Text(
                    DateFormat('EEE').format(item.date!),
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  CachedNetworkImage(
                    imageUrl: "http://openweathermap.org/img/wn/${item.weatherIcon}@2x.png",
                    width: 30,
                    height: 30,
                  ),
                  Text(
                    "${item.temperature?.celsius?.round() ?? 0}º",
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
