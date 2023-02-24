import 'package:chatty/pages/frame/welcome/controller.dart';
import 'package:get/get.dart';

import 'controller.dart';
class VoiceCallBinding implements Bindings{
  @override
  void dependencies() {
    //dependencies injection
    Get.lazyPut<VoiceCallController>(() => VoiceCallController());

  }

}