import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posture_pal/core/providers/posture_provider.dart';
import 'package:posture_pal/features/dashboard/dashboard_screen.dart';

class StretchScreen extends ConsumerStatefulWidget {
  const StretchScreen({super.key});

  @override
  ConsumerState<StretchScreen> createState() => _StretchScreenState();
}

class _StretchScreenState extends ConsumerState<StretchScreen> {
  int currentIndex = 0;

  final stretches = [
    {
      "title": "Neck Stretch",
      "description": "Slowly tilt your head left and right.",
      "asset": "assets/stretches/neck.png",
    },
    {
      "title": "Shoulder Rolls",
      "description": "Roll your shoulders forward and backward.",
      "asset": "assets/stretches/shoulders.png",
    },
    {
      "title": "Seated Twist",
      "description":
          "Twist gently to each side while keeping your hips forward.",
      "asset": "assets/stretches/hips.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final stretch = stretches[currentIndex];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80, child: Image.asset(stretch["asset"]!)),

                Text(
                  stretch["title"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(stretch["description"]!, textAlign: TextAlign.center),

                ElevatedButton(
                  onPressed: () {
                    if (currentIndex < stretches.length - 1) {
                      setState(() {
                        currentIndex++;
                      });
                    } else {
                      ref
                          .read(postureProvider.notifier)
                          .completeStretchSession();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DashboardScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  child: Text(
                    currentIndex == stretches.length - 1 ? "Finish" : "Next",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
