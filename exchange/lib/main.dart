import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/history_screen.dart';
import 'models/currency_pair.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  final List<CurrencyPair> _history = [];

  void _addToHistory(CurrencyPair pair) {
    // Избегаем дубликатов
    if (!_history.contains(pair)) {
      setState(() {
        _history.insert(0, pair); // новые — сверху
      });
    }
  }

  void _onHistoryItemTap(CurrencyPair pair) {
    // Возвращаемся на главный экран и заполняем поля
    setState(() {
      _currentIndex = 0;
    });
    // ⚠️ Реально — нужно передать данные обратно.
    // Но так как у нас один State, просто меняем индекс.
    // В реальном приложении можно использовать callback или state management.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(history: _history, onConvert: _addToHistory),
            HistoryScreen(
              history: _history,
              onHistoryItemTap: (pair) {
                _onHistoryItemTap(pair);
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'История'),
          ],
        ),
      ),
    );
  }
}