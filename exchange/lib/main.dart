import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
// import 'screens/history_screen.dart'; // переключайте при тестировании

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(), // или HistoryScreen() для проверки второго экрана
    );
  }
}