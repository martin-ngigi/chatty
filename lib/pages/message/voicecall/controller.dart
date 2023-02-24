import 'package:chatty/common/routes/routes.dart';
import 'package:chatty/pages/message/voicecall/state.dart';
import 'package:get/get.dart';

class VoiceCallController extends GetxController{
  VoiceCallController();

  final state = VoiceCallState(); //get the variable

   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //get data from chat controller
    var data = Get.parameters;
    state.to_name.value = data["to_name"]??""; //if empty, place ""
    state.to_avatar.value = data["to_avatar"]??""; //if empty, place ""

  }
}