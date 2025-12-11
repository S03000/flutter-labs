import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            // Поле ввода суммы
            TextField(
              decoration: const InputDecoration(
                labelText: 'Сумма',
                hintText: '100',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Парa валют: из → в
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Из',
                      hintText: 'USD',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.arrow_forward),
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'В',
                      hintText: 'RUB',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Кнопка конвертации
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null, // без логики
                child: const Text('КОНВЕРТИРОВАТЬ', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 24),

            // Область результата
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '100 USD = 9234.50 RUB',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(), // отталкивает кнопку "История" вниз

            // Кнопка перехода в историю
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: null, // без навигации
                child: const Text('ИСТОРИЯ', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}