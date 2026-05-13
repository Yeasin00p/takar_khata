import 'package:flutter/material.dart';

class OverviewCardWidget extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  final IconData icon;
  const OverviewCardWidget({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
        border: Border(left: BorderSide(color: color, width: 5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Column(
            children: [
              Text(label, style: TextStyle(color: Colors.grey, fontSize: 13)),
              Text(
                '৳ ${amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
