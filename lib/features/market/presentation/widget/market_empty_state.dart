import 'package:flutter/material.dart';

class MarketEmptyState extends StatelessWidget {
  final String text;

  const MarketEmptyState({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }
}
