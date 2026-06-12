import '../services/sensor_service.dart';

class PostureRepository {
  final SensorService sensorService;

  PostureRepository(this.sensorService);

  Stream<SensorReading> watchPosture() {
    return sensorService.sensorStream();
  }
}