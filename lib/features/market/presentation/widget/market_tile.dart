import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_helper.dart';
import '../../data/model/market_model.dart';
import '../providers/market_provider.dart';

class MarketTile extends StatelessWidget {
  final MarketModel market;
  const MarketTile({super.key, required this.market});

  @override
  Widget build(BuildContext context) {
    final isDue     = market.isDue;
    final color     = isDue ? AppTheme.red : AppTheme.green;
    final bgColor   = isDue ? const Color(0xFFFFEBEE) : const Color(0xFFE8F5E9);
    final provider  = context.read<MarketProvider>();

    return Card(
      color: bgColor,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          isDue ? Icons.pending_outlined : Icons.check_circle,
          color: color,
          size: 30,
        ),
        title: Text(market.item,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(DateHelper.format(market.date)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '৳${market.cost.toStringAsFixed(0)}',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: color),
            ),
            if (isDue)
              IconButton(
                icon: const Icon(Icons.check_circle_outline,
                    color: AppTheme.green),
                tooltip: 'Mark as paid',
                onPressed: () => provider.markPaid(market.id!),
              ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
              onPressed: () => provider.deleteMarket(market.id!),
            ),
          ],
        ),
      ),
    );
  }
}