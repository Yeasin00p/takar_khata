import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/date_helper.dart';
import '../providers/raising_providers.dart';

class AddPaymentSheet extends StatefulWidget {
  const AddPaymentSheet({super.key});

  /// Convenience method — call from anywhere with just a [BuildContext].
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddPaymentSheet(),
    );
  }

  @override
  State<AddPaymentSheet> createState() => _AddPaymentSheetState();
}

class _AddPaymentSheetState extends State<AddPaymentSheet> {
  final _nameCtrl = TextEditingController();
  final _floorCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  late String _date;

  @override
  void initState() {
    super.initState();
    _date = DateHelper.today();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _floorCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _nameCtrl.text.trim().isNotEmpty && _amountCtrl.text.trim().isNotEmpty;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _date = picked.toIso8601String().substring(0, 10));
    }
  }

  Future<void> _save() async {
    if (!_isValid) return;
    await context.read<RaisingProvider>().addPayment(
      name: _nameCtrl.text.trim(),
      floor: _floorCtrl.text.trim().isEmpty
          ? 'Unknown Floor'
          : _floorCtrl.text.trim(),
      amount: double.tryParse(_amountCtrl.text) ?? 0,
      date: _date,
    );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Payment',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Same name + floor = grouped under existing person.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _nameCtrl,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Person Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _floorCtrl,
            decoration: const InputDecoration(
              labelText: 'Floor (e.g. 3rd) — optional',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _amountCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount (৳)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          _DatePickerTile(date: _date, onTap: _pickDate),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _save,
              child: const Text('Save', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DatePickerTile extends StatelessWidget {
  const _DatePickerTile({required this.date, required this.onTap});

  final String date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 18),
            const SizedBox(width: 8),
            Text(DateHelper.format(date)),
          ],
        ),
      ),
    );
  }
}
