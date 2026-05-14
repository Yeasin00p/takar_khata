import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class MarketFab extends StatelessWidget {
  final VoidCallback onTap;

  const MarketFab({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onTap,
      backgroundColor: AppTheme.dark,

      icon: const Icon(Icons.add, color: Colors.white),

      label: const Text('Add Market', style: TextStyle(color: Colors.white)),
    );
  }
}
