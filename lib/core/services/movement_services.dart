import 'package:sensors_plus/sensors_plus.dart';

class MovementService {
  DateTime lastMovementTime = DateTime.now();

  double? lastX;
  double? lastY;
  double? lastZ;

  MovementService() {
    accelerometerEventStream().listen((event) {

      if (
          lastX == null ||
          lastY == null ||
          lastZ == null) {

        lastX = event.x;
        lastY = event.y;
        lastZ = event.z;

        return;
      }

      final movement =
          (event.x - lastX!).abs() +
          (event.y - lastY!).abs() +
          (event.z - lastZ!).abs();

      lastX = event.x;
      lastY = event.y;
      lastZ = event.z;

      if (movement > 2.0) {
        lastMovementTime = DateTime.now();
      }
    });
  }

  Duration get inactivityDuration {
    return DateTime.now().difference(
      lastMovementTime,
    );
  }
}