import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/language_provider.dart';

class NewsArticle {
  final String title;
  final String summary;
  final String source;
  final String time;
  final String imageUrl;
  final String url;

  NewsArticle({
    required this.title,
    required this.summary,
    required this.source,
    required this.time,
    required this.imageUrl,
    required this.url,
  });
}

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  Future<void> _launchNewsUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final isHindi = lang.isHindi;

    final articles = isHindi ? _hindiNews : _englishNews;

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? "कृषि समाचार (Live News)" : "Live Farming News"),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser_rounded, color: AppColors.primary),
            tooltip: "Open Krishi Jagran Portal",
            onPressed: () {
              _launchNewsUrl(isHindi ? ApiConstants.hindiNewsUrl : ApiConstants.englishNewsUrl);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Source banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.primaryContainer.withOpacity(0.5),
            child: Row(
              children: [
                const Icon(Icons.rss_feed_rounded, size: 16, color: AppColors.primaryDark),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isHindi
                        ? "लाइव स्रोत: कृषि जागरण पोर्टल (krishijagran.com)"
                        : "Live Source: Krishi Jagran Agricultural Portal",
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryDark),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: articles.length,
              itemBuilder: (ctx, index) {
                final article = articles[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    onTap: () => _launchNewsUrl(article.url),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              article.imageUrl,
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                height: 150,
                                color: AppColors.surfaceVariant,
                                child: const Icon(Icons.newspaper_rounded, color: AppColors.primary, size: 48),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                article.source,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                article.time,
                                style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            article.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            article.summary,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                "Read Full Story",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward_rounded, size: 14, color: AppColors.primary),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static final List<NewsArticle> _englishNews = [
    NewsArticle(
      title: "Government hikes Minimum Support Price (MSP) for Rabi crops for 2026-27 season",
      summary: "Cabinet Committee on Economic Affairs approves significant MSP increase for wheat, mustard, and gram to boost farmer earnings.",
      source: "Krishi Jagran",
      time: "2 hours ago",
      imageUrl: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=600",
      url: ApiConstants.englishNewsUrl,
    ),
    NewsArticle(
      title: "PM-Kisan 19th Installment of ₹2,000 released directly to 9.5 crore farmers",
      summary: "Prime Minister DBT transfer credited directly to Aadhaar-seeded bank accounts across all states.",
      source: "AgriNews Live",
      time: "5 hours ago",
      imageUrl: "https://images.unsplash.com/photo-1592417817098-8f3d6910985c?w=600",
      url: ApiConstants.englishNewsUrl,
    ),
    NewsArticle(
      title: "Monsoon rainfall forecast update: Good soil moisture in Western & Central Maharashtra",
      summary: "IMD predicts favorable meteorological conditions for early Rabi sowing with adequate reservoir levels.",
      source: "Weather & Farm",
      time: "1 day ago",
      imageUrl: "https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?w=600",
      url: ApiConstants.englishNewsUrl,
    ),
  ];

  static final List<NewsArticle> _hindiNews = [
    NewsArticle(
      title: "रबी फसलों के लिए न्यूनतम समर्थन मूल्य (MSP) में भारी बढ़ोतरी, गेहूं के दाम बढ़े",
      summary: "केंद्र सरकार ने किसानों की आय बढ़ाने के लिए गेहूं, चना और सरसों के न्यूनतम समर्थन मूल्य में रिकॉर्ड इजाफा किया।",
      source: "कृषि जागरण हिंदी",
      time: "२ घंटे पहले",
      imageUrl: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=600",
      url: ApiConstants.hindiNewsUrl,
    ),
    NewsArticle(
      title: "पीएम किसान योजना की 19वीं किस्त जारी, करोड़ों किसानों के खाते में पहुंचे 2000 रुपये",
      summary: "डीबीटी के माध्यम से सीधे किसानों के बैंक खातों में आर्थिक सहायता भेजी गई, ऐसे चेक करें अपनी स्थिति।",
      source: "कृषि जागरण हिंदी",
      time: "५ घंटे पहले",
      imageUrl: "https://images.unsplash.com/photo-1592417817098-8f3d6910985c?w=600",
      url: ApiConstants.hindiNewsUrl,
    ),
  ];
}
