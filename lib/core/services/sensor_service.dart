class SensorReading {
  final double pitch;
  final double roll;

  const SensorReading({
    required this.pitch,
    required this.roll,
  });
}

class SensorService {
  Stream<SensorReading> sensorStream() async* {
    while (true) {
      await Future.delayed(
        const Duration(seconds: 2),
      );

      yield const SensorReading(
        pitch: 15,
        roll: 5,
      );
    }
  }
}