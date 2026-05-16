import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class RaisingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RaisingAppBar({super.key, required this.totalRaised});

  final double totalRaised;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 36);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Raisings'),
      centerTitle: true,
      backgroundColor: AppTheme.green,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(36),
        child: Container(
          color: AppTheme.green,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Total Raised: ৳${totalRaised.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}