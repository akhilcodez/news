import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/language_provider.dart';
import '../../providers/smart_tools_provider.dart';
import '../../widgets/empty_state_widget.dart';
import '../../widgets/mandi_price_card.dart';

class MarketPricesScreen extends StatefulWidget {
  const MarketPricesScreen({super.key});

  @override
  State<MarketPricesScreen> createState() => _MarketPricesScreenState();
}

class _MarketPricesScreenState extends State<MarketPricesScreen> {
  final _searchController = TextEditingController();
  String _selectedDistrict = "All Locations";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPrices();
    });
  }

  void _loadPrices() {
    final isHindi = Provider.of<LanguageProvider>(context, listen: false).isHindi;
    Provider.of<SmartToolsProvider>(context, listen: false).fetchMarketPrices(
      query: _searchController.text,
      district: _selectedDistrict,
      isHindi: isHindi,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHindi = Provider.of<LanguageProvider>(context).isHindi;
    final toolsProvider = Provider.of<SmartToolsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? "बाजार भाव (कृषी उत्पन्न बाजार समिती)" : "APMC Mandi Market Prices"),
      ),
      body: Column(
        children: [
          // Search & Filter header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Column(
              children: [
                // Search bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: isHindi ? "पीक किंवा बाजार समिती शोधा..." : "Search crop or mandi yard...",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _loadPrices();
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  onChanged: (val) {
                    _loadPrices();
                  },
                ),
                const SizedBox(height: 10),

                // District chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: AppConstants.locations.map((loc) {
                      final isSelected = _selectedDistrict == loc;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(loc),
                          selected: isSelected,
                          selectedColor: AppColors.primary.withValues(alpha: 0.15),
                          checkmarkColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 12,
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _selectedDistrict = loc;
                            });
                            _loadPrices();
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Price List
          Expanded(
            child: toolsProvider.isLoadingPrices
                ? const Center(child: CircularProgressIndicator())
                : toolsProvider.marketPrices.isEmpty
                    ? const EmptyStateWidget(
                        title: "No Mandi Rates Found",
                        subtitle: "Try changing your search keywords or district filter.",
                        icon: Icons.storefront_outlined,
                      )
                    : RefreshIndicator(
                        onRefresh: () async => _loadPrices(),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: toolsProvider.marketPrices.length,
                          itemBuilder: (context, index) {
                            final price = toolsProvider.marketPrices[index];
                            return MandiPriceCard(price: price, isHindi: isHindi);
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
