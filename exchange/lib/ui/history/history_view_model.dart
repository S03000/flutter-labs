import 'package:flutter/foundation.dart';
import '../../data/models/currency_pair.dart';
import '../../data/repositories/exchange_rate_repository.dart';

class HistoryViewModel with ChangeNotifier {
  final ExchangeRateRepository _repo;
  List<CurrencyPair> _history = [];

  HistoryViewModel(this._repo);

  List<CurrencyPair> get history => _history;

  Future<void> loadHistory() async {
    _history = await _repo.getHistory();
    notifyListeners();
  }

  Future<void> remove(CurrencyPair pair) async {
    await _repo.removeFromHistory(pair);
    await loadHistory(); // Обновляем список после удаления
  }
}