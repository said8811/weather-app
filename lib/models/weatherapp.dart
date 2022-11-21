import 'package:weatherapp/models/details/currenttempp.dart';
import 'package:weatherapp/models/details/daily.dart';
import 'package:weatherapp/models/details/hourly.dart';

class OneCallData {
  double lat;

  double lon;

  String timezone;

  int timezoneOffset;

  CurrentModel currentModel;

  List<HourlyItem> hourly;

  List<DailyItem> daily;

  OneCallData({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.daily,
    required this.currentModel,
    required this.hourly,
    required this.timezoneOffset,
  });

  factory OneCallData.fromJson(Map<String, dynamic> json) => OneCallData(
        lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
        lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
        timezone: json['timezone'] as String? ?? '',
        currentModel: CurrentModel.fromJson(json['current']),
        daily: (json['daily'] as List<dynamic>?)
                ?.map((e) => DailyItem.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        hourly: (json['hourly'] as List<dynamic>?)
                ?.map((e) => HourlyItem.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        timezoneOffset: json['timezone_offset'] as int? ?? 0,
      );
}
