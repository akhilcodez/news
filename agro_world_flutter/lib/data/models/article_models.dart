class CropModel {
  final String title;
  final String imageLink;
  final String cropInfo;
  final String soil;
  final String seed;
  final String seedTreatment;
  final String timeOfSowing;
  final String landPreparation;
  final String irrigation;
  final String fertilizer;
  final String requiredTemperature;
  final String harvesting;
  final String postHarvest;
  final String season;
  final String state;

  CropModel({
    required this.title,
    required this.imageLink,
    required this.cropInfo,
    required this.soil,
    required this.seed,
    required this.seedTreatment,
    required this.timeOfSowing,
    required this.landPreparation,
    required this.irrigation,
    required this.fertilizer,
    required this.requiredTemperature,
    required this.harvesting,
    required this.postHarvest,
    required this.season,
    required this.state,
  });

  factory CropModel.fromJson(Map<String, dynamic> json) {
    return CropModel(
      title: json['title']?.toString() ?? '',
      imageLink: json['image_link']?.toString() ?? '',
      cropInfo: json['crop_info']?.toString() ?? '',
      soil: json['soil']?.toString() ?? '',
      seed: json['seed']?.toString() ?? '',
      seedTreatment: json['seed_treatment']?.toString() ?? '',
      timeOfSowing: json['Time of sowing']?.toString() ?? json['time_of_sowing']?.toString() ?? '',
      landPreparation: json['land_preparation']?.toString() ?? '',
      irrigation: json['irrigation']?.toString() ?? '',
      fertilizer: json['fertilizer']?.toString() ?? '',
      requiredTemperature: json['required_temperature ']?.toString() ?? json['required_temperature']?.toString() ?? '',
      harvesting: json['harvesting']?.toString() ?? '',
      postHarvest: json['post_harvest']?.toString() ?? '',
      season: json['season']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
    );
  }
}

class FruitModel {
  final String title;
  final String imageLink;
  final String fruitInfo;
  final String soil;
  final String seed;
  final String bestTimeToGrow;
  final String landPreparation;
  final String irrigation;
  final String requiredTemperature;
  final String harvesting;
  final String postHarvest;
  final String season;
  final String state;

  FruitModel({
    required this.title,
    required this.imageLink,
    required this.fruitInfo,
    required this.soil,
    required this.seed,
    required this.bestTimeToGrow,
    required this.landPreparation,
    required this.irrigation,
    required this.requiredTemperature,
    required this.harvesting,
    required this.postHarvest,
    required this.season,
    required this.state,
  });

  factory FruitModel.fromJson(Map<String, dynamic> json) {
    return FruitModel(
      title: json['title']?.toString() ?? '',
      imageLink: json['image_link']?.toString() ?? '',
      fruitInfo: json['fruit_info']?.toString() ?? '',
      soil: json['soil']?.toString() ?? '',
      seed: json['seed']?.toString() ?? '',
      bestTimeToGrow: json['best_time_to_grow']?.toString() ?? '',
      landPreparation: json['land_preparation']?.toString() ?? '',
      irrigation: json['irrigation']?.toString() ?? '',
      requiredTemperature: json['required_temperature ']?.toString() ?? json['required_temperature']?.toString() ?? '',
      harvesting: json['harvesting']?.toString() ?? '',
      postHarvest: json['post_harvest']?.toString() ?? '',
      season: json['season']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
    );
  }
}

class FlowerModel {
  final String title;
  final String imageLink;
  final String flowerInfo;
  final String soil;
  final String seed;
  final String bestTimeToGrow;
  final String propagation;
  final String landPreparation;
  final String irrigation;
  final String harvesting;
  final String postHarvest;
  final String season;

  FlowerModel({
    required this.title,
    required this.imageLink,
    required this.flowerInfo,
    required this.soil,
    required this.seed,
    required this.bestTimeToGrow,
    required this.propagation,
    required this.landPreparation,
    required this.irrigation,
    required this.harvesting,
    required this.postHarvest,
    required this.season,
  });

  factory FlowerModel.fromJson(Map<String, dynamic> json) {
    return FlowerModel(
      title: json['title']?.toString() ?? '',
      imageLink: json['image_link']?.toString() ?? '',
      flowerInfo: json['flower_info']?.toString() ?? '',
      soil: json['soil']?.toString() ?? '',
      seed: json['seed']?.toString() ?? '',
      bestTimeToGrow: json['best_time_to_grow']?.toString() ?? '',
      propagation: json['propagation']?.toString() ?? '',
      landPreparation: json['land_preparation']?.toString() ?? '',
      irrigation: json['irrigation']?.toString() ?? '',
      harvesting: json['harvesting']?.toString() ?? '',
      postHarvest: json['post_harvest']?.toString() ?? '',
      season: json['season']?.toString() ?? '',
    );
  }
}

class ExpandTechniqueModel {
  final String cropName;
  final String imageLink;
  final String cropInfo;
  final String seed;
  final String season;
  final String requiredTemperature;
  final String irrigation;
  final String fertilizer;
  final String harvesting;

  ExpandTechniqueModel({
    required this.cropName,
    required this.imageLink,
    required this.cropInfo,
    required this.seed,
    required this.season,
    required this.requiredTemperature,
    required this.irrigation,
    required this.fertilizer,
    required this.harvesting,
  });

  factory ExpandTechniqueModel.fromJson(Map<String, dynamic> json) {
    return ExpandTechniqueModel(
      cropName: json['crop_name']?.toString() ?? json['title']?.toString() ?? '',
      imageLink: json['image_link']?.toString() ?? '',
      cropInfo: json['crop_info']?.toString() ?? '',
      seed: json['seed']?.toString() ?? '',
      season: json['season']?.toString() ?? '',
      requiredTemperature: json['required_temperature']?.toString() ?? '',
      irrigation: json['irrigation']?.toString() ?? '',
      fertilizer: json['fertilizer']?.toString() ?? '',
      harvesting: json['harvesting']?.toString() ?? '',
    );
  }
}

class DiseaseModel {
  final String diseaseName;
  final String plantName;
  final String imageLink;
  final String symptoms;
  final String protect;

  DiseaseModel({
    required this.diseaseName,
    required this.plantName,
    required this.imageLink,
    required this.symptoms,
    required this.protect,
  });

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      diseaseName: json['disease_name']?.toString() ?? '',
      plantName: json['plant_name']?.toString() ?? '',
      imageLink: json['image_link']?.toString() ?? '',
      symptoms: json['symptoms']?.toString() ?? '',
      protect: json['protect']?.toString() ?? '',
    );
  }
}

class InsectModel {
  final String insectName;
  final String plantName;
  final String imageLink;
  final String symptoms;
  final String protect;

  InsectModel({
    required this.insectName,
    required this.plantName,
    required this.imageLink,
    required this.symptoms,
    required this.protect,
  });

  factory InsectModel.fromJson(Map<String, dynamic> json) {
    return InsectModel(
      insectName: json['insect_name']?.toString() ?? json['disease_name']?.toString() ?? '',
      plantName: json['plant_name']?.toString() ?? '',
      imageLink: json['image_link']?.toString() ?? '',
      symptoms: json['symptoms']?.toString() ?? '',
      protect: json['protect']?.toString() ?? '',
    );
  }
}
