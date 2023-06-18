import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/routes/names.dart';
import 'package:chatty/common/store/store.dart';
import 'package:chatty/common/widgets/toast.dart';
import 'package:chatty/pages/message/chat/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController extends GetxController{
  ChatController();
  final state = ChatState(); //get the variable
  late String doc_id;
  TextEditingController myInputController = TextEditingController();
  /// get the user or senders token.
  final token = UserStore.to.profile.token;
  /// firebase data instance
  final db = FirebaseFirestore.instance;
  var listener;

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
        /// "to" is the receiver
        parameters: {
          "to_token": state.to_token.value,
          "to_name": state.to_name.value,
          "to_avatar": state.to_avatar.value,
          "call_role": "anchor", /// Host... i.e. The one initiating the call
          "doc_id":doc_id
    }
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    print("-----------> [ChatController] onInit()");
    super.onInit();
    var data = Get.parameters;
    print(data);
    doc_id = data['doc_id']!;
    state.to_token.value = data['to_token']??"";
    state.to_name.value = data['to_name']??"";
    state.to_avatar.value = data['to_avatar']??"";
    state.to_online.value = data['to_online']??"1";

  }

  @override
  void onReady() {
    // TODO: implement onReady
    print("-----------> [ChatController] onReady()");
    super.onReady();

    state.msgcontentList.clear(); /// clear so that we get the fresh data
    final messages = db.collection("message")
                        .doc(doc_id)
                        .collection("msglist")
                        .withConverter(
                            fromFirestore: Msgcontent.fromFirestore,
                            toFirestore: (Msgcontent msg, options) => msg.toFirestore())
                        .orderBy("addtime", descending: true)
                        .limit(15); /// first get the latest 15 messages

    listener = messages.snapshots() /// snapshots enables to listen live messages. while .get() doesn't listen
        .listen((event) {

                  List<Msgcontent> tempMsgList = <Msgcontent>[];
                  for(var change in event.docChanges){
                    switch(change.type){

                      case DocumentChangeType.added:
                        // TODO: Handle this case.
                          if(change.doc.data() != null){
                            tempMsgList.add(change.doc.data()!);
                            print("-----------> [ChatController] DocumentChangeType.added ${myInputController.text}");
                          }
                        break;
                      case DocumentChangeType.modified:
                        // TODO: Handle this case.
                        break;
                      case DocumentChangeType.removed:
                        // TODO: Handle this case.
                        break;
                    }

                    /// reverse the messages.
                    /// Initially it was reversed i.e. in "addtime", descending: true. so it became 4,3,2,1
                    /// Now we reverse again. So that it will be arrange in an ordered list. We will have 1,2,3,
                    tempMsgList.reversed.forEach((element) {
                      state.msgcontentList.value.insert(0, element);
                    });

                    state.msgcontentList.refresh();

                  }
    });
  }

  Future<void> sendMessage() async {
    var list =  await db.collection("message")
        .doc(doc_id)
        .collection("msglist")
        .get();

    String sendContent = myInputController.text;
    print("-------->[MessageController] Message to be sent: $sendContent");

    /// empty message
    if(sendContent.isEmpty){
      toastInfo(msg: "Content is empty");
      return;
    }

    /// Message object to send to firebase.
    final content = Msgcontent(
      token: token,/// sender token
      content: sendContent,
      type: "text",
      addtime: Timestamp.now()
    );

    ///CREATE: save data to firestore
    await db.collection("message").doc(doc_id).collection("msglist")
    .withConverter(
        fromFirestore: Msgcontent.fromFirestore, /// same as fromJson
        toFirestore: (Msgcontent msg, options) => msg.toFirestore()
    ).add(content).then((DocumentReference doc){
      //print("------------> [MessageController] Base id is ${doc_id} New Message doc id is ${doc.id}");
      myInputController.clear(); // clear UI
    });


    /// Above can be simplified. i.e.
    /**
    await db.collection("message").doc(doc_id).collection("msglist")
    .add({
      "token": token,
      "content": sendContent,
      "type": "text",
      "addtime": Timestamp.now()
    }).then((DocumentReference doc){
      //print("------------> [MessageController] Base id is ${doc_id} New Message doc id is ${doc.id}");
      myInputController.clear(); // clear UI
    });
    **/

    /// UPDATE - Update last message
    var messageResult = await db.collection("message").doc(doc_id)
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore()
    ).get();

    /// to know if we have any unread messages or calls.
    if(messageResult.data() != null){
      var item = messageResult.data()!;
      int to_msg_num_long = item.to_msg_num == null ? 0: item.to_msg_num!;  /// if empty, use 0 instead
      int to_msg_num = item.to_msg_num ?? 0; /// if null, use 0 instead
      int from_msg_num = item.from_msg_num ?? 0; /// if null, use 0 instead

      /// if the tokens matches. Means its me
      if(item.from_token == token){
        from_msg_num = from_msg_num + 1;
      }
      else{
        to_msg_num = to_msg_num + 1;
      }

      /// update db
      await db.collection("message")
          .doc(doc_id)
          .update({
            "to_msg_num": to_msg_num,
            "from_msg_num": from_msg_num,
            "last_msg": sendContent,
            "last_time": Timestamp.now()
          });

    }




  }

  /// release all resources.
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    listener.cancel();
    myInputController.dispose();
  }
}