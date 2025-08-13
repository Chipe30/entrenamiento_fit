import 'package:entrenamiento_fit/views/community_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/basic_level_screen.dart';
import 'views/intermediate_level_screen.dart';
import 'views/advanced_level_screen.dart';
import 'views/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AbsApp());
}

class AbsApp extends StatefulWidget {
  const AbsApp({Key? key}) : super(key: key);

  @override
  State<AbsApp> createState() => _AbsAppState();
}

class _AbsAppState extends State<AbsApp> {
  bool isDarkMode = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abs App',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/':
            (context) =>
                HomeScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
        '/basic': (context) => const BasicLevelScreen(),
        '/intermediate': (context) => const IntermediateLevelScreen(),
        '/advanced': (context) => const AdvancedLevelScreen(),
        '/settings':
            (context) => SettingsScreen(
              toggleTheme: toggleTheme,
              isDarkMode: isDarkMode,
            ),
        '/community': (context) => const CommunityScreen(),
      },
    );
  }
}
