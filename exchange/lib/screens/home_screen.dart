import 'package:flutter/material.dart';
import '../models/currency_pair.dart';

class HomeScreen extends StatefulWidget {
  final List<CurrencyPair> history;
  final Function(CurrencyPair) onConvert;

  const HomeScreen({
    super.key,
    required this.history,
    required this.onConvert,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _amountController = TextEditingController(text: '100');
  final _fromController = TextEditingController(text: 'USD');
  final _toController = TextEditingController(text: 'RUB');
  String _result = '100 USD = 9234.50 RUB';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Конвертер валют'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Сумма',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _fromController,
                    decoration: const InputDecoration(
                      labelText: 'Из',
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.characters,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.arrow_forward),
                ),
                Expanded(
                  child: TextField(
                    controller: _toController,
                    decoration: const InputDecoration(
                      labelText: 'В',
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.characters,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final amount = _amountController.text.trim();
                  final from = _fromController.text.trim().toUpperCase();
                  final to = _toController.text.trim().toUpperCase();

                  if (amount.isEmpty || from.isEmpty || to.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Заполните все поля')),
                    );
                    return;
                  }

                  // Здесь можно вызвать API, но пока — заглушка
                  final pair = CurrencyPair(from, to);
                  widget.onConvert(pair); // сохраняем в историю

                  // Обновляем результат
                  setState(() {
                    _result = '$amount $from = ??? $to';
                  });

                  // TODO: вызов ExchangeRate-API
                },
                child: const Text('КОНВЕРТИРОВАТЬ'),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _result,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}