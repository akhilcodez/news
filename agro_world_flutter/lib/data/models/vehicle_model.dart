class VehicleModel {
  final String model;
  final String address;
  final String rates;
  final String unit;
  final String contact;
  final String imageUrl;

  VehicleModel({
    required this.model,
    required this.address,
    required this.rates,
    required this.unit,
    required this.contact,
    required this.imageUrl,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      model: json['model']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      rates: json['rates']?.toString() ?? '0',
      unit: json['unit']?.toString() ?? 'Km',
      contact: json['contact']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'address': address,
      'rates': rates,
      'unit': unit,
      'contact': contact,
      'imageUrl': imageUrl,
    };
  }

  double get rateValue => double.tryParse(rates) ?? 0.0;
}
