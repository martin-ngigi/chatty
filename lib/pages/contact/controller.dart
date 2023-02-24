import 'package:chatty/pages/contact/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/foundation.dart';

import '../../common/apis/contact.dart';

class ContactController extends GetxController{
  ContactController();
  final title = "Chatty";
  final state = ContactState(); //get the variable

   @override
  void onReady(){
    // TODO: implement onReady
    super.onReady();

    asyncLoadAllData();
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