import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/recommendation_models.dart';
import '../../providers/language_provider.dart';
import '../../providers/smart_tools_provider.dart';
import '../../widgets/empty_state_widget.dart';

class FertilizerRecommendationScreen extends StatefulWidget {
  const FertilizerRecommendationScreen({super.key});

  @override
  State<FertilizerRecommendationScreen> createState() => _FertilizerRecommendationScreenState();
}

class _FertilizerRecommendationScreenState extends State<FertilizerRecommendationScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedCrop = "Rice";
  String _selectedSoil = "Black Cotton Soil";
  final _nController = TextEditingController(text: "32");
  final _pController = TextEditingController(text: "46");
  final _kController = TextEditingController(text: "50");
  final _moistureController = TextEditingController(text: "45");

  final List<String> _crops = [
    "Rice",
    "Wheat",
    "Cotton",
    "Soybean",
    "Maize",
    "Sugarcane",
    "Tomato",
    "Onion",
  ];

  final List<String> _soilTypes = [
    "Black Cotton Soil",
    "Alluvial Loam",
    "Red & Yellow Soil",
    "Clayey Soil",
  ];

  @override
  void dispose() {
    _nController.dispose();
    _pController.dispose();
    _kController.dispose();
    _moistureController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final isHindi = Provider.of<LanguageProvider>(context, listen: false).isHindi;
    final input = FertilizerRecommendationInput(
      cropName: _selectedCrop,
      soilType: _selectedSoil,
      nitrogen: double.tryParse(_nController.text) ?? 40,
      phosphorus: double.tryParse(_pController.text) ?? 40,
      potassium: double.tryParse(_kController.text) ?? 40,
      moisture: double.tryParse(_moistureController.text) ?? 40,
    );

    Provider.of<SmartToolsProvider>(context, listen: false).recommendFertilizer(input, isHindi: isHindi);
  }

  @override
  Widget build(BuildContext context) {
    final isHindi = Provider.of<LanguageProvider>(context).isHindi;
    final toolsProvider = Provider.of<SmartToolsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? "खत सल्लागार" : "Fertilizer Advisory"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2E7D32), Color(0xFF1565C0)],
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
                    child: const Icon(Icons.science, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHindi ? "योग्य खताची मात्रा आणि वेळ" : "Targeted Fertilizer Calculation",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isHindi
                              ? "अनावश्यक खतांचा खर्च टाळा आणि जमिनीचे आरोग्य राखा."
                              : "Prevent nutrient waste and optimize soil productivity per acre.",
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Form Card
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
                      // Crop dropdown
                      DropdownButtonFormField<String>(
                        initialValue: _selectedCrop,
                        decoration: InputDecoration(
                          labelText: isHindi ? "लागवड केलेले पीक" : "Target Crop",
                          prefixIcon: const Icon(Icons.eco_outlined),
                        ),
                        items: _crops
                            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedCrop = val);
                        },
                      ),
                      const SizedBox(height: 14),

                      // Soil Dropdown
                      DropdownButtonFormField<String>(
                        initialValue: _selectedSoil,
                        decoration: InputDecoration(
                          labelText: isHindi ? "मातीचा प्रकार" : "Soil Type",
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
                                labelText: "N (kg/ha)",
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
                                labelText: "P (kg/ha)",
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
                                labelText: "K (kg/ha)",
                              ),
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _moistureController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Soil Moisture (%)",
                          prefixIcon: Icon(Icons.water_drop_outlined),
                        ),
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: toolsProvider.isLoadingFertilizer ? null : _submit,
                          icon: toolsProvider.isLoadingFertilizer
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : const Icon(Icons.calculate_outlined),
                          label: Text(
                            toolsProvider.isLoadingFertilizer
                                ? (isHindi ? "गणना सुरू आहे..." : "Computing Dosage...")
                                : (isHindi ? "खताची मात्रा मोजा" : "Calculate Fertilizer Mix"),
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

            // Result
            if (toolsProvider.fertilizerResult != null) ...[
              Text(
                isHindi ? "शिफारस केलेले खत व्यवस्थापन:" : "Recommended Nutrient Protocol:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.primary, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check_circle, color: AppColors.primary, size: 28),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isHindi
                                      ? toolsProvider.fertilizerResult!.recommendedFertilizerHi
                                      : toolsProvider.fertilizerResult!.recommendedFertilizer,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  toolsProvider.fertilizerResult!.deficiencyType,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 28),
                      _buildInfoRow(
                        Icons.balance,
                        isHindi ? "डोस / प्रमाण" : "Recommended Dosage",
                        toolsProvider.fertilizerResult!.dosagePerAcre,
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        Icons.calendar_month,
                        isHindi ? "देण्याची वेळ" : "Application Timing",
                        toolsProvider.fertilizerResult!.applicationStage,
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        Icons.eco,
                        isHindi ? "सेंद्रिय पर्याय" : "Organic Alternative",
                        toolsProvider.fertilizerResult!.organicAlternative,
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        Icons.warning_amber_rounded,
                        isHindi ? "दक्षता / सूचना" : "Field Precautions",
                        toolsProvider.fertilizerResult!.precautions,
                      ),
                    ],
                  ),
                ),
              ),
            ] else if (!toolsProvider.isLoadingFertilizer) ...[
              const EmptyStateWidget(
                title: "No Analysis Yet",
                subtitle: "Select crop and enter soil N-P-K values above to see fertilizer schedule.",
                icon: Icons.science_outlined,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 2),
              Text(
                content,
                style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
