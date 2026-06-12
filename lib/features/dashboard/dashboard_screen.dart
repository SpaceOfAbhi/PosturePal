import 'package:flutter/material.dart';
import 'package:posture_pal/widgets/posture_score_ring.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "PosturePal",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),

                const PostureScoreRing(score: 82),


                const Text(
                  "Good Posture",
                  style: TextStyle(color: Colors.green, fontSize: 10),
                ),


                const Text(
                  "Sitting Time",
                  style: TextStyle(color: Colors.grey),
                ),


                const Text("42 mins", style: TextStyle(fontSize: 10)),


                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Start Focus"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
