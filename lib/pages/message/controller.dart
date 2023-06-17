import 'package:chatty/common/apis/chat.dart';
import 'package:chatty/common/entities/base.dart';
import 'package:chatty/common/routes/routes.dart';
import 'package:chatty/pages/frame/welcome/state.dart';
import 'package:chatty/pages/message/state.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessageController extends GetxController{
  MessageController();
  final state = MessageState(); //get the variable

  void goProfile() async{
    await Get.toNamed(AppRoutes.Profile);
  }

  void goContact() async{
    await Get.toNamed(AppRoutes.Contact);
  }

  @override
  void onReady() {
    super.onReady();
    firebaseMessagingSetUp();
  }

  firebaseMessagingSetUp() async {
    /// get device token.
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    print("----------[MessageController] My device token is, FCM token ${fcmToken}");
    if(fcmToken != null){
      BindFcmTokenRequestEntity bindFcmTokenRequestEntity = BindFcmTokenRequestEntity();
      bindFcmTokenRequestEntity.fcmtoken = fcmToken;
      print("----> [bindFcmTokenRequestEntity] ${bindFcmTokenRequestEntity.fcmtoken}");
      await ChatAPI.bind_fcmtoken(params: bindFcmTokenRequestEntity);
    }
  }

}