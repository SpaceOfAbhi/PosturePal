import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Text(
                'PosturePal',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 20),

              const Text(
                '82%',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text('Good Posture'),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Focus Mode',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}