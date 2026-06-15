import 'package:flutter/services.dart';

class ServiceController {
  static const platform = MethodChannel('posture_pal/service');

  static Future<void> start() async {
    await platform.invokeMethod('startService');
  }

  static Future<void> stop() async {
    await platform.invokeMethod('stopService');
  }

  static Future<bool> openStretch() async {
    return await platform.invokeMethod('openStretch') ?? false;
  }

  static Future<bool> serviceStatus() async {
  return await platform.invokeMethod(
        'serviceStatus',
      ) ??
      false;
}
}
