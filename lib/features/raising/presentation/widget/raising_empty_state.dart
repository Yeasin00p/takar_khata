import 'package:flutter/material.dart';

class RaisingEmptyState extends StatelessWidget {
  const RaisingEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No raisings yet. Tap + to add.',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}