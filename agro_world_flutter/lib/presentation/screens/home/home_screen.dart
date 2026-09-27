import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/weather_provider.dart';
import '../../providers/shopping_provider.dart';
import '../../providers/transport_provider.dart';
import '../../widgets/weather_card.dart';
import '../../widgets/product_card.dart';
import '../../widgets/vehicle_card.dart';
import '../shopping/product_detail_screen.dart';
import '../weather/weather_detail_screen.dart';
import '../smart_tools/crop_recommendation_screen.dart';
import '../smart_tools/fertilizer_recommendation_screen.dart';
import '../smart_tools/yield_prediction_screen.dart';
import '../smart_tools/market_prices_screen.dart';
import '../smart_tools/disease_detection_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onTabSwitch;

  const HomeScreen({super.key, required this.onTabSwitch});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final shoppingProvider = Provider.of<ShoppingProvider>(context);
    final transportProvider = Provider.of<TransportProvider>(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            weatherProvider.loadWeatherData(),
            shoppingProvider.loadProducts(),
            transportProvider.loadVehicles(),
          ]);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Live Weather Card
              WeatherCard(
                weather: weatherProvider.currentWeather,
                isLoading: weatherProvider.isLoading,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => WeatherDetailScreen(weather: weatherProvider.currentWeather),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Agricultural Guides & Quick Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Agricultural Guides",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () => onTabSwitch(3), // Switch to Knowledge tab
                      child: const Text("View All"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 4),

              // Categories Row
              SizedBox(
                height: 94,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    _categoryItem(
                      context: context,
                      title: "Crops",
                      icon: Icons.grass_rounded,
                      color: const Color(0xFF2E7D32),
                      onTap: () => onTabSwitch(3),
                    ),
                    _categoryItem(
                      context: context,
                      title: "Fruits",
                      icon: Icons.apple_rounded,
                      color: const Color(0xFFE65100),
                      onTap: () => onTabSwitch(3),
                    ),
                    _categoryItem(
                      context: context,
                      title: "Flowers",
                      icon: Icons.local_florist_rounded,
                      color: const Color(0xFFC2185B),
                      onTap: () => onTabSwitch(3),
                    ),
                    _categoryItem(
                      context: context,
                      title: "Techniques",
                      icon: Icons.lightbulb_outline_rounded,
                      color: const Color(0xFF00796B),
                      onTap: () => onTabSwitch(3),
                    ),
                    _categoryItem(
                      context: context,
                      title: "Diseases",
                      icon: Icons.healing_rounded,
                      color: const Color(0xFFD32F2F),
                      onTap: () => onTabSwitch(3),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Smart Farming Advisory & Prediction Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Smart Advisory & Tools",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          "AI-driven crop, fertilizer & market forecasts",
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 115,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    _toolCard(
                      context: context,
                      title: "Crop Advisory",
                      subtitle: "Soil & climate match",
                      icon: Icons.psychology_outlined,
                      color: const Color(0xFF1B5E20),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CropRecommendationScreen()),
                      ),
                    ),
                    _toolCard(
                      context: context,
                      title: "Fertilizer Mix",
                      subtitle: "Dosage & schedule",
                      icon: Icons.science_outlined,
                      color: const Color(0xFF1565C0),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FertilizerRecommendationScreen()),
                      ),
                    ),
                    _toolCard(
                      context: context,
                      title: "Yield Forecast",
                      subtitle: "Harvest estimation",
                      icon: Icons.trending_up,
                      color: const Color(0xFFE65100),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const YieldPredictionScreen()),
                      ),
                    ),
                    _toolCard(
                      context: context,
                      title: "Mandi Rates",
                      subtitle: "Live APMC prices",
                      icon: Icons.storefront_outlined,
                      color: const Color(0xFF6A1B9A),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MarketPricesScreen()),
                      ),
                    ),
                    _toolCard(
                      context: context,
                      title: "Leaf Diagnostic",
                      subtitle: "Disease detection",
                      icon: Icons.biotech_outlined,
                      color: const Color(0xFFC62828),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DiseaseDetectionScreen()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Certified Seeds Store Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Certified Seeds Store",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          "Directly from verified manufacturers",
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => onTabSwitch(1), // Switch to Shopping tab
                      child: const Text("Explore"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 195,
                child: shoppingProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: shoppingProvider.products.length,
                        itemBuilder: (ctx, index) {
                          final product = shoppingProvider.products[index];
                          return ProductCard(
                            product: product,
                            isCompact: true,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailScreen(product: product),
                                ),
                              );
                            },
                            onAddToCart: () {
                              shoppingProvider.addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${product.title} added to cart"),
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: AppColors.primaryDark,
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),

              const SizedBox(height: 20),

              // Farmer Transporters Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Nearby Farm Transporters",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          "Book trucks, pickups & tempos for mandi delivery",
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => onTabSwitch(2), // Switch to Transport tab
                      child: const Text("See All"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 220,
                child: transportProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: transportProvider.vehicles.length,
                        itemBuilder: (ctx, index) {
                          final vehicle = transportProvider.vehicles[index];
                          return VehicleCard(
                            vehicle: vehicle,
                            isHorizontal: true,
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

  Widget _categoryItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 76,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.25)),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _toolCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
