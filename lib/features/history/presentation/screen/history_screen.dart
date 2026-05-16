import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../market/presentation/providers/market_provider.dart';
import '../../../raising/presentation/providers/raising_providers.dart';
import '../widget/history_date_header.dart';
import '../widget/history_event_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Map<String, List<Map<String, dynamic>>> _groupByDate(
    List<Map<String, dynamic>> events,
  ) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (final e in events) {
      final dateKey = (e['date'] as String).substring(0, 10);
      grouped.putIfAbsent(dateKey, () => []).add(e);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final raising = context.watch<RaisingProvider>();
    final market = context.watch<MarketProvider>();

    final List<Map<String, dynamic>> events = [
      for (final person in raising.persons)
        for (final pay in person.payments)
          {
            'type': 'raising',
            'title': person.name,
            'subtitle': 'Floor: ${person.floor}',
            'amount': pay.amount,
            'date': pay.date,
          },
      for (final m in market.markets)
        {
          'type': m.status,
          'title': m.item,
          'subtitle': m.isDue ? 'Due' : 'Paid',
          'amount': m.cost,
          'date': m.date,
        },
    ];

    events.sort((a, b) => (b['date'] as String).compareTo(a['date'] as String));

    if (events.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          centerTitle: true,
          backgroundColor: AppTheme.green,
        ),
        body: const Center(
          child: Text('No history yet', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    final grouped = _groupByDate(events);
    final dateKeys = grouped.keys.toList(); // already sorted since events are

    final List<Widget> listItems = [];
    for (final dateKey in dateKeys) {
      listItems.add(HistoryDateHeader(label: DateHelper.format(dateKey)));
      for (final e in grouped[dateKey]!) {
        listItems.add(
          HistoryEventTile(
            type: e['type'] as String,
            title: e['title'] as String,
            subtitle: e['subtitle'] as String,
            amount: e['amount'] as double,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppTheme.green,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: listItems,
      ),
    );
  }
}
