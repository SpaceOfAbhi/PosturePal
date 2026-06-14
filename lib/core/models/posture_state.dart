import 'package:posture_pal/core/models/activity_event.dart';

enum MonitoringStatus { active, paused }

class PostureState {
  final int healthScore;

  final int stationaryMinutes;

  final int remindersToday;

  final int stretchesCompleted;

  final MonitoringStatus status;

  final List<ActivityEvent> activities;

  final bool isMoving;

  const PostureState({
    required this.healthScore,
    required this.stationaryMinutes,
    required this.remindersToday,
    required this.stretchesCompleted,
    required this.status,
    required this.activities,
    required this.isMoving,
  });

  PostureState copyWith({
    int? healthScore,
    int? stationaryMinutes,
    int? remindersToday,
    int? stretchesCompleted,
    MonitoringStatus? status,
    List<ActivityEvent>? activities,
    bool? isMoving,
  }) {
    return PostureState(
      healthScore: healthScore ?? this.healthScore,
      stationaryMinutes: stationaryMinutes ?? this.stationaryMinutes,
      remindersToday: remindersToday ?? this.remindersToday,
      stretchesCompleted: stretchesCompleted ?? this.stretchesCompleted,
      status: status ?? this.status,
      activities: activities ?? this.activities,
      isMoving: isMoving ?? this.isMoving,
    );
  }
}
