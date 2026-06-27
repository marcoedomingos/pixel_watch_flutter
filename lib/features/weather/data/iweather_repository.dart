abstract class IWeatherRepository{
  Future getWeather(double latitude, double longitude);

  Future getWeatherForecast(double latitude, double longitude);
}