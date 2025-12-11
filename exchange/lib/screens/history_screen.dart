import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ИСТОРИЯ'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: const [
          _HistoryItem(from: 'USD', to: 'RUB'),
          _HistoryItem(from: 'EUR', to: 'JPY'),
          _HistoryItem(from: 'GBP', to: 'USD'),
          _HistoryItem(from: 'BTC', to: 'USD'),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String from;
  final String to;

  const _HistoryItem({required this.from, required this.to});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$from → $to', style: const TextStyle(fontSize: 16)),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: null, // без логики удаления
      ),
      onTap: null, // без перехода обратно
    );
  }
}