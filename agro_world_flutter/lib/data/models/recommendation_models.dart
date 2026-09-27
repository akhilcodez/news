class CropRecommendationInput {
  final double nitrogen;
  final double phosphorus;
  final double potassium;
  final double temperature;
  final double humidity;
  final double ph;
  final double rainfall;
  final String soilType;

  CropRecommendationInput({
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.temperature,
    required this.humidity,
    required this.ph,
    required this.rainfall,
    required this.soilType,
  });
}

class CropRecommendationResult {
  final String cropName;
  final String cropNameHi;
  final double confidence;
  final String season;
  final String waterRequirement;
  final String durationDays;
  final String reason;
  final String tips;
  final String imageUrl;

  CropRecommendationResult({
    required this.cropName,
    required this.cropNameHi,
    required this.confidence,
    required this.season,
    required this.waterRequirement,
    required this.durationDays,
    required this.reason,
    required this.tips,
    required this.imageUrl,
  });
}

class FertilizerRecommendationInput {
  final String cropName;
  final String soilType;
  final double nitrogen;
  final double phosphorus;
  final double potassium;
  final double moisture;

  FertilizerRecommendationInput({
    required this.cropName,
    required this.soilType,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.moisture,
  });
}

class FertilizerRecommendationResult {
  final String recommendedFertilizer;
  final String recommendedFertilizerHi;
  final String deficiencyType;
  final String dosagePerAcre;
  final String applicationStage;
  final String organicAlternative;
  final String precautions;

  FertilizerRecommendationResult({
    required this.recommendedFertilizer,
    required this.recommendedFertilizerHi,
    required this.deficiencyType,
    required this.dosagePerAcre,
    required this.applicationStage,
    required this.organicAlternative,
    required this.precautions,
  });
}

class YieldPredictionInput {
  final String cropName;
  final double areaAcres;
  final String season;
  final String irrigationType;
  final double fertilizerUsageKg;
  final double annualRainfallMm;

  YieldPredictionInput({
    required this.cropName,
    required this.areaAcres,
    required this.season,
    required this.irrigationType,
    required this.fertilizerUsageKg,
    required this.annualRainfallMm,
  });
}

class YieldPredictionResult {
  final double estimatedYieldQuintals;
  final double yieldPerAcre;
  final double estimatedMinRevenue;
  final double estimatedMaxRevenue;
  final String riskAssessment;
  final List<String> optimizationSteps;

  YieldPredictionResult({
    required this.estimatedYieldQuintals,
    required this.yieldPerAcre,
    required this.estimatedMinRevenue,
    required this.estimatedMaxRevenue,
    required this.riskAssessment,
    required this.optimizationSteps,
  });
}

class MarketPriceModel {
  final String commodity;
  final String commodityHi;
  final String mandi;
  final String district;
  final double minPrice;
  final double maxPrice;
  final double modalPrice;
  final double priceChangePercent;
  final String arrivalDate;
  final String unit;

  MarketPriceModel({
    required this.commodity,
    required this.commodityHi,
    required this.mandi,
    required this.district,
    required this.minPrice,
    required this.maxPrice,
    required this.modalPrice,
    required this.priceChangePercent,
    required this.arrivalDate,
    this.unit = "₹/Quintal",
  });

  factory MarketPriceModel.fromJson(Map<String, dynamic> json) {
    return MarketPriceModel(
      commodity: json['commodity'] ?? '',
      commodityHi: json['commodityHi'] ?? json['commodity'] ?? '',
      mandi: json['mandi'] ?? '',
      district: json['district'] ?? '',
      minPrice: (json['minPrice'] as num?)?.toDouble() ?? 0.0,
      maxPrice: (json['maxPrice'] as num?)?.toDouble() ?? 0.0,
      modalPrice: (json['modalPrice'] as num?)?.toDouble() ?? 0.0,
      priceChangePercent: (json['priceChangePercent'] as num?)?.toDouble() ?? 0.0,
      arrivalDate: json['arrivalDate'] ?? '',
      unit: json['unit'] ?? "₹/Quintal",
    );
  }
}

class DiseaseDiagnosisResult {
  final String diseaseName;
  final String diseaseNameHi;
  final String cropAffected;
  final double confidencePercentage;
  final String symptoms;
  final String chemicalControl;
  final String biologicalControl;
  final String preventionTip;
  final String referenceImageUrl;

  DiseaseDiagnosisResult({
    required this.diseaseName,
    required this.diseaseNameHi,
    required this.cropAffected,
    required this.confidencePercentage,
    required this.symptoms,
    required this.chemicalControl,
    required this.biologicalControl,
    required this.preventionTip,
    required this.referenceImageUrl,
  });
}
