import 'package:flutter/material.dart';
import 'package:test_soft_to_do/application.dart';
import 'package:test_soft_to_do/core/functions/setup_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const Application());
}