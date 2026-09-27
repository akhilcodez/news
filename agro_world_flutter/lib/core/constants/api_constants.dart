class ApiConstants {
  static const String openWeatherApiKey = "92f4e9a9c233be99f0b33d1c58c72386";
  static const String weatherBaseUrl = "https://api.openweathermap.org/data/2.5/";
  static const String sheetDbBaseUrl = "https://sheetdb.io/api/v1/";
  
  // SheetDB API IDs
  static const String cropsEn = "54hyqipsecvsw";
  static const String cropsHi = "te4foxozbz2rk";
  static const String fruitsEn = "0kofxd6x0muzp";
  static const String fruitsHi = "9ax3hlz0utbby";
  static const String flowersEn = "jzqcnwnhd7pms";
  static const String flowersHi = "bekl2o7zqgxb8";
  static const String expandEn = "hw7m9n2kxvupq";
  static const String expandHi = "qy85vf93vhlbc";
  static const String diseasesEn = "pak7qin2yt7i8";
  static const String diseasesHi = "cstwpz7gpz1da";
  static const String insectsEn = "jvv0uk3btu7ln";
  static const String insectsHi = "fg3ysaf8mkyxo";

  // BrainShop AI ChatBot
  static const String brainId = "174019";
  static const String chatBotApiKey = "HC5OGdHhUQPzfMOy";
  static const String brainShopBaseUrl = "http://api.brainshop.ai/get";

  // Razorpay
  static const String razorpayKeyId = "rzp_test_HrFw0vaoVIDlP9";

  // Web & News URLs
  static const String englishNewsUrl = "https://krishijagran.com/news";
  static const String hindiNewsUrl = "https://hindi.krishijagran.com/news";
  static const String aboutUsUrl = "https://elastic-homegrown-53c.notion.site/AgroWorld-db0062bdf0ff4596a645186227edd9f8";
  static const String privacyPolicyUrl = "https://www.freeprivacypolicy.com/live/7de1b1a3-b257-4e98-b2ab-ed989935719b";
  static const String supportPhone = "+918087477015";
  static const String supportEmail = "agroworldapp@gmail.com";

  // Python Flask ML Microservice & PHP Gateway
  static String flaskBaseUrl = "http://127.0.0.1:5050";
  static String phpBaseUrl = "http://127.0.0.1/backend/php_api";

  // Android Emulator loopback alias
  static const String emulatorFlaskBaseUrl = "http://10.0.2.2:5050";

  // ML REST Endpoints
  static const String predictCropEndpoint = "/api/predict/crop";
  static const String predictFertilizerEndpoint = "/api/predict/fertilizer";
  static const String predictYieldEndpoint = "/api/predict/yield";
  static const String predictDiseaseEndpoint = "/api/predict/disease";
  static const String marketPricesEndpoint = "/api/market/prices";
  static const String healthEndpoint = "/api/health";
}
