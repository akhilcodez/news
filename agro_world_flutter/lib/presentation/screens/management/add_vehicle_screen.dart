import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/vehicle_model.dart';
import '../../providers/transport_provider.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _modelController = TextEditingController();
  final _addressController = TextEditingController(text: "Alibag, Maharashtra");
  final _ratesController = TextEditingController();
  final _unitController = TextEditingController(text: "₹ / Km");
  final _contactController = TextEditingController();
  final _imageController = TextEditingController(
    text: "https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=600",
  );

  @override
  void dispose() {
    _modelController.dispose();
    _addressController.dispose();
    _ratesController.dispose();
    _unitController.dispose();
    _contactController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _saveVehicle() async {
    if (_formKey.currentState?.validate() ?? false) {
      final transport = Provider.of<TransportProvider>(context, listen: false);

      await transport.addVehicle(
        VehicleModel(
          model: _modelController.text.trim(),
          address: _addressController.text.trim(),
          rates: _ratesController.text.trim(),
          unit: _unitController.text.trim(),
          contact: _contactController.text.trim(),
          imageUrl: _imageController.text.trim(),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Vehicle listed on AgroWorld Transport directory!"),
            backgroundColor: AppColors.primary,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Vehicle"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Register your farm transport vehicle so nearby farmers can book for harvest haulage.",
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),

              // Model
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(
                  labelText: "Vehicle Model & Capacity",
                  hintText: "e.g., Mahindra Bolero Maxi Truck (1.2 Ton)",
                  prefixIcon: Icon(Icons.local_shipping_outlined),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? "Model is required" : null,
              ),
              const SizedBox(height: 14),

              // Location / Address Dropdown
              DropdownButtonFormField<String>(
                initialValue: AppConstants.locations.contains(_addressController.text.split(',').first.trim())
                    ? _addressController.text.split(',').first.trim()
                    : "Alibag",
                decoration: const InputDecoration(
                  labelText: "Base Location / Mandi Yard",
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                items: AppConstants.locations
                    .where((l) => l != "All Locations")
                    .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
                    .toList(),
                onChanged: (loc) {
                  if (loc != null) {
                    setState(() {
                      _addressController.text = "$loc, Maharashtra";
                    });
                  }
                },
              ),
              const SizedBox(height: 14),

              // Rates and Unit Row
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _ratesController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: "Rate (₹)",
                        hintText: "e.g., 25",
                        prefixIcon: Icon(Icons.currency_rupee_rounded),
                      ),
                      validator: (val) => val == null || val.trim().isEmpty ? "Rate is required" : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _unitController,
                      decoration: const InputDecoration(
                        labelText: "Per Unit",
                        hintText: "e.g., ₹ / Km",
                      ),
                      validator: (val) => val == null || val.trim().isEmpty ? "Unit is required" : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Contact Number
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: "Driver Contact Number",
                  hintText: "10-digit phone number",
                  prefixIcon: Icon(Icons.phone_outlined),
                  counterText: "",
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return "Contact is required";
                  if (val.trim().length != 10) return "Contact must be 10 digits";
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Image URL
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: "Vehicle Photo URL",
                  hintText: "Enter direct image URL",
                  prefixIcon: Icon(Icons.image_outlined),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? "Image URL is required" : null,
              ),
              const SizedBox(height: 36),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveVehicle,
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text("Publish Vehicle Listing"),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
