import 'package:weatherapp/models/details/daily_temp.dart';
import 'package:weatherapp/models/weatherModel.dart';

class DailyItem {
  int dt;

  int sunrise;

  int sunset;

  int moonrise;

  int moonset;

  double moonPhase;

  DailyTemp dailyTemp;

  int pressure;

  int humidity;

  double dewPoint;

  double windSpeed;

  int windDeg;

  double windGust;

  List<WeatherModel> weather;

  int clouds;

  double pop;

  double uvi;

  DailyItem({
    required this.dailyTemp,
    required this.windSpeed,
    required this.windGust,
    required this.windDeg,
    required this.uvi,
    required this.dewPoint,
    required this.pop,
    required this.humidity,
    required this.clouds,
    required this.pressure,
    required this.dt,
    required this.weather,
    required this.sunset,
    required this.sunrise,
    required this.moonPhase,
    required this.moonrise,
    required this.moonset,
  });

  factory DailyItem.fromJson(Map<String, dynamic> json) => DailyItem(
        dailyTemp: DailyTemp.fromJson(json['temp'] as Map<String, dynamic>),
        windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0.0,
        windGust: (json['wind_gust'] as num?)?.toDouble() ?? 0.0,
        windDeg: json['wind_deg'] as int? ?? 0,
        uvi: (json['uvi'] as num?)?.toDouble() ?? 0.0,
        dewPoint: (json['dew_point'] as num?)?.toDouble() ?? 0.0,
        pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
        humidity: json['humidity'] as int? ?? 0,
        clouds: json['clouds'] as int? ?? 0,
        pressure: json['pressure'] as int? ?? 0,
        dt: json['dt'] as int? ?? 0,
        weather: (json['weather'] as List<dynamic>?)
                ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        sunset: json['sunset'] as int? ?? 0,
        sunrise: json['sunrise'] as int? ?? 0,
        moonPhase: (json['moon_phase'] as num?)?.toDouble() ?? 0.0,
        moonrise: json['moonrise'] as int? ?? 0,
        moonset: json['moonset'] as int? ?? 0,
      );
}
