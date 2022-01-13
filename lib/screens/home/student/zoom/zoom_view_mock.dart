import 'dart:async';
import 'package:flutter/services.dart';
import "package:easyclass/screens/home/student/zoom/zoom_options.dart";
import "package:easyclass/screens/home/student/zoom/zoom_platform_view.dart";
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:mockito/mockito.dart';

class ZoomView extends Mock with MockPlatformInterfaceMixin implements ZoomPlatform {
  print("HI");
}
