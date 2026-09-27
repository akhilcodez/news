import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class LanguageProvider extends ChangeNotifier {
  bool _isHindi = false;

  bool get isHindi => _isHindi;
  String get currentLanguageCode => _isHindi ? 'hi' : 'en';

  LanguageProvider() {
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isHindi = prefs.getBool(AppConstants.prefIsHindi) ?? false;
    notifyListeners();
  }

  Future<void> setLanguage(bool isHindi) async {
    _isHindi = isHindi;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefIsHindi, isHindi);
    notifyListeners();
  }

  void toggleLanguage() {
    setLanguage(!_isHindi);
  }
}
