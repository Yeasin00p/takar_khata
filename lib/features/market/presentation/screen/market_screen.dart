import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/market_provider.dart';
import '../widget/add_item_sheet.dart';
import '../widget/market_app_bar.dart';
import '../widget/market_fab.dart';
import '../widget/market_list.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MarketProvider>();

    return Scaffold(
      appBar: MarketAppBar(
        controller: _tab,
        dueCount: provider.dueMarkets.length,
        paidCount: provider.paidMarkets.length,
      ),

      floatingActionButton: MarketFab(onTap: () => showAddItemSheet(context)),

      body: TabBarView(
        controller: _tab,
        children: [
          MarketList(
            items: provider.dueMarkets,
            emptyText: 'No due markets 🎉',
          ),

          MarketList(
            items: provider.paidMarkets,
            emptyText: 'No paid markets yet',
          ),
        ],
      ),
    );
  }
}
