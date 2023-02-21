import 'package:chatty/common/store/config.dart';
import 'package:chatty/pages/frame/welcome/controller.dart';
import 'package:get/get.dart';
class WelcomeBinding implements Bindings{
  @override
  void dependencies() {
    //dependencies injection
    Get.lazyPut<WelcomeController>(() => WelcomeController());

  }

}