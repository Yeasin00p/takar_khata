import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class MarketAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final int dueCount;
  final int paidCount;

  const MarketAppBar({
    super.key,
    required this.controller,
    required this.dueCount,
    required this.paidCount,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Market'),
      backgroundColor: AppTheme.dark,

      bottom: TabBar(
        controller: controller,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        tabs: [
          Tab(text: 'Due ($dueCount)'),
          Tab(text: 'Paid ($paidCount)'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);
}
