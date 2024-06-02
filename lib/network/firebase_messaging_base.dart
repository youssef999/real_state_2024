import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:realstate/features/root/controller/root_controller.dart';
import 'package:realstate/models/user_model.dart';

class FireBaseMessagingService extends GetxService {
  Future<FireBaseMessagingService> init() async {
    FirebaseMessaging.instance
        .requestPermission(sound: true, badge: true, alert: true);
    await fcmOnLaunchListeners();
    await fcmOnResumeListeners();
    await setDeviceToken();
    return this;
  }



  Future fcmOnLaunchListeners() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      _notificationsBackground(message);
    }
  }

  Future fcmOnResumeListeners() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _notificationsBackground(message);
    });
  }

  void _notificationsBackground(RemoteMessage message) {
    if (message.data['id'] == "App\\Notifications\\NewMessage") {
      _newMessageNotificationBackground(message);
    } else {
      _newBookingNotificationBackground(message);
    }
  }

  void _newBookingNotificationBackground(message) {
    if (Get.isRegistered<RootController>()) {

    }
  }

  void _newMessageNotificationBackground(RemoteMessage message) {
    if (message.data['messageId'] != null) {
     
    }
  }

  Future<void> setDeviceToken() async {
    Get.lazyPut(()=>Users());
    Get.find<Users>().deviceToken =
        (await FirebaseMessaging.instance.getToken())!;
  }


  
}
