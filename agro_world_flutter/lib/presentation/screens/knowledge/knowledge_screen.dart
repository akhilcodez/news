import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/knowledge_provider.dart';
import '../../providers/language_provider.dart';
import '../../widgets/knowledge_card.dart';
import 'article_detail_screen.dart';
import 'disease_detail_screen.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lang = Provider.of<LanguageProvider>(context, listen: false);
      Provider.of<KnowledgeProvider>(context, listen: false).loadAllKnowledge(isHindi: lang.isHindi);
    });
  }

  @override
  Widget build(BuildContext context) {
    final knowledge = Provider.of<KnowledgeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.isHindi ? "कृषि ज्ञान केंद्र" : "Agricultural Knowledge"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppColors.primary),
            onPressed: () => knowledge.loadAllKnowledge(isHindi: lang.isHindi),
          ),
        ],
      ),
      body: knowledge.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => knowledge.loadAllKnowledge(isHindi: lang.isHindi),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Crops Section
                    _sectionHeader(lang.isHindi ? "प्रमुख फसलें (Crops)" : "Major Crops"),
                    SizedBox(
                      height: 195,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: knowledge.crops.length,
                        itemBuilder: (ctx, i) {
                          final item = knowledge.crops[i];
                          return KnowledgeCard(
                            title: item.title,
                            subtitle: item.cropInfo,
                            imageUrl: item.imageLink,
                            tag: item.season.isNotEmpty ? item.season : null,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ArticleDetailScreen(crop: item),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Fruits Section
                    _sectionHeader(lang.isHindi ? "फल एवं बागवानी (Fruits)" : "Fruit Cultivation"),
                    SizedBox(
                      height: 195,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: knowledge.fruits.length,
                        itemBuilder: (ctx, i) {
                          final item = knowledge.fruits[i];
                          return KnowledgeCard(
                            title: item.title,
                            subtitle: item.fruitInfo,
                            imageUrl: item.imageLink,
                            tag: item.season.isNotEmpty ? item.season : null,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ArticleDetailScreen(fruit: item),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Flowers Section
                    _sectionHeader(lang.isHindi ? "व्यावसायिक फूल (Flowers)" : "Commercial Floriculture"),
                    SizedBox(
                      height: 195,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: knowledge.flowers.length,
                        itemBuilder: (ctx, i) {
                          final item = knowledge.flowers[i];
                          return KnowledgeCard(
                            title: item.title,
                            subtitle: item.flowerInfo,
                            imageUrl: item.imageLink,
                            tag: item.season.isNotEmpty ? item.season : null,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ArticleDetailScreen(flower: item),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Modern Farming Techniques (How to Expand)
                    _sectionHeader(lang.isHindi ? "आधुनिक कृषि तकनीक (How To Expand)" : "Modern Farming Techniques"),
                    SizedBox(
                      height: 195,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: knowledge.techniques.length,
                        itemBuilder: (ctx, i) {
                          final item = knowledge.techniques[i];
                          return KnowledgeCard(
                            title: item.cropName,
                            subtitle: item.cropInfo,
                            imageUrl: item.imageLink,
                            tag: "Technique",
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ArticleDetailScreen(technique: item),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Crop Diseases & Plant Pathology
                    _sectionHeader(lang.isHindi ? "फसल रोग एवं निदान (Diseases)" : "Crop Diseases & Protection"),
                    SizedBox(
                      height: 195,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: knowledge.diseases.length,
                        itemBuilder: (ctx, i) {
                          final item = knowledge.diseases[i];
                          return KnowledgeCard(
                            title: item.diseaseName,
                            subtitle: "Affected: ${item.plantName}",
                            imageUrl: item.imageLink,
                            tag: "Disease",
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DiseaseDetailScreen(disease: item),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Insects & Pest Control
                    _sectionHeader(lang.isHindi ? "कीट नियंत्रण (Insects & Control)" : "Insects & Pest Control"),
                    SizedBox(
                      height: 195,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: knowledge.insects.length,
                        itemBuilder: (ctx, i) {
                          final item = knowledge.insects[i];
                          return KnowledgeCard(
                            title: item.insectName,
                            subtitle: "Crops: ${item.plantName}",
                            imageUrl: item.imageLink,
                            tag: "Pest",
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DiseaseDetailScreen(insect: item),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
