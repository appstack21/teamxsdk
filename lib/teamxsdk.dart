import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Teamxsdk {
  static const MethodChannel _channel = MethodChannel('teamxsdk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Widget pCard() {
    return Container(
      height: 200,
      color: Colors.amber,
    );
  }
}
