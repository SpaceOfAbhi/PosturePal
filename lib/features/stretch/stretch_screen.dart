import 'package:flutter/material.dart';

class StretchScreen extends StatefulWidget {
  const StretchScreen({super.key});

  @override
  State<StretchScreen> createState() => _StretchScreenState();
}

class _StretchScreenState extends State<StretchScreen> {
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
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    currentIndex == stretches.length - 1 ? "Finish" : "Next",
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
