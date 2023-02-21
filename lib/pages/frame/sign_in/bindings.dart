import 'package:get/get.dart';

import 'controller.dart';
class SignInBinding implements Bindings{
  @override
  void dependencies() {
    //dependencies injection
    Get.lazyPut<SignInController>(() => SignInController());
  }

}