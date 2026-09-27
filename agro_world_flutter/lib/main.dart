import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/chatbot_provider.dart';
import 'presentation/providers/knowledge_provider.dart';
import 'presentation/providers/language_provider.dart';
import 'presentation/providers/shopping_provider.dart';
import 'presentation/providers/smart_tools_provider.dart';
import 'presentation/providers/task_provider.dart';
import 'presentation/providers/transport_provider.dart';
import 'presentation/providers/weather_provider.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AgroWorldApp());
}

class AgroWorldApp extends StatelessWidget {
  const AgroWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => KnowledgeProvider()),
        ChangeNotifierProvider(create: (_) => ShoppingProvider()),
        ChangeNotifierProvider(create: (_) => TransportProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ChatBotProvider()),
        ChangeNotifierProvider(create: (_) => SmartToolsProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, lang, child) {
          return MaterialApp(
            title: 'AgroWorld',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
