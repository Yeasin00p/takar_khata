import 'package:flutter/material.dart';

import '../../data/model/market_model.dart';

import 'market_empty_state.dart';
import 'market_tile.dart';

class MarketList extends StatelessWidget {
  final List<MarketModel> items;
  final String emptyText;

  const MarketList({super.key, required this.items, required this.emptyText});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return MarketEmptyState(text: emptyText);
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 80),
      itemCount: items.length,
      itemBuilder: (_, i) {
        return MarketTile(market: items[i]);
      },
    );
  }
}
