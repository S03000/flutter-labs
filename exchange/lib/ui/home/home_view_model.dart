import 'package:flutter/foundation.dart';
import '../../data/models/currency_pair.dart';
import '../../data/repositories/exchange_rate_repository.dart';

class HomeViewModel with ChangeNotifier {
  final ExchangeRateRepository _repository;
  String _result = '';
  bool _isLoading = false;

  HomeViewModel(this._repository);

  String get result => _result;
  bool get isLoading => _isLoading;

  Future<void> convert({
    required String from,
    required String to,
    required double amount,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final converted = await _repository.convert(from, to, amount);
      _result = '${amount.toStringAsFixed(2)} $from = ${converted.toStringAsFixed(2)} $to';
    } catch (e) {
      _result = e.toString().replaceFirst(RegExp(r'^Exception: '), '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}