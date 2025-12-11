// lib/data/services/exchange_rate_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeRateService {
  static const String _baseUrl = 'https://v6.exchangerate-api.com/v6';
  static const String _apiKey = '6dd368ab8e859e7a0a1c4db3'; // ← ваш ключ

  Future<double> convert(String from, String to, double amount) async {
    if (from.isEmpty || to.isEmpty || amount <= 0) {
      throw Exception('Некорректные входные данные');
    }

    // Запрашиваем курсы относительно 'from'
    final url = '$_baseUrl/$_apiKey/latest/$from';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Ошибка сети: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);

    if (data['result'] != 'success') {
      final errorMsg = data['error-type'] ?? 'Неизвестная ошибка API';
      throw Exception('Ошибка API: $errorMsg');
    }

    final rates = data['conversion_rates'] as Map<String, dynamic>;

    if (!rates.containsKey(to)) {
      throw Exception('Валюта "$to" не поддерживается');
    }

    final rate = rates[to] as double;
    return amount * rate;
  }
}