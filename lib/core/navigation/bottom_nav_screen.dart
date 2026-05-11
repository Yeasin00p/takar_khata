import 'package:flutter/material.dart';
import 'package:takar_khata/features/dashborad/presentation/screen/dashborad_screen.dart';
import 'package:takar_khata/features/history/presentation/screen/history_screen.dart';
import 'package:takar_khata/features/market/presentation/screen/market_screen.dart';
import 'package:takar_khata/features/raising/presentation/screen/raising_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});
  @override
  State<BottomNavScreen> createState() => _NavState();
}

class _NavState extends State<BottomNavScreen> {
  int _index = 0;

  static const _screens = [
    DashboradScreen(),
    RaisingScreen(),
    MarketScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: _screens[_index],
    bottomNavigationBar: NavigationBar(
      selectedIndex: _index,
      onDestinationSelected: (i) => setState(() => _index = i),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        NavigationDestination(
          icon: Icon(Icons.group_outlined),
          selectedIcon: Icon(Icons.group),
          label: 'Raising',
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_cart_outlined),
          selectedIcon: Icon(Icons.shopping_cart),
          label: 'Market',
        ),
        NavigationDestination(icon: Icon(Icons.history), label: 'History'),
      ],
    ),
  );
}
