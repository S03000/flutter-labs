import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/exchange_rate_repository.dart';
import '../home/home_screen.dart';
import 'history_view_model.dart';

class HistoryScreen extends StatefulWidget {
  final ExchangeRateRepository repository;

  const HistoryScreen({super.key, required this.repository});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late HistoryViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HistoryViewModel(widget.repository);
    _viewModel.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(title: const Text('История'), centerTitle: true),
        body: Consumer<HistoryViewModel>(
          builder: (context, viewModel, _) {
            return viewModel.history.isEmpty
                ? const Center(child: Text('История пуста'))
                : ListView.builder(
              itemCount: viewModel.history.length,
              itemBuilder: (context, index) {
                final pair = viewModel.history[index];
                return ListTile(
                  title: Text('${pair.from} → ${pair.to}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => viewModel.remove(pair),
                  ),
                  onTap: () {
                    Navigator.pop(context, pair); // Возвращаем пару в HomeScreen
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}