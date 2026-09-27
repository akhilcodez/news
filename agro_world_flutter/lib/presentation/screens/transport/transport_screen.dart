import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/transport_provider.dart';
import '../../widgets/vehicle_card.dart';
import '../../widgets/empty_state_widget.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transportProvider = Provider.of<TransportProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Transport"),
        actions: [
          // Filter by Rate Sort
          PopupMenuButton<VehicleSortOption>(
            icon: const Icon(Icons.sort_rounded, color: AppColors.primary),
            tooltip: "Sort by Rate",
            onSelected: (sort) {
              transportProvider.setSortOption(sort);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: VehicleSortOption.none,
                child: Text("Default Order"),
              ),
              const PopupMenuItem(
                value: VehicleSortOption.lowToHigh,
                child: Text("Rate: Low to High"),
              ),
              const PopupMenuItem(
                value: VehicleSortOption.highToLow,
                child: Text("Rate: High to Low"),
              ),
            ],
          ),

          // Filter by District / Location Menu
          PopupMenuButton<String>(
            icon: const Icon(Icons.location_on_rounded, color: AppColors.primary),
            tooltip: "Filter by District / Mandi",
            onSelected: (loc) {
              transportProvider.filterByLocation(loc);
            },
            itemBuilder: (context) => AppConstants.locations.map((loc) {
              return PopupMenuItem<String>(
                value: loc,
                child: Text(loc),
              );
            }).toList(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Location horizontal chips row
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: AppConstants.locations.take(12).length,
              itemBuilder: (ctx, index) {
                final loc = AppConstants.locations[index];
                final isSelected = transportProvider.selectedLocation == loc;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(loc),
                    selected: isSelected,
                    onSelected: (_) => transportProvider.filterByLocation(loc),
                    selectedColor: AppColors.primaryContainer,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.primaryDark : AppColors.textSecondary,
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: transportProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : transportProvider.vehicles.isEmpty
                    ? EmptyStateWidget(
                        icon: Icons.no_transfer_rounded,
                        title: "No Vehicles Found",
                        message:
                            "Looks like Transport community hasn't added any vehicles for ${transportProvider.selectedLocation}.",
                        actionLabel: "Show All Locations",
                        onAction: () => transportProvider.filterByLocation("All Locations"),
                      )
                    : RefreshIndicator(
                        onRefresh: () => transportProvider.loadVehicles(),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          itemCount: transportProvider.vehicles.length,
                          itemBuilder: (ctx, index) {
                            final vehicle = transportProvider.vehicles[index];
                            return VehicleCard(vehicle: vehicle);
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
