enum WeatherStatus { ideal, alert, danger }

class ForecastData {
  final String day;
  final String highTemp;
  final String lowTemp;
  final String rainChance;
  final String windSpeed;
  final WeatherStatus status;

  ForecastData({
    required this.day,
    required this.highTemp,
    required this.lowTemp,
    required this.rainChance,
    required this.windSpeed,
    required this.status,
  });
}