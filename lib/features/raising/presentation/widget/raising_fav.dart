import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class RaisingFab extends StatelessWidget {
  const RaisingFab({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: AppTheme.green,
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text('Add Payment', style: TextStyle(color: Colors.white)),
    );
  }
}