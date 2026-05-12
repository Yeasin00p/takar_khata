import 'package:flutter/material.dart';
import 'package:takar_khata/core/theme/app_theme.dart';
import 'package:takar_khata/features/raising/presentation/widget/show_add_sheet_widget.dart';

class RaisingScreen extends StatelessWidget {
  const RaisingScreen({super.key});

  void _openAddPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddPaymentSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Raisings',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        backgroundColor: AppTheme.green,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(36),
          child: Container(
            color: AppTheme.green,
            padding: EdgeInsets.all(16),
            child: Text(
              'Total Raised: ৳',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddPaymentSheet(context),
        backgroundColor: AppTheme.green,
        icon: Icon(Icons.add, color: Colors.white),
        label: const Text('Add Payment', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
