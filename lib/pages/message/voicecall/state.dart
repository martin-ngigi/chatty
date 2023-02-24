import 'package:get/get.dart';

//for shared data to be accessed in other
class VoiceCallState{
  RxBool isJoined = false.obs; //know whether the other party has oines
   RxBool openMicrophone = true.obs;
   RxBool enableSpeaker = true.obs;
   RxString callTime = "00.00".obs;
   RxString callStatus = "not connected".obs;

   var to_token = "".obs;
   var to_name = "".obs;
   var to_avatar = "".obs;
   var doc_id = "".obs;
   var call_role = "audience".obs;

}