import 'package:chatty/common/routes/routes.dart';
import 'package:chatty/pages/frame/welcome/state.dart';
import 'package:chatty/pages/message/state.dart';
import 'package:get/get.dart';

class MessageController extends GetxController{
  MessageController();
  final state = MessageState(); //get the variable

  void goProfile() async{
    await Get.toNamed(AppRoutes.Profile);
  }

  void goContact() async{
    await Get.toNamed(AppRoutes.Contact);
  }

}