import 'package:get/get.dart';

import 'controller.dart';
class ChatBinding implements Bindings{
  @override
  void dependencies() {
    //dependencies injection
    Get.lazyPut<ChatController>(() => ChatController());

  }

}