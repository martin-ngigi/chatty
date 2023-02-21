import 'package:get/get.dart';

import 'controller.dart';
class MessageBinding implements Bindings{
  @override
  void dependencies() {
    //dependencies injection
    Get.lazyPut<MessageController>(() => MessageController());
  }

}