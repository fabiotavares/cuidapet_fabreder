import 'dart:io';

import 'package:cuidapet_fabreder/app/repository/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushMessageConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<void> configure() async {
    if (Platform.isIOS) {
      // necessário apenas no ios
      await _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    // registrando o device id na shared prefs...
    String deviceId = await _fcm.getToken();
    final prefs = await SharedPrefsRepository.instance;
    prefs.registerDeviceId(deviceId);
  }
}
