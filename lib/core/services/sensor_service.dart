import 'dart:async';

import '../models/posture_data.dart';

class SensorService {
  Stream<PostureData> postureStream() async* {
    while (true) {
      await Future.delayed(
        const Duration(seconds: 3),
      );

      yield PostureData(
        score: 80,
        status: PostureStatus.good,
      );
    }
  }
}