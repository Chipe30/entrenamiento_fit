
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  const SettingsScreen({super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: SwitchListTile(
        title: const Text('Modo Oscuro'),
        value: isDarkMode,
        onChanged: toggleTheme,
        secondary: const Icon(Icons.brightness_6),
      ),
    );
  }
}
