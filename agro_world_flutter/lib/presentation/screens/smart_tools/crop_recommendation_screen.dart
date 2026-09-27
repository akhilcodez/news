import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/recommendation_models.dart';
import '../../providers/language_provider.dart';
import '../../providers/smart_tools_provider.dart';
import '../../widgets/empty_state_widget.dart';
import '../shopping/shopping_screen.dart';

class CropRecommendationScreen extends StatefulWidget {
  const CropRecommendationScreen({super.key});

  @override
  State<CropRecommendationScreen> createState() => _CropRecommendationScreenState();
}

class _CropRecommendationScreenState extends State<CropRecommendationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nController = TextEditingController(text: "75");
  final _pController = TextEditingController(text: "48");
  final _kController = TextEditingController(text: "42");
  final _tempController = TextEditingController(text: "28");
  final _humController = TextEditingController(text: "72");
  final _phController = TextEditingController(text: "6.8");
  final _rainController = TextEditingController(text: "120");

  String _selectedSoil = "Black Cotton Soil";
  final List<String> _soilTypes = [
    "Black Cotton Soil",
    "Alluvial Loam",
    "Red & Yellow Soil",
    "Clayey Soil",
    "Laterite Soil",
  ];

  @override
  void dispose() {
    _nController.dispose();
    _pController.dispose();
    _kController.dispose();
    _tempController.dispose();
    _humController.dispose();
    _phController.dispose();
    _rainController.dispose();
    super.dispose();
  }

  void _applyPreset(String name) {
    setState(() {
      if (name == "black") {
        _selectedSoil = "Black Cotton Soil";
        _nController.text = "85";
        _pController.text = "55";
        _kController.text = "60";
        _tempController.text = "30";
        _humController.text = "65";
        _phController.text = "7.2";
        _rainController.text = "95";
      } else if (name == "alluvial") {
        _selectedSoil = "Alluvial Loam";
        _nController.text = "70";
        _pController.text = "45";
        _kController.text = "50";
        _tempController.text = "26";
        _humController.text = "78";
        _phController.text = "6.5";
        _rainController.text = "180";
      } else {
        _selectedSoil = "Red & Yellow Soil";
        _nController.text = "45";
        _pController.text = "35";
        _kController.text = "35";
        _tempController.text = "24";
        _humController.text = "55";
        _phController.text = "6.0";
        _rainController.text = "75";
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final isHindi = Provider.of<LanguageProvider>(context, listen: false).isHindi;
    final input = CropRecommendationInput(
      nitrogen: double.tryParse(_nController.text) ?? 70,
      phosphorus: double.tryParse(_pController.text) ?? 45,
      potassium: double.tryParse(_kController.text) ?? 45,
      temperature: double.tryParse(_tempController.text) ?? 27,
      humidity: double.tryParse(_humController.text) ?? 70,
      ph: double.tryParse(_phController.text) ?? 6.5,
      rainfall: double.tryParse(_rainController.text) ?? 100,
      soilType: _selectedSoil,
    );

    Provider.of<SmartToolsProvider>(context, listen: false).recommendCrops(input, isHindi: isHindi);
  }

  @override
  Widget build(BuildContext context) {
    final isHindi = Provider.of<LanguageProvider>(context).isHindi;
    final toolsProvider = Provider.of<SmartToolsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? "स्मार्ट पीक सल्लागार" : "Crop Recommendation"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.psychology, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHindi ? "माती व हवामानानुसार योग्य पीक निवडा" : "Data-Driven Crop Advisory",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isHindi
                              ? "तुमच्या शेतातील नत्र, स्फुरद, पालाश आणि पावसाच्या नोंदी भरा."
                              : "Input soil nutrients and weather conditions for calibrated recommendations.",
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Presets
            Text(
              isHindi ? "त्वरित चाचणीसाठी नमुना माती निवडा:" : "Quick Soil Presets:",
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ActionChip(
                    avatar: const Icon(Icons.terrain, size: 16, color: AppColors.primary),
                    label: Text(isHindi ? "काळी कसदार जमीन" : "Black Cotton"),
                    onPressed: () => _applyPreset("black"),
                  ),
                  const SizedBox(width: 8),
                  ActionChip(
                    avatar: const Icon(Icons.water, size: 16, color: AppColors.primary),
                    label: Text(isHindi ? "गाळाची जमीन (भातासाठी)" : "Alluvial Loam"),
                    onPressed: () => _applyPreset("alluvial"),
                  ),
                  const SizedBox(width: 8),
                  ActionChip(
                    avatar: const Icon(Icons.wb_sunny, size: 16, color: AppColors.primary),
                    label: Text(isHindi ? "हलकी तांबडी जमीन" : "Red Loamy"),
                    onPressed: () => _applyPreset("red"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Form
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.cardBorder),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Soil Dropdown
                      DropdownButtonFormField<String>(
                        initialValue: _selectedSoil,
                        decoration: InputDecoration(
                          labelText: isHindi ? "मातीचा प्रकार" : "Soil Classification",
                          prefixIcon: const Icon(Icons.landscape_outlined),
                        ),
                        items: _soilTypes
                            .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedSoil = val);
                        },
                      ),
                      const SizedBox(height: 14),

                      // N-P-K Row
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _nController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Nitrogen (N)",
                                hintText: "kg/ha",
                              ),
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _pController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Phosphorus (P)",
                                hintText: "kg/ha",
                              ),
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _kController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Potassium (K)",
                                hintText: "kg/ha",
                              ),
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // pH & Temp
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _phController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Soil pH (3.5 - 9)",
                                prefixIcon: Icon(Icons.science_outlined),
                              ),
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _tempController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Temp (°C)",
                                prefixIcon: Icon(Icons.thermostat),
                              ),
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Humidity & Rainfall
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _humController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Humidity (%)",
                                prefixIcon: Icon(Icons.water_drop_outlined),
                              ),
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _rainController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Rainfall (mm)",
                                prefixIcon: Icon(Icons.cloud_outlined),
                              ),
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: toolsProvider.isLoadingCropRec ? null : _submit,
                          icon: toolsProvider.isLoadingCropRec
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : const Icon(Icons.auto_awesome),
                          label: Text(
                            toolsProvider.isLoadingCropRec
                                ? (isHindi ? "विश्लेषण सुरू आहे..." : "Analyzing Soil Data...")
                                : (isHindi ? "योग्य पिकांची शिफारस मिळवा" : "Recommend Suitable Crops"),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Results Section
            if (toolsProvider.cropRecommendations.isNotEmpty) ...[
              Text(
                isHindi ? "तुमच्या शेतासाठी सर्वोत्तम शिफारसी:" : "Top Recommended Crops for Your Farm:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: toolsProvider.cropRecommendations.length,
                itemBuilder: (context, index) {
                  final rec = toolsProvider.cropRecommendations[index];
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: index == 0 ? AppColors.primary : AppColors.cardBorder,
                        width: index == 0 ? 2 : 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  rec.imageUrl,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 70,
                                    height: 70,
                                    color: Colors.green.shade100,
                                    child: const Icon(Icons.eco, color: AppColors.primary),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          isHindi ? rec.cropNameHi : rec.cropName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            "${rec.confidence.toStringAsFixed(0)}% Match",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green.shade800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${rec.season} | ${rec.durationDays} Days Duration",
                                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Water: ${rec.waterRequirement}",
                                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            rec.reason,
                            style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.lightbulb_outline, size: 16, color: AppColors.secondary),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    rec.tips,
                                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ShoppingScreen()),
                                );
                              },
                              icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                              label: Text(isHindi ? "प्रमाणित बियाणे खरेदी करा" : "Buy Certified Seeds"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ] else if (!toolsProvider.isLoadingCropRec) ...[
              const EmptyStateWidget(
                title: "Ready to Analyze",
                subtitle: "Enter your farm parameters above to calculate recommended crops.",
                icon: Icons.grass,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
