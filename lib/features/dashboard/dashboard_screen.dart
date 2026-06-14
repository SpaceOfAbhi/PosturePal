import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posture_pal/core/providers/posture_provider.dart';
import 'package:posture_pal/features/stretch/stretch_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool isReminderShowing = false;
  bool dialogOpen = false;
  @override
  void initState() {
    super.initState();

    ref.listenManual(postureProvider, (previous, next) {
      if (previous?.remindersToday != next.remindersToday && !dialogOpen) {
        dialogOpen = true;

        showReminderDialog();
      }
    });
  }

  void showReminderDialog() {
    isReminderShowing = true;
    showDialog(
      context: context,
      builder: (_) {
        return SingleChildScrollView(
          child: Dialog(
            child: Container(
              width: 280,
              height: 280,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Time For A Check',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'You have been inactive for 20 minutes.',
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        dialogOpen = false;
                        isReminderShowing = false;
                        Navigator.pop(context);
                      },
                      child: const Text("I'm Fine"),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StretchScreen(),
                          ),
                        );
                      },
                      child: const Text("Stretch"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final posture = ref.watch(postureProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5),
                  const Text(
                    "PosturePal",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  Text(posture.isMoving ? '🟢 Moving' : '🔴 Still'),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sitting Time",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '${posture.stationaryMinutes ~/ 60} Min',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            "Reminders Today : ${posture.remindersToday}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            "Stretches Completed : ${posture.stretchesCompleted}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
