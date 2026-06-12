import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posture_pal/core/models/posture_state.dart';
import 'package:posture_pal/core/providers/posture_provider.dart';
import 'package:posture_pal/features/insights/insights_screen.dart';
import 'package:posture_pal/widgets/posture_score_ring.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posture = ref.watch(postureProvider);

    Color statusColor(PostureStatus status) {
      switch (status) {
        case PostureStatus.good:
          return Colors.green;

        case PostureStatus.warning:
          return Colors.orange;

        case PostureStatus.bad:
          return Colors.red;
      }
    }

    String statusText(PostureStatus status) {
      switch (status) {
        case PostureStatus.good:
          return "Good Posture";

        case PostureStatus.warning:
          return "Warning";

        case PostureStatus.bad:
          return "Slouching";
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  const Text(
                    "PosturePal",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),

                  PostureScoreRing(score: posture.score.toDouble()),

                  Text(
                    statusText(posture.status),
                    style: TextStyle(color: statusColor(posture.status), fontSize: 10),
                  ),

                  const Text(
                    "Sitting Time",
                    style: TextStyle(color: Colors.grey),
                  ),

                  Text(
                    "${posture.sittingMinutes} mins",
                    style: TextStyle(fontSize: 10),
                  ),

                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Column(
                        children: [
                          Text(
                            "Today's Corrections",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${posture.corrections}",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const InsightsScreen(),
                            ),
                          );
                        },
                        child: const Text('Insights'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Settings'),
                      ),
                    ],
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
