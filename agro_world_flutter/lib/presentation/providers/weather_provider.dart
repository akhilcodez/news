import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import '../../data/repositories/weather_repository.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository _repository = WeatherRepository();

  WeatherModel? _currentWeather;
  List<ForecastItemModel> _forecastList = [];
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get currentWeather => _currentWeather;
  List<ForecastItemModel> get forecastList => _forecastList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  WeatherProvider() {
    loadWeatherData();
  }

  Future<void> loadWeatherData({double lat = 19.0760, double lon = 72.8777}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final weather = await _repository.fetchCurrentWeather(lat: lat, lon: lon);
      final forecast = await _repository.fetchForecast(lat: lat, lon: lon);
      _currentWeather = weather;
      _forecastList = forecast;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
