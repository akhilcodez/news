import 'package:flutter/foundation.dart';
import '../../core/network/api_client.dart';
import '../../data/models/recommendation_models.dart';
import '../../data/repositories/smart_tools_repository.dart';

class SmartToolsProvider extends ChangeNotifier {
  final SmartToolsRepository _repository = SmartToolsRepository();

  SmartToolsProvider() {
    checkBackendHealth();
  }

  // 1. Crop Recommendation State
  bool _isLoadingCropRec = false;
  List<CropRecommendationResult> _cropRecommendations = [];
  String? _cropRecError;

  bool get isLoadingCropRec => _isLoadingCropRec;
  List<CropRecommendationResult> get cropRecommendations => _cropRecommendations;
  String? get cropRecError => _cropRecError;

  Future<void> recommendCrops(CropRecommendationInput input, {bool isHindi = false}) async {
    _isLoadingCropRec = true;
    _cropRecError = null;
    notifyListeners();

    try {
      _cropRecommendations = await _repository.getCropRecommendations(input, isHindi: isHindi);
    } catch (e) {
      _cropRecError = e.toString();
    } finally {
      _isLoadingCropRec = false;
      notifyListeners();
    }
  }

  // 2. Fertilizer Recommendation State
  bool _isLoadingFertilizer = false;
  FertilizerRecommendationResult? _fertilizerResult;
  String? _fertilizerError;

  bool get isLoadingFertilizer => _isLoadingFertilizer;
  FertilizerRecommendationResult? get fertilizerResult => _fertilizerResult;
  String? get fertilizerError => _fertilizerError;

  Future<void> recommendFertilizer(FertilizerRecommendationInput input, {bool isHindi = false}) async {
    _isLoadingFertilizer = true;
    _fertilizerError = null;
    notifyListeners();

    try {
      _fertilizerResult = await _repository.getFertilizerRecommendation(input, isHindi: isHindi);
    } catch (e) {
      _fertilizerError = e.toString();
    } finally {
      _isLoadingFertilizer = false;
      notifyListeners();
    }
  }

  // 3. Yield Prediction State
  bool _isLoadingYield = false;
  YieldPredictionResult? _yieldResult;
  String? _yieldError;

  bool get isLoadingYield => _isLoadingYield;
  YieldPredictionResult? get yieldResult => _yieldResult;
  String? get yieldError => _yieldError;

  Future<void> predictYield(YieldPredictionInput input, {bool isHindi = false}) async {
    _isLoadingYield = true;
    _yieldError = null;
    notifyListeners();

    try {
      _yieldResult = await _repository.predictCropYield(input, isHindi: isHindi);
    } catch (e) {
      _yieldError = e.toString();
    } finally {
      _isLoadingYield = false;
      notifyListeners();
    }
  }

  // 4. Market / Mandi Prices State
  bool _isLoadingPrices = false;
  List<MarketPriceModel> _marketPrices = [];
  String _selectedDistrict = "All Locations";
  String _priceSearchQuery = "";

  bool get isLoadingPrices => _isLoadingPrices;
  List<MarketPriceModel> get marketPrices => _marketPrices;
  String get selectedDistrict => _selectedDistrict;
  String get priceSearchQuery => _priceSearchQuery;

  Future<void> fetchMarketPrices({
    String? query,
    String? district,
    bool isHindi = false,
  }) async {
    _isLoadingPrices = true;
    if (query != null) _priceSearchQuery = query;
    if (district != null) _selectedDistrict = district;
    notifyListeners();

    try {
      _marketPrices = await _repository.getMarketPrices(
        query: _priceSearchQuery,
        district: _selectedDistrict,
        isHindi: isHindi,
      );
    } catch (_) {
      _marketPrices = [];
    } finally {
      _isLoadingPrices = false;
      notifyListeners();
    }
  }

  // 5. Disease Diagnostic State
  bool _isLoadingDisease = false;
  List<DiseaseDiagnosisResult> _diagnosisResults = [];

  bool get isLoadingDisease => _isLoadingDisease;
  List<DiseaseDiagnosisResult> get diagnosisResults => _diagnosisResults;

  Future<void> diagnoseCropDisease({
    String? crop,
    String? keywords,
    List<int>? imageBytes,
    String? filename,
    bool isHindi = false,
  }) async {
    _isLoadingDisease = true;
    notifyListeners();

    try {
      _diagnosisResults = await _repository.diagnoseCropDisease(
        crop: crop,
        symptomKeywords: keywords,
        imageBytes: imageBytes,
        filename: filename,
        isHindi: isHindi,
      );
    } catch (_) {
      _diagnosisResults = [];
    } finally {
      _isLoadingDisease = false;
      notifyListeners();
    }
  }

  // Backend connection status
  bool _isBackendOnline = false;
  bool get isBackendOnline => _isBackendOnline;

  Future<void> checkBackendHealth() async {
    _isBackendOnline = await ApiClient().checkBackendHealth();
    notifyListeners();
  }
}
