import 'package:flutter/material.dart';

import '../../../../core/utils/date_helper.dart';
import '../../../market/data/model/market_model.dart';

class DueTile extends StatelessWidget {
  final MarketModel market;

  const DueTile({super.key, required this.market});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFEBEE),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.pending, color: Colors.red),
        title: Text(
          market.item,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(DateHelper.format(market.date)),
        trailing: Text(
          '৳${market.cost.toStringAsFixed(0)}',
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
