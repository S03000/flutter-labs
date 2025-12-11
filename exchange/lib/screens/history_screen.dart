import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // для Clipboard
import '../models/currency_pair.dart';

class HistoryScreen extends StatefulWidget {
  final List<CurrencyPair> history;
  final Function(CurrencyPair) onHistoryItemTap;

  const HistoryScreen({
    super.key,
    required this.history,
    required this.onHistoryItemTap,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ИСТОРИЯ'),
        centerTitle: true,
      ),
      body: widget.history.isEmpty
          ? const Center(child: Text('История пуста'))
          : ListView.builder(
        itemCount: widget.history.length,
        itemBuilder: (context, index) {
          final pair = widget.history[index];
          return Dismissible(
            key: Key('${pair.from}-${pair.to}'),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              setState(() {
                widget.history.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text('${pair.from} → ${pair.to}'),
              onTap: () {
                widget.onHistoryItemTap(pair);
              },
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: '${pair.from} → ${pair.to}'));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Скопировано в буфер обмена')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}