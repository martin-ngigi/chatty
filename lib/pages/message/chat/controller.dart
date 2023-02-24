import 'package:chatty/common/routes/names.dart';
import 'package:chatty/pages/message/chat/state.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{
  ChatController();
  final state = ChatState(); //get the variable
  late String doc_id;

  void goMore(){
    //toggle, i.e. if false, set true and if true, set false
    state.more_status.value = state.more_status.value?false:true;
  }

  void audioCall(){
    //change pop up menu
    state.more_status.value=false;
    //navigate to Voice call page
    Get.toNamed(AppRoutes.VoiceCall,
        //pass data to video call page
        parameters: {
          "to_name": state.to_name.value,
          "to_avatar": state.to_avatar.value,
        }
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    print(data);
    doc_id = data['doc_id']!;
    state.to_token.value = data['to_token']??"";
    state.to_name.value = data['to_name']??"";
    state.to_avatar.value = data['to_avatar']??"";
    state.to_online.value = data['to_online']??"1";

  }
}