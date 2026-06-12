enum PostureStatus {
  good,
  warning,
  bad,
}

class PostureData {
  final int score;
  final PostureStatus status;

  PostureData({
    required this.score,
    required this.status,
  });
}