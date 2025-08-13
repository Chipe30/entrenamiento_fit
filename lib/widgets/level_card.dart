
import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  final String title;
  final String routeName;
  final Color color;

  const LevelCard({super.key, required this.title, required this.routeName, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: color.withOpacity(0.8),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 20, color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () => Navigator.pushNamed(context, routeName),
      ),
    );
  }
}
