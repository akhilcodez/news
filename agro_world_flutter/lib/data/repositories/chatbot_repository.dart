import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';

class ChatBotRepository {
  Future<String> getReply(String userMessage) async {
    final cleanMsg = userMessage.replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '-').replaceAll(' ', '-');
    final url = Uri.parse(
      "${ApiConstants.brainShopBaseUrl}?bid=${ApiConstants.brainId}&key=${ApiConstants.chatBotApiKey}&uid=1&msg=$cleanMsg",
    );

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['cnt'] != null && data['cnt'].toString().trim().isNotEmpty) {
          return data['cnt'].toString();
        }
      }
    } catch (_) {}

    // Contextual agricultural intelligent assistant fallback
    final lower = userMessage.toLowerCase();
    if (lower.contains('wheat') || lower.contains('गेहूं')) {
      return "For wheat, ensure sowing between Nov 15-30. Apply CRI irrigation at 21 days and use certified seeds like HD-2967 or Shriram 303.";
    } else if (lower.contains('fertilizer') || lower.contains('खाद') || lower.contains('urea')) {
      return "Apply balanced NPK as per soil test recommendations. Avoid over-applying Urea as it increases succulent vegetative growth and pest vulnerability.";
    } else if (lower.contains('water') || lower.contains('irrigation') || lower.contains('सिंचाई')) {
      return "Drip irrigation is highly recommended for water efficiency. Schedule watering in early mornings or late evenings to prevent fungal blight and evaporation loss.";
    } else if (lower.contains('pest') || lower.contains('disease') || lower.contains('कीट') || lower.contains('रोग')) {
      return "Check the AgroWorld Disease & Pest guide in the Education tab. For sucking pests, use Neem oil or yellow sticky traps before applying chemical insecticides.";
    } else if (lower.contains('price') || lower.contains('seed') || lower.contains('खरीदना')) {
      return "Check out our Seeds Shopping tab to purchase certified seeds directly from verified manufacturers at competitive prices!";
    } else if (lower.contains('transport') || lower.contains('गाड़ी') || lower.contains('गाडी')) {
      return "You can find nearby tractors, pickup trucks and tempos in the Transport tab, filter by your district, and call owners directly!";
    }

    return "Hello farmer! I am your AgroWorld AI Assistant. Ask me anything about crop diseases, fertilizers, sowing seasons, seed varieties, or transport!";
  }
}
