import 'package:flutter/material.dart';
import 'package:takar_khata/core/theme/app_theme.dart';

class HistoryEventTile extends StatelessWidget {
  const HistoryEventTile({
    super.key,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.amount,
  });
 
  final String type;
  final String title;
  final String subtitle;
  final double amount;
 
  Color get _color {
    if (type == 'raising') return AppTheme.green;
    if (type == 'due') return AppTheme.red;
    return AppTheme.blue;
  }
 
  IconData get _icon {
    if (type == 'raising') return Icons.arrow_upward;
    if (type == 'due') return Icons.pending_outlined;
    return Icons.check_circle;
  }
 
  String get _amountPrefix => type == 'raising' ? '+' : '-';
 
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _color.withOpacity(0.15),
          child: Icon(_icon, color: _color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Text(
          '$_amountPrefix৳${amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: _color,
          ),
        ),
      ),
    );
  }
}