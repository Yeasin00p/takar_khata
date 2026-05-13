import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takar_khata/core/database/database_provider.dart';
import 'package:takar_khata/core/navigation/bottom_nav_screen.dart';
import 'package:takar_khata/features/raising/presentation/providers/raising_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseProvider.instance.init();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => RaisingProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Takar Khata',
      debugShowCheckedModeBanner: false,
      home: BottomNavScreen(),
    );
  }
}
