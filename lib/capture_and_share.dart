import 'dart:async';

import 'package:flutter/services.dart';

class CaptureAndShare {
  static const MethodChannel _channel =
      const MethodChannel('capture_and_share');

  static Future<Null> shareIt({
    double sizeWidth = 0,
    double sizeHeight = 0,
    String xMode = 'center',
    String yMode = 'center',
  }) async {
    Map<String, dynamic> args = <String, dynamic>{
      'sizeWidth': sizeWidth,
      'sizeHeight': sizeHeight,
      'xMode': xMode,
      'yMode': yMode,
    };

    await _channel.invokeMethod('shareIt', args);
    return null;
  }
}
