import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/legacy.dart';

import '../models/posture_state.dart';

class PostureNotifier
    extends StateNotifier<PostureState> {

  PostureNotifier()
      : super(
          const PostureState(
            score: 82,
            corrections: 0,
            sittingMinutes: 0,
            status: PostureStatus.good,
          ),
        ) {
    startMonitoring();
  }

  final random = Random();

  void startMonitoring() {

    Timer.periodic(
      const Duration(seconds: 5),
      (_) {

        final score =
            60 + random.nextInt(41);

        PostureStatus status;

        if (score >= 80) {
          status = PostureStatus.good;
        } else if (score >= 65) {
          status = PostureStatus.warning;
        } else {
          status = PostureStatus.bad;
        }

        state = state.copyWith(
          score: score,
          status: status,
          sittingMinutes:
              state.sittingMinutes + 1,
          corrections:
              status ==
                      PostureStatus.bad
                  ? state.corrections + 1
                  : state.corrections,
        );
      },
    );
  }
}

final postureProvider =
    StateNotifierProvider<
        PostureNotifier,
        PostureState>(
  (ref) => PostureNotifier(),
);