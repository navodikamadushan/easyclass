import 'package:platform_device_id/platform_device_id.dart';

class DeviceInfoService {
  Future getDeviceId() async {
    try {
      String deviceId = await PlatformDeviceId.getDeviceId;
      return deviceId;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
