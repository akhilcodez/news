import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/recommendation_models.dart';

class MandiPriceCard extends StatelessWidget {
  final MarketPriceModel price;
  final bool isHindi;

  const MandiPriceCard({
    super.key,
    required this.price,
    this.isHindi = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = price.priceChangePercent >= 0;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isHindi ? price.commodityHi : price.commodity,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text(
                            "${price.mandi} (${price.district})",
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? Colors.green.withValues(alpha: 0.12)
                        : Colors.red.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        size: 16,
                        color: isPositive ? Colors.green.shade800 : Colors.red.shade800,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${isPositive ? '+' : ''}${price.priceChangePercent}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isPositive ? Colors.green.shade800 : Colors.red.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriceColumn(
                  isHindi ? "किमान भाव" : "Min Price",
                  "₹${price.minPrice.toStringAsFixed(0)}",
                  Colors.grey.shade700,
                ),
                _buildPriceColumn(
                  isHindi ? "कमाल भाव" : "Max Price",
                  "₹${price.maxPrice.toStringAsFixed(0)}",
                  Colors.blue.shade800,
                ),
                _buildPriceColumn(
                  isHindi ? "सरासरी भाव" : "Modal Price",
                  "₹${price.modalPrice.toStringAsFixed(0)}",
                  AppColors.primary,
                  isHighlight: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceColumn(String label, String value, Color color, {bool isHighlight = false}) {
    return Column(
      crossAxisAlignment: isHighlight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
            fontWeight: isHighlight ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlight ? 18 : 15,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
