import 'package:flutter/material.dart';
import '../../data/models/vehicle_model.dart';
import '../../data/repositories/transport_repository.dart';

enum VehicleSortOption { none, lowToHigh, highToLow }

class TransportProvider extends ChangeNotifier {
  final TransportRepository _repository = TransportRepository();

  List<VehicleModel> _allVehicles = [];
  List<VehicleModel> _filteredVehicles = [];
  bool _isLoading = false;
  String _selectedLocation = "All Locations";
  VehicleSortOption _currentSort = VehicleSortOption.none;

  List<VehicleModel> get vehicles => _filteredVehicles;
  bool get isLoading => _isLoading;
  String get selectedLocation => _selectedLocation;
  VehicleSortOption get currentSort => _currentSort;

  TransportProvider() {
    loadVehicles();
  }

  Future<void> loadVehicles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allVehicles = await _repository.getVehicles();
      _applyFilterAndSort();
    } catch (_) {}

    _isLoading = false;
    notifyListeners();
  }

  void filterByLocation(String location) {
    _selectedLocation = location;
    _applyFilterAndSort();
  }

  void setSortOption(VehicleSortOption sort) {
    _currentSort = sort;
    _applyFilterAndSort();
  }

  void _applyFilterAndSort() {
    List<VehicleModel> temp = List.from(_allVehicles);
    if (_selectedLocation != "All Locations") {
      temp = temp
          .where((v) => v.address.toLowerCase().contains(_selectedLocation.toLowerCase()))
          .toList();
    }

    if (_currentSort == VehicleSortOption.lowToHigh) {
      temp.sort((a, b) => a.rateValue.compareTo(b.rateValue));
    } else if (_currentSort == VehicleSortOption.highToLow) {
      temp.sort((a, b) => b.rateValue.compareTo(a.rateValue));
    }

    _filteredVehicles = temp;
    notifyListeners();
  }

  Future<void> addVehicle(VehicleModel vehicle) async {
    await _repository.addVehicle(vehicle);
    await loadVehicles();
  }

  Future<void> removeVehicle(String model) async {
    await _repository.removeVehicle(model);
    await loadVehicles();
  }
}
