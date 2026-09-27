import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/article_models.dart';

class ArticleDetailScreen extends StatelessWidget {
  final CropModel? crop;
  final FruitModel? fruit;
  final FlowerModel? flower;
  final ExpandTechniqueModel? technique;

  const ArticleDetailScreen({
    super.key,
    this.crop,
    this.fruit,
    this.flower,
    this.technique,
  });

  @override
  Widget build(BuildContext context) {
    final title = crop?.title ?? fruit?.title ?? flower?.title ?? technique?.cropName ?? "Article";
    final imageUrl = crop?.imageLink ?? fruit?.imageLink ?? flower?.imageLink ?? technique?.imageLink ?? "";
    final info = crop?.cropInfo ?? fruit?.fruitInfo ?? flower?.flowerInfo ?? technique?.cropInfo ?? "";
    final soil = crop?.soil ?? fruit?.soil ?? flower?.soil ?? "";
    final seed = crop?.seed ?? fruit?.seed ?? flower?.seed ?? technique?.seed ?? "";
    final landPrep = crop?.landPreparation ?? fruit?.landPreparation ?? flower?.landPreparation ?? "";
    final irrigation = crop?.irrigation ?? fruit?.irrigation ?? flower?.irrigation ?? technique?.irrigation ?? "";
    final fertilizer = crop?.fertilizer ?? technique?.fertilizer ?? "";
    final harvesting = crop?.harvesting ?? fruit?.harvesting ?? flower?.harvesting ?? technique?.harvesting ?? "";
    final postHarvest = crop?.postHarvest ?? fruit?.postHarvest ?? flower?.postHarvest ?? "";
    final season = crop?.season ?? fruit?.season ?? flower?.season ?? technique?.season ?? "";
    final state = crop?.state ?? fruit?.state ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image
            if (imageUrl.isNotEmpty)
              Image.network(
                imageUrl,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 240,
                  color: AppColors.primaryContainer,
                  child: const Center(
                    child: Icon(Icons.eco_rounded, size: 70, color: AppColors.primary),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and badges
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      if (season.isNotEmpty) _badge(Icons.wb_sunny_outlined, season),
                      if (state.isNotEmpty) _badge(Icons.map_outlined, state),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Overview
                  if (info.isNotEmpty)
                    _sectionBox(
                      icon: Icons.info_outline_rounded,
                      title: "Overview & Crop Information",
                      content: info,
                      color: AppColors.primary,
                    ),

                  // Soil
                  if (soil.isNotEmpty)
                    _sectionBox(
                      icon: Icons.terrain_rounded,
                      title: "Soil & Climate Requirements",
                      content: soil,
                      color: const Color(0xFF795548),
                    ),

                  // Land Preparation
                  if (landPrep.isNotEmpty)
                    _sectionBox(
                      icon: Icons.agriculture_rounded,
                      title: "Land Preparation & Field Setup",
                      content: landPrep,
                      color: const Color(0xFF00796B),
                    ),

                  // Seed & Sowing
                  if (seed.isNotEmpty)
                    _sectionBox(
                      icon: Icons.grain_rounded,
                      title: "Seed Rate, Variety & Sowing",
                      content: seed,
                      color: const Color(0xFFF57F17),
                    ),

                  // Irrigation
                  if (irrigation.isNotEmpty)
                    _sectionBox(
                      icon: Icons.water_drop_outlined,
                      title: "Irrigation & Water Schedule",
                      content: irrigation,
                      color: const Color(0xFF0288D1),
                    ),

                  // Fertilizer
                  if (fertilizer.isNotEmpty)
                    _sectionBox(
                      icon: Icons.science_outlined,
                      title: "Fertilizer & Plant Nutrition",
                      content: fertilizer,
                      color: const Color(0xFF689F38),
                    ),

                  // Harvesting
                  if (harvesting.isNotEmpty)
                    _sectionBox(
                      icon: Icons.content_cut_rounded,
                      title: "Harvesting & Maturation",
                      content: harvesting,
                      color: const Color(0xFFE65100),
                    ),

                  // Post-Harvest
                  if (postHarvest.isNotEmpty)
                    _sectionBox(
                      icon: Icons.storefront_rounded,
                      title: "Post-Harvest Handling & Storage",
                      content: postHarvest,
                      color: const Color(0xFF5D4037),
                    ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primaryDark),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
          ),
        ],
      ),
    );
  }

  Widget _sectionBox({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13.5,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
