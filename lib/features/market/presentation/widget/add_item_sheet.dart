import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_helper.dart';

import '../../data/model/market_model.dart';
import '../providers/market_provider.dart';

void showAddItemSheet(BuildContext context) {
  final itemCtrl = TextEditingController();
  final costCtrl = TextEditingController();

  String date = DateHelper.today();
  String status = 'due';

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),

    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Market Entry',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 14),

                TextField(
                  controller: itemCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Item / Description',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: costCtrl,
                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: 'Cost (৳)',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );

                    if (picked != null) {
                      setState(() {
                        date = picked.toIso8601String().substring(0, 10);
                      });
                    }
                  },

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
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Text('Status:'),

                    const SizedBox(width: 10),

                    ChoiceChip(
                      label: const Text('Due'),
                      selected: status == 'due',
                      onSelected: (_) {
                        setState(() => status = 'due');
                      },
                    ),

                    const SizedBox(width: 8),

                    ChoiceChip(
                      label: const Text('Paid'),
                      selected: status == 'paid',
                      onSelected: (_) {
                        setState(() => status = 'paid');
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.dark,
                      foregroundColor: Colors.white,
                    ),

                    onPressed: () async {
                      if (itemCtrl.text.trim().isEmpty ||
                          costCtrl.text.trim().isEmpty) {
                        return;
                      }

                      try {
                        await context.read<MarketProvider>().addMarket(
                          MarketModel(
                            item: itemCtrl.text.trim(),
                            cost: double.tryParse(costCtrl.text) ?? 0,
                            date: date,
                            status: status,
                          ),
                        );

                        debugPrint('Saved Successfully');

                        if (ctx.mounted) {
                          Navigator.pop(ctx);
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },

                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
