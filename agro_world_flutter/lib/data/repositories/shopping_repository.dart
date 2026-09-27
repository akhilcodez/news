import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class ShoppingRepository {
  List<ProductModel> _cachedProducts = [];
  final List<ProductModel> _cartItems = [];

  Future<List<ProductModel>> getProducts({bool isHindi = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final customJson = prefs.getString("custom_products_${isHindi ? 'hi' : 'en'}");
    List<ProductModel> customList = [];
    if (customJson != null) {
      final List<dynamic> decoded = json.decode(customJson);
      customList = decoded.map((e) => ProductModel.fromJson(e)).toList();
    }

    if (customList.isNotEmpty) {
      _cachedProducts = customList;
      return customList;
    }

    // Default curated agricultural seed catalog matching the original project
    if (isHindi) {
      _cachedProducts = [
        ProductModel(
          title: "श्रीराम सुपर 303 गेहूं बीज (Shriram Super 303 Wheat)",
          description: "उच्च उपज वाली प्रमाणित गेहूं किस्म। रोग प्रतिरोधी, चमकदार दाना और भरपूर पैदावार (25-28 क्विंटल/एकड़)।",
          price: 1450.00,
          imageUrl: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=600",
        ),
        ProductModel(
          title: "पायनियर हाइब्रिड मक्का बीज P3396 (Pioneer Hybrid Corn)",
          description: "भारी भुट्टे, आकर्षक दाना और सूखे को सहने की विशेष क्षमता। व्यावसायिक मक्का उत्पादन के लिए सर्वोत्तम।",
          price: 2150.00,
          imageUrl: "https://images.unsplash.com/photo-1551754655-cd27e38d2076?w=600",
        ),
        ProductModel(
          title: "अंकुर 3028 बीटी कॉटन कपास बीज (Ankur BT Cotton)",
          description: "बोलगार्ड II तकनीक युक्त, गुलाबी सुंडी रोधी, अधिक टिंडे और लंबे रेशे वाली लोकप्रिय कपास किस्म।",
          price: 864.00,
          imageUrl: "https://images.unsplash.com/photo-1605000797499-95a51c5269ae?w=600",
        ),
        ProductModel(
          title: "सिंजेंटा साहो टमाटर हाइब्रिड बीज (Syngenta Saho Tomato)",
          description: "गहरा लाल रंग, मजबूत छिलका और टीओएलसीवी (पत्ती मरोड़ वायरस) सहिष्णुता। दूर के बाजारों के लिए उपयुक्त।",
          price: 1120.00,
          imageUrl: "https://images.unsplash.com/photo-1592417817098-8f3d6910985c?w=600",
        ),
        ProductModel(
          title: "महिंद्रा गोल्ड प्याज बीज (F1 Hybrid Onion Seeds)",
          description: "मध्यम गोलाकार, गहरा लाल रंग, 5-6 महीने की उत्कृष्ट भंडारण क्षमता और भारी पैदावार।",
          price: 1850.00,
          imageUrl: "https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=600",
        ),
      ];
    } else {
      _cachedProducts = [
        ProductModel(
          title: "Shriram Super 303 Certified Wheat Seeds (40 Kg)",
          description: "Premium high-yield certified wheat variety with uniform earheads, lodging resistance, and high protein grain.",
          price: 1450.00,
          imageUrl: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=600",
        ),
        ProductModel(
          title: "Pioneer P3396 Hybrid Grain Corn / Maize Seeds (4 Kg)",
          description: "Industry leading hybrid corn with deep orange flint grains, strong stalk quality, and drought tolerance.",
          price: 2150.00,
          imageUrl: "https://images.unsplash.com/photo-1551754655-cd27e38d2076?w=600",
        ),
        ProductModel(
          title: "Ankur 3028 BG-II Hybrid Cotton Seeds (475 gm)",
          description: "Bollgard II technology protected against Helicoverpa & Pink Bollworm with superior fiber length and ginning outturn.",
          price: 864.00,
          imageUrl: "https://images.unsplash.com/photo-1605000797499-95a51c5269ae?w=600",
        ),
        ProductModel(
          title: "Syngenta Saho TO-1057 F1 Hybrid Tomato Seeds (10 gm)",
          description: "Firm, square-round deep red fruits with high heat tolerance and resistance to Tomato Leaf Curl Virus.",
          price: 1120.00,
          imageUrl: "https://images.unsplash.com/photo-1592417817098-8f3d6910985c?w=600",
        ),
        ProductModel(
          title: "Seminis Malini F1 Hybrid Cucumber Seeds (50 gm)",
          description: "High vigor vines with uniform cylindrical glossy green cucumbers. Highly prolific and early bearer.",
          price: 950.00,
          imageUrl: "https://images.unsplash.com/photo-1590165482129-1b8b27698980?w=600",
        ),
      ];
    }

    return _cachedProducts;
  }

  Future<void> addProduct(ProductModel product, {bool isHindi = false}) async {
    _cachedProducts.insert(0, product);
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _cachedProducts.map((e) => e.toJson()).toList();
    await prefs.setString("custom_products_${isHindi ? 'hi' : 'en'}", json.encode(jsonList));
  }

  Future<void> removeProduct(String title, {bool isHindi = false}) async {
    _cachedProducts.removeWhere((item) => item.title == title);
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _cachedProducts.map((e) => e.toJson()).toList();
    await prefs.setString("custom_products_${isHindi ? 'hi' : 'en'}", json.encode(jsonList));
  }

  // Cart operations
  List<ProductModel> getCartItems() => List.unmodifiable(_cartItems);

  void addToCart(ProductModel product) {
    final existingIndex = _cartItems.indexWhere((item) => item.title == product.title);
    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += 1;
    } else {
      _cartItems.add(product.copyWith(quantity: 1));
    }
  }

  void removeFromCart(String title) {
    _cartItems.removeWhere((item) => item.title == title);
  }

  void updateQuantity(String title, int quantity) {
    final index = _cartItems.indexWhere((item) => item.title == title);
    if (index >= 0) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = quantity;
      }
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  double getCartTotal() {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
