import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/shopping_provider.dart';
import '../../widgets/product_card.dart';
import '../../widgets/empty_state_widget.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';
import '../profile/payment_history_screen.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingProvider = Provider.of<ShoppingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Seeds Marketplace"),
        actions: [
          PopupMenuButton<ProductSortOption>(
            icon: const Icon(Icons.sort_rounded, color: AppColors.primary),
            tooltip: "Sort by Price",
            onSelected: (sort) {
              shoppingProvider.setSortOption(sort);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ProductSortOption.none,
                child: Text("Default Order"),
              ),
              const PopupMenuItem(
                value: ProductSortOption.lowToHigh,
                child: Text("Price: Low to High"),
              ),
              const PopupMenuItem(
                value: ProductSortOption.highToLow,
                child: Text("Price: High to Low"),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.receipt_long_rounded, color: AppColors.primary),
            tooltip: "Transaction History",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PaymentHistoryScreen()),
              );
            },
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.primary),
                tooltip: "Cart",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
              ),
              if (shoppingProvider.cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      "${shoppingProvider.cartCount}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
            child: TextField(
              onChanged: (val) => shoppingProvider.search(val),
              decoration: InputDecoration(
                hintText: "Search certified seeds, crops, brands...",
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                suffixIcon: shoppingProvider.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 20),
                        onPressed: () => shoppingProvider.search(""),
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // Active Sort indicator if sorted
          if (shoppingProvider.currentSort != ProductSortOption.none)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          shoppingProvider.currentSort == ProductSortOption.lowToHigh
                              ? "Sorted: Low to High"
                              : "Sorted: High to Low",
                          style: const TextStyle(fontSize: 12, color: AppColors.primaryDark, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () => shoppingProvider.setSortOption(ProductSortOption.none),
                          child: const Icon(Icons.close_rounded, size: 14, color: AppColors.primaryDark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: shoppingProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : shoppingProvider.products.isEmpty
                    ? const EmptyStateWidget(
                        icon: Icons.search_off_rounded,
                        title: "No Seeds Found",
                        message: "We couldn't find any seed items matching your search query. Try another keyword.",
                      )
                    : RefreshIndicator(
                        onRefresh: () => shoppingProvider.loadProducts(),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          itemCount: shoppingProvider.products.length,
                          itemBuilder: (ctx, index) {
                            final product = shoppingProvider.products[index];
                            return ProductCard(
                              product: product,
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
          ),
        ],
      ),
    );
  }
}
