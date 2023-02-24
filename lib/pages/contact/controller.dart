import 'package:chatty/common/entities/contact.dart';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/store/store.dart';
import 'package:chatty/pages/contact/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../common/apis/contact.dart';

class ContactController extends GetxController{
  ContactController();
  final title = "Chatty";
  final state = ContactState(); //get the variable
  final token = UserStore.to.profile.token; //users token
  final db = FirebaseFirestore.instance;


   @override
  void onReady(){
    // TODO: implement onReady
    super.onReady();

    asyncLoadAllData();
  }

  Future<void> goChat(ContactItem contactItem) async {
    /**
     * from_messages ---
     * from_token is the sender's token i.e. current user
     * to_token is the receiver's token of the message
     * withConverter converts json data to an object
     * toFirestore converts object to json data
     * from_messages is the person who starts the chats. I.e. app user
     *
     * to_messages ----
     * to_messages is the receiver
     *
     */
    var from_messages = await db.collection("message").withConverter(
         fromFirestore: Msg.fromFirestore,
         toFirestore: (Msg msg, options)=>msg.toFirestore(),
     ).where("from_token", isEqualTo: token).where("to_token", isEqualTo: contactItem.token)
     .get();

    var to_messages = await db.collection("message").withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg, options)=>msg.toFirestore(),
    ).where("from_token", isEqualTo: contactItem.token).where("to_token", isEqualTo: token)
        .get();


    //checks
    if(from_messages.docs.isEmpty && to_messages.docs.isEmpty){
      var profile = UserStore.to.profile;
      var msgdata = Msg(
        from_token: profile.token,
        to_token: contactItem.token,
        from_name: profile.name,
        to_name: contactItem.name,
        from_avatar: profile.avatar,
        to_avatar: contactItem.avatar,

        from_online: profile.online,
        to_online: contactItem.online,

        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );

      //generate document id and save message data
      var doc_id = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options)=>msg.toFirestore(),
      ).add(msgdata);

      //navigate to chat page so as to start chatting
      //offAllNamed <- the back button is disabled
      Get.offAllNamed("/chat",
        //pass data to chat page
        parameters: {
        "doc_id": doc_id.id,
          "to_token": contactItem.token??"", //if empty, pass "",
          "to_name": contactItem.name??"",
          "to_avatar": contactItem.avatar??"",
          "to_online": contactItem.online.toString(),
        }
      );
      print("...creating new  document user infor done....");
    }
    else{
      print(".... this is an older user ...");

      if(from_messages.docs.first.id.isNotEmpty){
        //navigate to chat page so as to start chatting
        //toNamed <- the back button is enabled
        Get.toNamed("/chat",
            //pass data to chat page
            parameters: {
              "doc_id": from_messages.docs.first.id,
              "to_token": contactItem.token??"", //if empty, pass "",
              "to_name": contactItem.name??"",
              "to_avatar": contactItem.avatar??"",
              "to_online": contactItem.online.toString(),
            }
        );
      }

      if(to_messages.docs.first.id.isNotEmpty){
        //navigate to chat page so as to start chatting
        //toNamed <- the back button is enabled
        Get.toNamed("/chat",
            //pass data to chat page
            parameters: {
              "doc_id": to_messages.docs.first.id,
              "to_token": contactItem.token??"", //if empty, pass "",
              "to_name": contactItem.name??"",
              "to_avatar": contactItem.avatar??"",
              "to_online": contactItem.online.toString(),
            }
        );
      }

    }
  }

    asyncLoadAllData() async {
     EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
      );
      state.contactList.clear();
      var result  = await ContactAPI.post_contact();

      if (kDebugMode) {
        print("CONTACT RESULT DATA : ${result.data!}");
      }
      if(result.code==0){//success
        state.contactList.addAll(result.data!);
      }
      EasyLoading.dismiss();
  }
}