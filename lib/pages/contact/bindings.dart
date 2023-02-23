import 'package:get/get.dart';

import 'controller.dart';
class ContactBinding implements Bindings{
  @override
  void dependencies() {
    //dependencies injection
    Get.lazyPut<ContactController>(() => ContactController());

  }

}