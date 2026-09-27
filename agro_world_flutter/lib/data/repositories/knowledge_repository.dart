import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/article_models.dart';

class KnowledgeRepository {
  Future<List<CropModel>> getCrops({bool isHindi = false}) async {
    final endpoint = isHindi ? ApiConstants.cropsHi : ApiConstants.cropsEn;
    final url = Uri.parse("${ApiConstants.sheetDbBaseUrl}$endpoint");

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final List<dynamic> list = json.decode(response.body);
        return list.map((e) => CropModel.fromJson(e)).toList();
      }
    } catch (_) {}

    return _fallbackCrops(isHindi);
  }

  Future<List<FruitModel>> getFruits({bool isHindi = false}) async {
    final endpoint = isHindi ? ApiConstants.fruitsHi : ApiConstants.fruitsEn;
    final url = Uri.parse("${ApiConstants.sheetDbBaseUrl}$endpoint");

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final List<dynamic> list = json.decode(response.body);
        return list.map((e) => FruitModel.fromJson(e)).toList();
      }
    } catch (_) {}

    return _fallbackFruits(isHindi);
  }

  Future<List<FlowerModel>> getFlowers({bool isHindi = false}) async {
    final endpoint = isHindi ? ApiConstants.flowersHi : ApiConstants.flowersEn;
    final url = Uri.parse("${ApiConstants.sheetDbBaseUrl}$endpoint");

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final List<dynamic> list = json.decode(response.body);
        return list.map((e) => FlowerModel.fromJson(e)).toList();
      }
    } catch (_) {}

    return _fallbackFlowers(isHindi);
  }

  Future<List<ExpandTechniqueModel>> getTechniques({bool isHindi = false}) async {
    final endpoint = isHindi ? ApiConstants.expandHi : ApiConstants.expandEn;
    final url = Uri.parse("${ApiConstants.sheetDbBaseUrl}$endpoint");

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final List<dynamic> list = json.decode(response.body);
        return list.map((e) => ExpandTechniqueModel.fromJson(e)).toList();
      }
    } catch (_) {}

    return _fallbackTechniques(isHindi);
  }

  Future<List<DiseaseModel>> getDiseases({bool isHindi = false}) async {
    final endpoint = isHindi ? ApiConstants.diseasesHi : ApiConstants.diseasesEn;
    final url = Uri.parse("${ApiConstants.sheetDbBaseUrl}$endpoint");

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final List<dynamic> list = json.decode(response.body);
        return list.map((e) => DiseaseModel.fromJson(e)).toList();
      }
    } catch (_) {}

    return _fallbackDiseases(isHindi);
  }

  Future<List<InsectModel>> getInsects({bool isHindi = false}) async {
    final endpoint = isHindi ? ApiConstants.insectsHi : ApiConstants.insectsEn;
    final url = Uri.parse("${ApiConstants.sheetDbBaseUrl}$endpoint");

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final List<dynamic> list = json.decode(response.body);
        return list.map((e) => InsectModel.fromJson(e)).toList();
      }
    } catch (_) {}

    return _fallbackInsects(isHindi);
  }

  List<CropModel> _fallbackCrops(bool isHindi) {
    if (isHindi) {
      return [
        CropModel(
          title: "गेहूं (Wheat)",
          imageLink: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=600",
          cropInfo: "गेहूं रबी मौसम की प्रमुख अनाज फसल है। यह भारत की दूसरी सबसे महत्वपूर्ण खाद्य फसल है।",
          soil: "अच्छी जल निकासी वाली दोमट या बलुई दोमट मिट्टी सबसे उपयुक्त है।",
          seed: "100-125 किलोग्राम प्रति हेक्टेयर। उन्नत किस्में: HD 2967, PBW 343, DBW 187।",
          seedTreatment: "थीरम या बाविस्टिन 2.5 ग्राम प्रति किलो बीज की दर से उपचारित करें।",
          timeOfSowing: "15 नवंबर से 30 नवंबर का समय सर्वोत्तम है।",
          landPreparation: "खेत को 2-3 बार गहरी जुताई करके पाटा लगाकर समतल करें।",
          irrigation: "पहली सिंचाई सीआरआई अवस्था (21 दिन) पर अवश्य करें, कुल 4-6 सिंचाई।",
          fertilizer: "120 किग्रा नाइट्रोजन, 60 किग्रा फास्फोरस, 40 किग्रा पोटाश प्रति हेक्टेयर।",
          requiredTemperature: "15°C से 25°C तापमान अंकुरण और वृद्धि के लिए अनुकूल है।",
          harvesting: "बालियां पीली पड़ने और दाना कड़ा होने पर कटाई करें।",
          postHarvest: "दानों में नमी 10-12% रहने तक धूप में सुखाकर भंडारण करें।",
          season: "रबी (सर्दियां)",
          state: "पंजाब, हरियाणा, उत्तर प्रदेश, मध्य प्रदेश, महाराष्ट्र",
        ),
        CropModel(
          title: "चावल / धान (Rice)",
          imageLink: "https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?w=600",
          cropInfo: "धान खरीफ मौसम की मुख्य खाद्य फसल है जो भारत की बहुसंख्यक आबादी का भोजन है।",
          soil: "मटियार या चिकनी दोमट मिट्टी जिसमें जल धारण क्षमता अधिक हो।",
          seed: "रोपाई विधि के लिए 35-40 किग्रा प्रति हेक्टेयर।",
          seedTreatment: "कार्बेंडाजिम 2 ग्राम प्रति किग्रा बीज।",
          timeOfSowing: "जून से जुलाई।",
          landPreparation: "खेत में 5-7 सेमी पानी भरकर अच्छी तरह गारा (पडलिंग) तैयार करें।",
          irrigation: "खेत में कल्ले फूटने और फूल आने तक 3-5 सेमी पानी बना रहे।",
          fertilizer: "100:50:50 N:P:K प्रति हेक्टेयर और 25 किग्रा जिंक सल्फेट।",
          requiredTemperature: "22°C से 32°C तापमान।",
          harvesting: "80% बालियां सुनहरी पीली होने पर कटाई करें।",
          postHarvest: "दौनी के बाद 12-14% नमी पर सुरक्षित भंडारण।",
          season: "खरीफ (वर्षा ऋतु)",
          state: "पश्चिम बंगाल, उत्तर प्रदेश, आंध्र प्रदेश, पंजाब",
        ),
      ];
    }
    return [
      CropModel(
        title: "Wheat",
        imageLink: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=600",
        cropInfo: "Wheat is the most important cereal grain in temperate climates and a major staple crop across India.",
        soil: "Well-drained fertile loamy to clay loam soils with neutral pH 6.0 to 7.5.",
        seed: "100-125 kg/hectare. Certified varieties: HD 2967, PBW 550, Shriram Super.",
        seedTreatment: "Treat seed with Thiram or Carbendazim @ 2.5g/kg seed before sowing.",
        timeOfSowing: "First fortnight of November to late November.",
        landPreparation: "Plough 2-3 times followed by harrowing and leveling for uniform moisture.",
        irrigation: "Critical CRI stage at 20-25 days after sowing; total 4 to 6 light irrigations.",
        fertilizer: "Recommended NPK ratio 120:60:40 kg/ha with basal and split urea dressing.",
        requiredTemperature: "15°C to 24°C during growth and sunny dry weather at ripening.",
        harvesting: "Harvest when straw turns yellow-golden and grain moisture drops below 20%.",
        postHarvest: "Thresh, clean and dry grains under sun until moisture reaches 10-12%.",
        season: "Rabi (Winter)",
        state: "Punjab, Haryana, Uttar Pradesh, Madhya Pradesh, Maharashtra",
      ),
      CropModel(
        title: "Rice / Paddy",
        imageLink: "https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?w=600",
        cropInfo: "Paddy is India's principal food grain crop, feeding more than half of the national population.",
        soil: "Heavy clay and clay loam soils with high water holding capacity.",
        seed: "35-40 kg/ha for nursery transplanting; 20-25 kg for SRI technique.",
        seedTreatment: "Salt water test followed by Bavistin treatment @ 2g/kg.",
        timeOfSowing: "May-June for nursery; June-July for field transplantation.",
        landPreparation: "Thorough puddling with standing water to create an impervious pan.",
        irrigation: "Continuous shallow ponding of 2-5 cm during tillering to panicle emergence.",
        fertilizer: "NPK 120:60:60 kg/ha with Zinc Sulphate 25 kg/ha basal.",
        requiredTemperature: "22°C to 35°C with abundant sunshine.",
        harvesting: "Drain water 10 days before harvest; cut when 80% grains are golden.",
        postHarvest: "Thresh immediately and sun-dry grains down to 12% moisture.",
        season: "Kharif (Monsoon)",
        state: "West Bengal, Uttar Pradesh, Punjab, Andhra Pradesh, Tamil Nadu",
      ),
    ];
  }

  List<FruitModel> _fallbackFruits(bool isHindi) {
    return [
      FruitModel(
        title: isHindi ? "आम (Mango)" : "Mango",
        imageLink: "https://images.unsplash.com/photo-1553279768-865429fa0078?w=600",
        fruitInfo: isHindi
            ? "फलों का राजा आम भारत का राष्ट्रीय फल है। अल्फांसो, दशहरी, लंगड़ा प्रमुख किस्में हैं।"
            : "King of Fruits. Famous cultivars include Alphonso, Kesar, Dasheri, and Banganapalli.",
        soil: "Deep alluvial, red loamy soil with pH 5.5 to 7.5.",
        seed: "Grafted saplings (Veneer or Inarching).",
        bestTimeToGrow: "July to August (Monsoon planting).",
        landPreparation: "Dig pits of 1m x 1m x 1m, fill with topsoil and 50kg FYM.",
        irrigation: "Regular irrigation in summer; withhold irrigation 2 months prior to flowering.",
        requiredTemperature: "24°C to 30°C.",
        harvesting: "Harvest at physiological maturity when shoulder rounds and tap drops.",
        postHarvest: "Grading, hot water treatment for fruit fly, and ethylene ripening chambers.",
        season: "Summer",
        state: "Maharashtra, Uttar Pradesh, Andhra Pradesh, Gujarat",
      ),
      FruitModel(
        title: isHindi ? "केला (Banana)" : "Banana",
        imageLink: "https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=600",
        fruitInfo: isHindi
            ? "केला एक प्रमुख नकदी फल फसल है जो साल भर फल देता है। ग्रैंड नैने (G9) सबसे लोकप्रिय है।"
            : "High yielding cash fruit crop. Grand Naine (G9) tissue culture plants are industry standard.",
        soil: "Rich loamy soil with good drainage and rich in organic matter.",
        seed: "Tissue culture plantlets or healthy sword suckers (1.5-2.0 kg).",
        bestTimeToGrow: "June-July or October-November.",
        landPreparation: "Plough deeply, incorporate 25 tonnes FYM per hectare.",
        irrigation: "Drip irrigation recommended (15-20 liters per plant per day in summer).",
        requiredTemperature: "20°C to 35°C.",
        harvesting: "Harvest bunches 90-110 days after flowering when angles turn round.",
        postHarvest: "De-handing, washing in alum water, grading and cold chain storage at 13°C.",
        season: "All Year",
        state: "Maharashtra, Tamil Nadu, Gujarat, Andhra Pradesh",
      ),
    ];
  }

  List<FlowerModel> _fallbackFlowers(bool isHindi) {
    return [
      FlowerModel(
        title: isHindi ? "गुलाब (Rose)" : "Dutch & Desi Rose",
        imageLink: "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=600",
        flowerInfo: isHindi
            ? "गुलाब फूलों का राजा है, सजावट और इत्र उद्योग में अत्यधिक मांग।"
            : "High-value commercial flower grown in open fields and climate-controlled polyhouses.",
        soil: "Well-drained sandy loam soil rich in organic matter, pH 6.0-6.5.",
        seed: "Budded plants on Edward or Multiflora rootstock.",
        bestTimeToGrow: "October to November.",
        propagation: "T-budding or stem cuttings.",
        landPreparation: "Deep ploughing, beds 1m wide with 40cm walking path.",
        irrigation: "Drip fertigation with water-soluble fertilizers.",
        harvesting: "Harvest in early morning at tight bud stage with calyx reflexed.",
        postHarvest: "Pulsing in sucrose-aluminum sulphate solution; cold store at 2°C.",
        season: "Winter & Spring",
      ),
      FlowerModel(
        title: isHindi ? "गेंदा (Marigold)" : "African Marigold",
        imageLink: "https://images.unsplash.com/photo-1597848212624-a19eb35e2651?w=600",
        flowerInfo: isHindi
            ? "त्योहारों और माला बनाने के लिए गेंदा सबसे ज्यादा बिकने वाला फूल है।"
            : "Extensively cultivated for festive garlands, landscape borders, and natural lutein pigment.",
        soil: "Tolerates wide range of soils, best in well-drained sandy loam.",
        seed: "1.5 kg seeds/ha for open pollinated; 250g for F1 hybrids.",
        bestTimeToGrow: "Year-round in three seasons (Rainy, Winter, Summer).",
        propagation: "Seeds and apical cuttings.",
        landPreparation: "Fine tilth beds with 20 tonnes compost.",
        irrigation: "Weekly irrigation in winter, 4-5 days in hot summer.",
        harvesting: "Pluck fully opened flowers in evening or early morning.",
        postHarvest: "Pack in airy bamboo baskets or net bags for morning mandi delivery.",
        season: "All Year",
      ),
    ];
  }

  List<ExpandTechniqueModel> _fallbackTechniques(bool isHindi) {
    return [
      ExpandTechniqueModel(
        cropName: isHindi ? "ड्रिप सिंचाई प्रणाली" : "Precision Drip Irrigation",
        imageLink: "https://images.unsplash.com/photo-1563514227147-6d2ff665a6a0?w=600",
        cropInfo: isHindi
            ? "ड्रिप सिंचाई से 60% पानी की बचत और 30-40% अधिक पैदावार होती है। फर्टिगेशन से सीधे जड़ों तक खाद पहुंचती है।"
            : "Delivers water and soluble nutrients directly to plant root zones, saving 50-70% water and increasing crop yields by 30-40%.",
        seed: "Applicable to vegetables, fruits, sugarcane, and cotton.",
        season: "All seasons",
        requiredTemperature: "Adaptable to all climates",
        irrigation: "Controlled micro-tubes with pressure compensating drippers (2-4 LPH).",
        fertilizer: "Water soluble 19:19:19 and calcium nitrate via venturi injector.",
        harvesting: "Enables uniform maturity and earlier market entry.",
      ),
      ExpandTechniqueModel(
        cropName: isHindi ? "पॉलीहाउस खेती (Polyhouse)" : "Protected Polyhouse Farming",
        imageLink: "https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?w=600",
        cropInfo: isHindi
            ? "बेमौसम सब्जियों (शिमला मिर्च, खीरा, टमाटर) और डच गुलाब की खेती के लिए सर्वोत्तम संरक्षित तकनीक।"
            : "Climate-controlled farming protecting crops from heavy rain, pests, hail, and extreme temperatures.",
        seed: "Indeterminate hybrid seeds and parthenocarpic cucumbers.",
        season: "Round the year off-season production",
        requiredTemperature: "Maintained 20°C to 28°C via misting and fan-pads.",
        irrigation: "Automated drip and fogging systems.",
        fertilizer: "Complete computerized fertigation schedule.",
        harvesting: "Continuous harvest with premium export quality produce.",
      ),
    ];
  }

  List<DiseaseModel> _fallbackDiseases(bool isHindi) {
    return [
      DiseaseModel(
        diseaseName: isHindi ? "ब्लाइट / झुलसा रोग" : "Late Blight",
        plantName: isHindi ? "आलू एवं टमाटर" : "Potato & Tomato",
        imageLink: "https://images.unsplash.com/photo-1592417817098-8f3d6910985c?w=600",
        symptoms: isHindi
            ? "पत्तियों पर भूरे-काले पानीदार धब्बे, जो बाद में पूरी पत्ती को झुलसा देते हैं। फफूंद जैसा सफेद पाउडर नीचे दिखता है।"
            : "Water-soaked irregular dark brown lesions on leaves and stems with white fungal mold under humid conditions.",
        protect: isHindi
            ? "रोकथाम: मैंकोजेब (Mancozeb) 2.5 ग्राम प्रति लीटर या रिडोमिल गोल्ड (Ridomil Gold) 2 ग्राम प्रति लीटर पानी में मिलाकर छिड़काव करें।"
            : "Control: Spray Mancozeb @ 2.5 g/L preventively or Metalaxyl + Mancozeb (Ridomil Gold) @ 2 g/L on symptom onset. Ensure crop rotation.",
      ),
      DiseaseModel(
        diseaseName: isHindi ? "पाउडरी मिल्ड्यू (चूर्णी फफूंद)" : "Powdery Mildew",
        plantName: isHindi ? "अंगूर, मटर, मिर्च, खीरा" : "Grapes, Peas, Chilli, Cucurbits",
        imageLink: "https://images.unsplash.com/photo-1530595467537-0b5996c41f2d?w=600",
        symptoms: isHindi
            ? "पत्तियों की ऊपरी सतह पर सफेद आटे जैसा चूर्ण फैल जाता है। पत्तियां पीली होकर सूखने लगती हैं।"
            : "White talcum powder-like fungal patches on leaf surfaces leading to yellowing, leaf curl, and premature defoliation.",
        protect: isHindi
            ? "रोकथाम: घुलनशील गंधक (Sulfur 80% WDG) 3 ग्राम या हेक्साकोनाजोल (Contaf) 1 मिली प्रति लीटर पानी में स्प्रे करें।"
            : "Control: Spray Wettable Sulfur (Sulfex) @ 3 g/L or Hexaconazole 5% EC @ 1 ml/L. Avoid dense planting and excessive nitrogen.",
      ),
    ];
  }

  List<InsectModel> _fallbackInsects(bool isHindi) {
    return [
      InsectModel(
        insectName: isHindi ? "सफेद मक्खी (Whitefly)" : "Whitefly (Bemisia tabaci)",
        plantName: isHindi ? "कपास, टमाटर, बैंगन, भिंडी" : "Cotton, Tomato, Brinjal, Okra",
        imageLink: "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=600",
        symptoms: isHindi
            ? "पत्तियों का रस चूसती हैं और पीला मोजेक वायरस फैलाती हैं। पत्तियों पर चिपचिपा स्राव छोड़ती हैं।"
            : "Sap sucking nymph and adult clusters on undersides of leaves, causing chlorosis, leaf curl, and transmitting yellow mosaic virus.",
        protect: isHindi
            ? "रोकथाम: पीले चिपचिपे कार्ड (Yellow Sticky Traps) लगाएं। नीम तेल 5 मिली या एसिटामिप्रिड 20% SP 0.5 ग्राम प्रति लीटर स्प्रे करें।"
            : "Control: Install Yellow Sticky Traps (15-20 traps/acre). Spray Neem Oil (10,000 ppm) @ 3 ml/L or Acetamiprid 20% SP @ 0.5 g/L.",
      ),
      InsectModel(
        insectName: isHindi ? "तना छेदक (Stem Borer)" : "Stem Borer & Fruit Borer",
        plantName: isHindi ? "धान, मक्का, बैंगन" : "Paddy, Maize, Brinjal",
        imageLink: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=600",
        symptoms: isHindi
            ? "सूखा पौधा (डेड हार्ट) और सफेद बालियां (व्हाइट इयर हेड)। तने के अंदर इल्ली घुसकर तने को खोखला कर देती है।"
            : "Dead heart during vegetative phase and white earheads with chaffy grains during reproductive stage.",
        protect: isHindi
            ? "रोकथाम: फेरोमोन ट्रैप लगाएं। क्लोरेंट्रानिलिप्रोल (Coragen) 0.4 मिली या कारटाप हाइड्रोक्लोराइड 4% जी 10 किग्रा/एकड़ डालें।"
            : "Control: Install Pheromone traps @ 5/acre. Apply Cartap Hydrochloride 4G @ 8 kg/acre or Chlorantraniliprole 18.5% SC (Coragen) @ 0.4 ml/L.",
      ),
    ];
  }
}
