import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/language_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../home/home_screen.dart';
import '../shopping/shopping_screen.dart';
import '../transport/transport_screen.dart';
import '../knowledge/knowledge_screen.dart';
import '../news/news_screen.dart';
import '../profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  DateTime? _lastPressedAt;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isHindi = languageProvider.isHindi;

    final List<Widget> screens = [
      HomeScreen(onTabSwitch: _onTabSelected),
      const ShoppingScreen(),
      const TransportScreen(),
      const KnowledgeScreen(),
      const NewsScreen(),
      const ProfileScreen(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final now = DateTime.now();
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return;
        }

        if (_lastPressedAt == null || now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          _lastPressedAt = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Press once again to exit!"),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return;
        }
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: _currentIndex == 0
            ? const CustomAppBar(
                title: "AgroWorld",
                showLanguageToggle: true,
                automaticallyImplyLeading: false,
              )
            : null,
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: _onTabSelected,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home_rounded, color: AppColors.primaryDark),
              label: isHindi ? "होम" : "Home",
            ),
            NavigationDestination(
              icon: const Icon(Icons.shopping_bag_outlined),
              selectedIcon: const Icon(Icons.shopping_bag_rounded, color: AppColors.primaryDark),
              label: isHindi ? "बीज स्टोर" : "Seeds",
            ),
            NavigationDestination(
              icon: const Icon(Icons.local_shipping_outlined),
              selectedIcon: const Icon(Icons.local_shipping_rounded, color: AppColors.primaryDark),
              label: isHindi ? "परिवहन" : "Transport",
            ),
            NavigationDestination(
              icon: const Icon(Icons.menu_book_outlined),
              selectedIcon: const Icon(Icons.menu_book_rounded, color: AppColors.primaryDark),
              label: isHindi ? "ज्ञान" : "Knowledge",
            ),
            NavigationDestination(
              icon: const Icon(Icons.newspaper_outlined),
              selectedIcon: const Icon(Icons.newspaper_rounded, color: AppColors.primaryDark),
              label: isHindi ? "समाचार" : "News",
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline_rounded),
              selectedIcon: const Icon(Icons.person_rounded, color: AppColors.primaryDark),
              label: isHindi ? "प्रोफ़ाइल" : "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
