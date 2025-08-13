import 'package:flutter/material.dart';
import '../widgets/level_card.dart';

class HomeScreen extends StatelessWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    Key? key,
    required this.toggleTheme,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrenamiento'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          LevelCard(
            title: 'Nivel Básico',
            routeName: '/basic',
            color: Colors.green,
          ),
          LevelCard(
            title: 'Nivel Intermedio',
            routeName: '/intermediate',
            color: Colors.orange,
          ),
          LevelCard(
            title: 'Nivel Avanzado',
            routeName: '/advanced',
            color: Colors.red,
          ),
          LevelCard(
            title: 'Recomendaciones Comunidad',
            routeName: '/community',
            color: Color.fromARGB(255, 3, 209, 250),
          ),
        ],
      ),
    );
  }
}
