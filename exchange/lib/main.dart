import 'package:flutter/material.dart';
import 'ui/home/home_screen.dart';
import 'data/repositories/exchange_rate_repository.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ExchangeRateRepository(); // можно через DI, но для простоты — так

    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      home: HomeScreen(repository: repository),
    );
  }
}