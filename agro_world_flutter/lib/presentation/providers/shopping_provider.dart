import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/models/payment_model.dart';
import '../../data/repositories/shopping_repository.dart';

enum ProductSortOption { none, lowToHigh, highToLow }

class ShoppingProvider extends ChangeNotifier {
  final ShoppingRepository _repository = ShoppingRepository();

  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
  final List<PaymentModel> _paymentHistory = [];

  bool _isLoading = false;
  String _searchQuery = "";
  ProductSortOption _currentSort = ProductSortOption.none;

  List<ProductModel> get products => _filteredProducts;
  List<ProductModel> get cartItems => _repository.getCartItems();
  List<PaymentModel> get paymentHistory => List.unmodifiable(_paymentHistory);
  int get cartCount => _repository.getCartItems().fold(0, (sum, item) => sum + item.quantity);
  double get cartTotal => _repository.getCartTotal();
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  ProductSortOption get currentSort => _currentSort;

  ShoppingProvider() {
    loadProducts();
  }

  Future<void> loadProducts({bool isHindi = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _allProducts = await _repository.getProducts(isHindi: isHindi);
      _applyFilterAndSort();
    } catch (_) {}

    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;
    _applyFilterAndSort();
  }

  void setSortOption(ProductSortOption sort) {
    _currentSort = sort;
    _applyFilterAndSort();
  }

  void _applyFilterAndSort() {
    List<ProductModel> temp = List.from(_allProducts);
    if (_searchQuery.trim().isNotEmpty) {
      temp = temp
          .where((p) =>
              p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              p.description.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    if (_currentSort == ProductSortOption.lowToHigh) {
      temp.sort((a, b) => a.price.compareTo(b.price));
    } else if (_currentSort == ProductSortOption.highToLow) {
      temp.sort((a, b) => b.price.compareTo(a.price));
    }

    _filteredProducts = temp;
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    _repository.addToCart(product);
    notifyListeners();
  }

  void removeFromCart(String title) {
    _repository.removeFromCart(title);
    notifyListeners();
  }

  void updateQuantity(String title, int quantity) {
    _repository.updateQuantity(title, quantity);
    notifyListeners();
  }

  void clearCart() {
    _repository.clearCart();
    notifyListeners();
  }

  Future<void> addProduct(ProductModel product, {bool isHindi = false}) async {
    await _repository.addProduct(product, isHindi: isHindi);
    await loadProducts(isHindi: isHindi);
  }

  Future<void> removeProduct(String title, {bool isHindi = false}) async {
    await _repository.removeProduct(title, isHindi: isHindi);
    await loadProducts(isHindi: isHindi);
  }

  void recordPayment(PaymentModel payment) {
    _paymentHistory.insert(0, payment);
    notifyListeners();
  }
}
