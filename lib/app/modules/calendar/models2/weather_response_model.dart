class WeatherModel {
  final String city;
  final double? tempC;
  final double? tempF;
  final String? condition;
  final double? humidity;
  final double? windKph;
  final int? chanceOfRain;
  final double? uvIndex;

  WeatherModel({
    required this.city,
    this.tempC,
    this.tempF,
    this.condition,
    this.humidity,
    this.windKph,
    this.chanceOfRain,
    this.uvIndex,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'] ?? '',
      tempC: json['temp_c'] != null ? (json['temp_c'] as num).toDouble() : null,
      tempF: json['temp_f'] != null ? (json['temp_f'] as num).toDouble() : null,
      condition: json['condition'],
      humidity: json['humidity'] != null
          ? (json['humidity'] as num).toDouble()
          : null,
      windKph: json['wind_kph'] != null
          ? (json['wind_kph'] as num).toDouble()
          : null,
      chanceOfRain: json['chance_of_rain'],
      uvIndex: json['uv_index'] != null
          ? (json['uv_index'] as num).toDouble()
          : null,
    );
  }
}
