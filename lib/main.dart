import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posture_pal/core/services/notification_services.dart';
import 'package:posture_pal/features/dashboard/dashboard_screen.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const DashboardScreen(),
    );
  }
}
