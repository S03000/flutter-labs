import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../history/history_screen.dart';
import 'home_view_model.dart';
import '/data/repositories/exchange_rate_repository.dart';
import '/data/models/currency_pair.dart';

class HomeScreen extends StatefulWidget {
  final ExchangeRateRepository repository;

  const HomeScreen({super.key, required this.repository});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _amountController = TextEditingController(text: '100');
  final _fromController = TextEditingController(text: 'USD');
  final _toController = TextEditingController(text: 'RUB');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(widget.repository),
      child: Scaffold(
        appBar: AppBar(title: const Text('Конвертер валют'), centerTitle: true),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Сумма'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _fromController,
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(labelText: 'Из'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final temp = _fromController.text;
                          _fromController.text = _toController.text;
                          _toController.text = temp;
                        },
                        icon: const Icon(Icons.swap_vert),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _toController,
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(labelText: 'В'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: viewModel.isLoading
                          ? null
                          : () async {
                        final amount = double.tryParse(_amountController.text) ?? 0.0;
                        final from = _fromController.text.trim().toUpperCase();
                        final to = _toController.text.trim().toUpperCase();

                        if (amount <= 0 || from.isEmpty || to.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Заполните все поля')),
                          );
                          return;
                        }

                        try {
                          await viewModel.convert(from: from, to: to, amount: amount);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      },
                      child: viewModel.isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Конвертировать'),
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
                      viewModel.result.isEmpty ? 'Результат появится здесь' : viewModel.result,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => HistoryScreen(repository: widget.repository)),
                        );
                        if (result is CurrencyPair) {
                          _fromController.text = result.from;
                          _toController.text = result.to;
                        }
                      },
                      icon: const Icon(Icons.history),
                      label: const Text('История'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}