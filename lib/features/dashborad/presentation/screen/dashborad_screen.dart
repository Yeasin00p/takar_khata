import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takar_khata/features/dashborad/presentation/widget/overview_card_widget.dart';

import '../../../market/presentation/providers/market_provider.dart';
import '../../../raising/presentation/providers/raising_providers.dart';

class DashboradScreen extends StatelessWidget {
  const DashboradScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final raising = context.watch<RaisingProvider>();
    final market = context.watch<MarketProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          OverviewCardWidget(
            label: 'Total Raised',
            amount: raising.totalRaised,
            color: Colors.green,
            icon: Icons.arrow_upward,
          ),
          const SizedBox(height: 10),
          OverviewCardWidget(
            label: 'Total paid',
            amount: market.totalPaid,
            color: Colors.blue,
            icon: Icons.check_circle,
          ),
          const SizedBox(height: 10),

          OverviewCardWidget(
            label: 'Total Due',
            amount: market.totalDue,
            color: Colors.red,
            icon: Icons.warning_amber_rounded,
          ),
          const SizedBox(height: 10),

          OverviewCardWidget(
            label: 'Balance',
            amount: market.balance,
            color: Colors.purple,
            icon: Icons.account_balance_wallet,
          ),
        ],
      ),
    );
  }
}
