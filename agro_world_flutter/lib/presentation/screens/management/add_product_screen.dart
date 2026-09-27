import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/product_model.dart';
import '../../providers/shopping_provider.dart';

class AddProductScreen extends StatefulWidget {
  final bool isHindi;

  const AddProductScreen({super.key, this.isHindi = false});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _imageController = TextEditingController(
    text: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=600",
  );

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _saveProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      final shopping = Provider.of<ShoppingProvider>(context, listen: false);
      final price = double.tryParse(_priceController.text.trim()) ?? 0.0;

      await shopping.addProduct(
        ProductModel(
          title: _titleController.text.trim(),
          description: _descController.text.trim(),
          price: price,
          imageUrl: _imageController.text.trim(),
        ),
        isHindi: widget.isHindi,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Product added to AgroWorld marketplace!"),
            backgroundColor: AppColors.primary,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isHindi ? "उत्पाद जोड़ें (Hindi)" : "Add Seed Product"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Upload your certified seed variety to the AgroWorld farmer marketplace.",
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),

              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Seed Variety / Product Title",
                  hintText: "e.g., Mahyco Hybrid Cotton Seeds (450 gm)",
                  prefixIcon: Icon(Icons.grain_rounded),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? "Title is required" : null,
              ),
              const SizedBox(height: 14),

              // Price
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Price in Rupees (₹)",
                  hintText: "e.g., 1450.00",
                  prefixIcon: Icon(Icons.currency_rupee_rounded),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return "Price is required";
                  if (double.tryParse(val.trim()) == null) return "Enter a valid amount";
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Description
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Product Description & Yield Info",
                  hintText: "Enter germination rate, pest resistance, and maturation days...",
                  prefixIcon: Icon(Icons.notes_rounded),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? "Description is required" : null,
              ),
              const SizedBox(height: 14),

              // Image URL
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: "Product Image URL",
                  hintText: "Enter direct image link",
                  prefixIcon: Icon(Icons.image_outlined),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? "Image URL is required" : null,
              ),
              const SizedBox(height: 36),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveProduct,
                  icon: const Icon(Icons.publish_rounded),
                  label: const Text("Publish to Farmer Store"),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
