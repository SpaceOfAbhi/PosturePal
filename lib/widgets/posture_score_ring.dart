import 'package:flutter/material.dart';

class PostureScoreRing extends StatelessWidget {
  final double score;

  const PostureScoreRing({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 70,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: score / 100,
            strokeWidth: 12,
          ),
          Text(
            "${score.toInt()}%",
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}