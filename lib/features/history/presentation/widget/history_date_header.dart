import 'package:flutter/material.dart';
import 'package:takar_khata/core/theme/app_theme.dart';

class HistoryDateHeader extends StatelessWidget {
  const HistoryDateHeader({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.purple.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.purple,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Divider(
              color: AppTheme.purple.withOpacity(0.2),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
