import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_helper.dart';
import '../../data/model/person_model.dart';
import '../providers/raising_providers.dart';

class FloorSection extends StatelessWidget {
  final String floor;
  final List<PersonModel> persons;

  const FloorSection({super.key, required this.floor, required this.persons});

  @override
  Widget build(BuildContext context) {
    final floorTotal = persons.fold(0.0, (sum, p) => sum + p.totalAmount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Floor header
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.dark,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Floor: $floor',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                '৳${floorTotal.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Each person in this floor
        ...persons.map((p) => PersonTile(person: p)),
      ],
    );
  }
}

class PersonTile extends StatelessWidget {
  final PersonModel person;
  const PersonTile({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RaisingProvider>();

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.green,
          child: Text(
            person.name[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          person.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${person.payments.length} payment(s)'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '৳${person.totalAmount.toStringAsFixed(0)}',
              style: const TextStyle(
                color: AppTheme.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.person_remove,
                color: Colors.red,
                size: 20,
              ),
              tooltip: 'Delete person & all payments',
              onPressed: () => _confirmDeletePerson(context, provider),
            ),
          ],
        ),
        // Expanded: list each individual payment
        children: [
          ...person.payments.map(
            (pay) => ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 0,
              ),
              leading: const Icon(
                Icons.payments_outlined,
                color: AppTheme.green,
                size: 20,
              ),
              title: Text(
                DateHelper.format(pay.date),
                style: const TextStyle(fontSize: 14),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '৳${pay.amount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.green,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                      size: 18,
                    ),
                    tooltip: 'Delete this payment',
                    onPressed: () => provider.deletePayment(pay.id!),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  void _confirmDeletePerson(BuildContext context, RaisingProvider provider) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete person?'),
        content: Text(
          'This will delete ${person.name} and ALL their payments. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              provider.deletePerson(person.id!);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
