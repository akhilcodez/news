import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/vehicle_model.dart';

class TransportRepository {
  List<VehicleModel> _cachedVehicles = [];

  Future<List<VehicleModel>> getVehicles() async {
    final prefs = await SharedPreferences.getInstance();
    final customJson = prefs.getString("custom_vehicles");
    if (customJson != null) {
      final List<dynamic> decoded = json.decode(customJson);
      _cachedVehicles = decoded.map((e) => VehicleModel.fromJson(e)).toList();
      if (_cachedVehicles.isNotEmpty) {
        return _cachedVehicles;
      }
    }

    // Default regional agricultural transport fleet from original project
    _cachedVehicles = [
      VehicleModel(
        model: "Mahindra Bolero Maxi Truck Plus (1.2 Ton)",
        address: "Alibag, Raigad, Maharashtra",
        rates: "22",
        unit: "₹ / Km",
        contact: "9822014589",
        imageUrl: "https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=600",
      ),
      VehicleModel(
        model: "Tata 407 LPT High Deck (3.5 Ton)",
        address: "Panvel, Navi Mumbai, Maharashtra",
        rates: "38",
        unit: "₹ / Km",
        contact: "9423187654",
        imageUrl: "https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?w=600",
      ),
      VehicleModel(
        model: "Eicher Pro 2049 Grain Carrier (4.9 Ton)",
        address: "Pune Mandi, Hadapsar, Maharashtra",
        rates: "45",
        unit: "₹ / Km",
        contact: "9850123478",
        imageUrl: "https://images.unsplash.com/photo-1519003722824-194d4455a60c?w=600",
      ),
      VehicleModel(
        model: "Ashok Leyland BADA DOST (2 Ton)",
        address: "Ratnagiri Market Yard, Maharashtra",
        rates: "26",
        unit: "₹ / Km",
        contact: "9158334411",
        imageUrl: "https://images.unsplash.com/photo-1541899481282-d53bffe3c35d?w=600",
      ),
      VehicleModel(
        model: "Tata Ace Gold / Chota Hathi (750 Kg)",
        address: "Pen, Raigad, Maharashtra",
        rates: "16",
        unit: "₹ / Km",
        contact: "9766554433",
        imageUrl: "https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=600",
      ),
      VehicleModel(
        model: "Mahindra Furio 7 Tipper & Bulk Transporter",
        address: "Karjat, Maharashtra",
        rates: "55",
        unit: "₹ / Km",
        contact: "9823456789",
        imageUrl: "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=600",
      ),
    ];

    return _cachedVehicles;
  }

  Future<void> addVehicle(VehicleModel vehicle) async {
    _cachedVehicles.insert(0, vehicle);
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _cachedVehicles.map((e) => e.toJson()).toList();
    await prefs.setString("custom_vehicles", json.encode(jsonList));
  }

  Future<void> removeVehicle(String model) async {
    _cachedVehicles.removeWhere((item) => item.model == model);
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _cachedVehicles.map((e) => e.toJson()).toList();
    await prefs.setString("custom_vehicles", json.encode(jsonList));
  }
}
