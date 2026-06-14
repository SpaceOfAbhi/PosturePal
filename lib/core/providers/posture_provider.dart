import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posture_pal/core/models/posture_state.dart';
import 'package:posture_pal/core/services/movement_services.dart';

class PostureNotifier extends Notifier<PostureState> {
  final movementService = MovementService();
  bool reminderShown = false;
  void completeStretchSession() {
    state = state.copyWith(stretchesCompleted: state.stretchesCompleted + 1);
  }

  @override
  PostureState build() {
    state = const PostureState(
      healthScore: 100,
      stationaryMinutes: 0,
      remindersToday: 0,
      stretchesCompleted: 0,
      status: MonitoringStatus.active,
      activities: [],
      isMoving: false,
    );

    Timer.periodic(const Duration(seconds: 1), (_) {
      final inactiveSeconds = movementService.inactivityDuration.inSeconds;

      if (inactiveSeconds < 2) {
        reminderShown = false;
      }

      if (inactiveSeconds >= 10 && !reminderShown) {
        reminderShown = true;

        state = state.copyWith(remindersToday: state.remindersToday + 1);
      }

      state = state.copyWith(
        stationaryMinutes: inactiveSeconds,
        isMoving: inactiveSeconds < 2,
      );
    });
    return state;
  }
}

final postureProvider = NotifierProvider<PostureNotifier, PostureState>(
  PostureNotifier.new,
);
