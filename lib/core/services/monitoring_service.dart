import 'package:flutter/services.dart';

class MonitoringService {
  static const EventChannel _channel =
      EventChannel('posture_pal/monitoring');

  static Stream<dynamic> get stream =>
      _channel.receiveBroadcastStream();
}