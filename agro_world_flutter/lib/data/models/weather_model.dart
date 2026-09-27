class WeatherModel {
  final String cityName;
  final double temperature; // in Celsius
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int dt;
  final int sunrise;
  final int sunset;
  final double latitude;
  final double longitude;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.latitude,
    required this.longitude,
  });

  factory WeatherModel.fromOpenWeatherJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>? ?? {};
    final weatherList = json['weather'] as List<dynamic>? ?? [];
    final weatherItem = weatherList.isNotEmpty ? weatherList[0] as Map<String, dynamic> : {};
    final wind = json['wind'] as Map<String, dynamic>? ?? {};
    final sys = json['sys'] as Map<String, dynamic>? ?? {};
    final coord = json['coord'] as Map<String, dynamic>? ?? {};

    // Temperature in OpenWeatherMap is Kelvin
    double kelvinTemp = (main['temp'] != null)
        ? double.tryParse(main['temp'].toString()) ?? 300.0
        : 300.0;
    double celsius = kelvinTemp - 273.15;

    return WeatherModel(
      cityName: json['name']?.toString() ?? 'Maharashtra Region',
      temperature: celsius,
      description: weatherItem['description']?.toString() ?? 'Clear Sky',
      icon: weatherItem['icon']?.toString() ?? '01d',
      humidity: main['humidity'] != null
          ? int.tryParse(main['humidity'].toString()) ?? 60
          : 60,
      windSpeed: wind['speed'] != null
          ? double.tryParse(wind['speed'].toString()) ?? 3.5
          : 3.5,
      pressure: main['pressure'] != null
          ? int.tryParse(main['pressure'].toString()) ?? 1012
          : 1012,
      dt: json['dt'] != null
          ? int.tryParse(json['dt'].toString()) ?? (DateTime.now().millisecondsSinceEpoch ~/ 1000)
          : (DateTime.now().millisecondsSinceEpoch ~/ 1000),
      sunrise: sys['sunrise'] != null ? int.tryParse(sys['sunrise'].toString()) ?? 0 : 0,
      sunset: sys['sunset'] != null ? int.tryParse(sys['sunset'].toString()) ?? 0 : 0,
      latitude: coord['lat'] != null
          ? double.tryParse(coord['lat'].toString()) ?? 19.0760
          : 19.0760,
      longitude: coord['lon'] != null
          ? double.tryParse(coord['lon'].toString()) ?? 72.8777
          : 72.8777,
    );
  }

  String get iconUrl => "https://openweathermap.org/img/wn/$icon@4x.png";
}

class ForecastItemModel {
  final int dt;
  final double tempCelsius;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  ForecastItemModel({
    required this.dt,
    required this.tempCelsius,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory ForecastItemModel.fromJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>? ?? {};
    final weatherList = json['weather'] as List<dynamic>? ?? [];
    final weatherItem = weatherList.isNotEmpty ? weatherList[0] as Map<String, dynamic> : {};
    final wind = json['wind'] as Map<String, dynamic>? ?? {};

    double kelvinTemp = (main['temp'] != null)
        ? double.tryParse(main['temp'].toString()) ?? 300.0
        : 300.0;

    return ForecastItemModel(
      dt: json['dt'] != null ? int.tryParse(json['dt'].toString()) ?? 0 : 0,
      tempCelsius: kelvinTemp - 273.15,
      description: weatherItem['description']?.toString() ?? 'Partly Cloudy',
      icon: weatherItem['icon']?.toString() ?? '02d',
      humidity: main['humidity'] != null
          ? int.tryParse(main['humidity'].toString()) ?? 50
          : 50,
      windSpeed: wind['speed'] != null
          ? double.tryParse(wind['speed'].toString()) ?? 2.5
          : 2.5,
    );
  }

  String get iconUrl => "https://openweathermap.org/img/wn/$icon@2x.png";
}
