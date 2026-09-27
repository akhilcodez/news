import 'package:flutter_test/flutter_test.dart';
import 'package:agroworld_flutter/data/models/recommendation_models.dart';
import 'package:agroworld_flutter/data/repositories/smart_tools_repository.dart';

void main() {
  group('SmartToolsRepository Tests', () {
    final repository = SmartToolsRepository();

    test('Crop recommendation returns sorted matching candidates', () async {
      final input = CropRecommendationInput(
        nitrogen: 80,
        phosphorus: 50,
        potassium: 50,
        temperature: 28,
        humidity: 80,
        ph: 6.5,
        rainfall: 200,
        soilType: 'Alluvial Loam',
      );

      final results = await repository.getCropRecommendations(input);
      expect(results.isNotEmpty, true);
      expect(results.first.confidence >= results.last.confidence, true);
      expect(results.any((r) => r.cropName.contains('Rice')), true);
    });

    test('Fertilizer recommendation diagnoses nitrogen deficit correctly', () async {
      final input = FertilizerRecommendationInput(
        cropName: 'Wheat',
        soilType: 'Black Cotton Soil',
        nitrogen: 30, // low nitrogen
        phosphorus: 50,
        potassium: 50,
        moisture: 45,
      );

      final result = await repository.getFertilizerRecommendation(input);
      expect(result.recommendedFertilizer.contains('Urea'), true);
      expect(result.dosagePerAcre.isNotEmpty, true);
    });

    test('Yield prediction computes realistic harvest and revenue estimates', () async {
      final input = YieldPredictionInput(
        cropName: 'Rice (Paddy)',
        areaAcres: 5.0,
        season: 'Kharif',
        irrigationType: 'Drip Irrigation',
        fertilizerUsageKg: 65,
        annualRainfallMm: 1100,
      );

      final result = await repository.predictCropYield(input);
      expect(result.estimatedYieldQuintals > 0, true);
      expect(result.yieldPerAcre > 0, true);
      expect(result.estimatedMaxRevenue > result.estimatedMinRevenue, true);
      expect(result.optimizationSteps.isNotEmpty, true);
    });

    test('Market prices returns filtered APMC mandi commodities', () async {
      final results = await repository.getMarketPrices(query: 'Onion');
      expect(results.isNotEmpty, true);
      expect(results.first.commodity.toLowerCase().contains('onion'), true);
      expect(results.first.modalPrice > 0, true);
    });

    test('Disease diagnosis returns symptoms and chemical/biological controls', () async {
      final results = await repository.diagnoseCropDisease(crop: 'Tomato');
      expect(results.isNotEmpty, true);
      expect(results.first.chemicalControl.isNotEmpty, true);
      expect(results.first.biologicalControl.isNotEmpty, true);
    });
  });
}
