import 'package:flutter/material.dart';
import 'package:test_soft_to_do/presentation/screens/home.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}