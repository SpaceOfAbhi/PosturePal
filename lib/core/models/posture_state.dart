enum PostureStatus {
  good,
  warning,
  bad,
}

class PostureState {
  final int score;
  final int corrections;
  final int sittingMinutes;
  final PostureStatus status;

  const PostureState({
    required this.score,
    required this.corrections,
    required this.sittingMinutes,
    required this.status,
  });

  PostureState copyWith({
    int? score,
    int? corrections,
    int? sittingMinutes,
    PostureStatus? status,
  }) {
    return PostureState(
      score: score ?? this.score,
      corrections: corrections ?? this.corrections,
      sittingMinutes:
          sittingMinutes ?? this.sittingMinutes,
      status: status ?? this.status,
    );
  }
}