import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/recommendation_models.dart';
import '../../providers/language_provider.dart';
import '../../providers/smart_tools_provider.dart';
import '../../widgets/empty_state_widget.dart';
import '../../widgets/smart_metric_card.dart';

class YieldPredictionScreen extends StatefulWidget {
  const YieldPredictionScreen({super.key});

  @override
  State<YieldPredictionScreen> createState() => _YieldPredictionScreenState();
}

class _YieldPredictionScreenState extends State<YieldPredictionScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedCrop = "Rice (Paddy)";
  String _selectedSeason = "Kharif";
  String _selectedIrrigation = "Drip Irrigation";
  final _areaController = TextEditingController(text: "3.5");
  final _fertilizerController = TextEditingController(text: "55");
  final _rainController = TextEditingController(text: "900");

  final List<String> _crops = [
    "Rice (Paddy)",
    "Wheat",
    "Cotton",
    "Soybean",
    "Maize",
    "Chickpea",
  ];

  final List<String> _seasons = ["Kharif", "Rabi", "Zaid (Summer)"];

  final List<String> _irrigations = [
    "Drip Irrigation",
    "Sprinkler",
    "Canal / Flood",
    "Rainfed",
  ];

  @override
  void dispose() {
    _areaController.dispose();
    _fertilizerController.dispose();
    _rainController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final isHindi = Provider.of<LanguageProvider>(context, listen: false).isHindi;
    final input = YieldPredictionInput(
      cropName: _selectedCrop,
      areaAcres: double.tryParse(_areaController.text) ?? 1.0,
      season: _selectedSeason,
      irrigationType: _selectedIrrigation,
      fertilizerUsageKg: double.tryParse(_fertilizerController.text) ?? 50.0,
      annualRainfallMm: double.tryParse(_rainController.text) ?? 800.0,
    );

    Provider.of<SmartToolsProvider>(context, listen: false).predictYield(input, isHindi: isHindi);
  }

  @override
  Widget build(BuildContext context) {
    final isHindi = Provider.of<LanguageProvider>(context).isHindi;
    final toolsProvider = Provider.of<SmartToolsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? "उत्पादन अंदाज कॅल्क्युलेटर" : "Crop Yield Prediction"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE65100), Color(0xFFF57C00)],
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
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.analytics_outlined, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHindi ? "संभाव्य उत्पादन व उत्पन्नाचा अंदाज" : "Yield & Revenue Forecasting",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isHindi
                              ? "क्षेत्रफळ व सिंचन पद्धतीनुसार अपेक्षित क्विंटल व अंदाजे कमाई मोजा."
                              : "Estimate harvest volume (quintals) and market returns before harvest.",
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
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
                      // Crop
                      DropdownButtonFormField<String>(
                        initialValue: _selectedCrop,
                        decoration: InputDecoration(
                          labelText: isHindi ? "पीक" : "Crop",
                          prefixIcon: const Icon(Icons.grass),
                        ),
                        items: _crops.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => _selectedCrop = v);
                        },
                      ),
                      const SizedBox(height: 14),

                      // Area
                      TextFormField(
                        controller: _areaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: isHindi ? "शेताचे क्षेत्रफळ (एकर)" : "Farm Cultivation Area (Acres)",
                          prefixIcon: const Icon(Icons.square_foot),
                        ),
                        validator: (v) => v!.isEmpty ? "Area required" : null,
                      ),
                      const SizedBox(height: 14),

                      // Season & Irrigation
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _selectedSeason,
                              decoration: InputDecoration(
                                labelText: isHindi ? "हंगाम" : "Season",
                              ),
                              items: _seasons.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                              onChanged: (v) {
                                if (v != null) setState(() => _selectedSeason = v);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _selectedIrrigation,
                              decoration: InputDecoration(
                                labelText: isHindi ? "सिंचन पद्धत" : "Irrigation",
                              ),
                              items: _irrigations.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
                              onChanged: (v) {
                                if (v != null) setState(() => _selectedIrrigation = v);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Fertilizer & Rain
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _fertilizerController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: isHindi ? "खत वापर (kg/एकर)" : "Fertilizer (kg/ac)",
                              ),
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _rainController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: isHindi ? "अपेक्षित पाऊस (mm)" : "Rainfall (mm)",
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
                          onPressed: toolsProvider.isLoadingYield ? null : _submit,
                          icon: toolsProvider.isLoadingYield
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : const Icon(Icons.trending_up),
                          label: Text(
                            toolsProvider.isLoadingYield
                                ? (isHindi ? "उत्पादनाचा अंदाज काढत आहे..." : "Forecasting Harvest...")
                                : (isHindi ? "संभाव्य उत्पादन मोजा" : "Predict Harvest Yield"),
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

            // Yield Results
            if (toolsProvider.yieldResult != null) ...[
              Text(
                isHindi ? "उत्पादन व महसूल अंदाज:" : "Harvest Yield & Revenue Projections:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: SmartMetricCard(
                      title: isHindi ? "एकूण उत्पादन" : "Total Estimated Yield",
                      value: "${toolsProvider.yieldResult!.estimatedYieldQuintals} Qtl",
                      subtitle: "${(toolsProvider.yieldResult!.estimatedYieldQuintals * 0.1).toStringAsFixed(1)} Tons",
                      icon: Icons.inventory_2_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SmartMetricCard(
                      title: isHindi ? "प्रति एकर उत्पादन" : "Yield Per Acre",
                      value: "${toolsProvider.yieldResult!.yieldPerAcre} Qtl/ac",
                      icon: Icons.speed,
                      color: const Color(0xFF1565C0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Revenue Card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.secondary, width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isHindi ? "अपेक्षित बाजार मूल्य (कमाई)" : "Projected Gross Revenue",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isHindi ? "MSP आधार" : "Based on MSP",
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.secondary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "₹${toolsProvider.yieldResult!.estimatedMinRevenue.toStringAsFixed(0)} - ₹${toolsProvider.yieldResult!.estimatedMaxRevenue.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${isHindi ? 'जोखीम निर्देशांक:' : 'Risk Level:'} ${toolsProvider.yieldResult!.riskAssessment}",
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Optimization Steps
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.cardBorder),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.tips_and_updates_outlined, color: AppColors.primary, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            isHindi ? "उत्पादन वाढीसाठी महत्त्वाच्या टिप्स:" : "Yield Optimization Actions:",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...toolsProvider.yieldResult!.optimizationSteps.map(
                        (step) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle, size: 16, color: AppColors.primary),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(step, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else if (!toolsProvider.isLoadingYield) ...[
              const EmptyStateWidget(
                title: "Calculate Harvest Yield",
                subtitle: "Specify crop and cultivation acreage to estimate production quantity and revenue.",
                icon: Icons.calculate,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
