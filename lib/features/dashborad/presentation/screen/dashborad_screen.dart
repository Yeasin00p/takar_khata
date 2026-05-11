import 'package:flutter/material.dart';
import 'package:takar_khata/features/dashborad/presentation/widget/overview_card_widget.dart';

class DashboradScreen extends StatelessWidget {
  const DashboradScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          OverviewCardWidget(
            label: 'Total Raised',
            amount: 300,
            color: Colors.green,
            icon: Icons.arrow_downward,
          ),
          const SizedBox(height: 10),
          OverviewCardWidget(
            label: 'Total Raised',
            amount: 300,
            color: Colors.blue,
            icon: Icons.check_circle,
          ),
          const SizedBox(height: 10),

          OverviewCardWidget(
            label: 'Total Raised',
            amount: 300,
            color: Colors.red,
            icon: Icons.warning_amber_rounded,
          ),
          const SizedBox(height: 10),

          OverviewCardWidget(
            label: 'Total Raised',
            amount: 500,
            color: Colors.purple,
            icon: Icons.account_balance_wallet,
          ),
        ],
      ),
    );
  }
}
