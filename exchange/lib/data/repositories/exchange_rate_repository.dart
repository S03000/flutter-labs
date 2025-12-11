import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/currency_pair.dart';
import '../services/exchange_rate_service.dart';

class ExchangeRateRepository {
  final ExchangeRateService _service = ExchangeRateService();

  Future<double> convert(String from, String to, double amount) async {
    final result = await _service.convert(from, to, amount);
    await _saveToHistory(CurrencyPair(from, to));
    return result;
  }

  Future<void> _saveToHistory(CurrencyPair pair) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? historyJson = prefs.getStringList('history');
    final List<String> existing = historyJson ?? [];

    // Проверяем, нет ли уже такой пары
    final newEntry = jsonEncode(pair.toJson());
    if (existing.any((e) => jsonDecode(e) == pair.toJson())) {
      return; // уже есть — не дублируем
    }

    // Явно создаём List<String>
    final List<String> updated = [newEntry, ...existing];
    prefs.setStringList('history', updated);
  }

  Future<List<CurrencyPair>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? historyJson = prefs.getStringList('history');
    if (historyJson == null) return [];

    return historyJson
        .map((e) => CurrencyPair.fromJson(jsonDecode(e)))
        .toList();
  }

  Future<void> removeFromHistory(CurrencyPair pair) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? historyJson = prefs.getStringList('history');
    if (historyJson == null) return;

    final filtered = historyJson.where((e) {
      final p = CurrencyPair.fromJson(jsonDecode(e));
      return p != pair;
    }).toList();

    prefs.setStringList('history', filtered);
  }
}