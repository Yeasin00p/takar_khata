import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takar_khata/features/raising/presentation/widget/add_payment_sheet.dart';
import 'package:takar_khata/features/raising/presentation/widget/raising_app_bar.dart';

import '../providers/raising_providers.dart';
import '../widget/raising_empty_state.dart';
import '../widget/raising_fav.dart';
import '../widget/raising_widget.dart';

class RaisingScreen extends StatelessWidget {
  const RaisingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RaisingProvider>();
    final byFloor = provider.byFloor;

    return Scaffold(
      appBar: RaisingAppBar(totalRaised: provider.totalRaised),
      floatingActionButton: RaisingFab(
        onPressed: () => AddPaymentSheet.show(context),
      ),
      body: byFloor.isEmpty
          ? const RaisingEmptyState()
          : ListView(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
              children: byFloor.entries
                  .map((e) => FloorSection(floor: e.key, persons: e.value))
                  .toList(),
            ),
    );
  }
}
