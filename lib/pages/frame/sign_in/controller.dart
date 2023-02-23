import 'dart:developer';

import 'package:chatty/common/routes/names.dart';
import 'package:chatty/common/store/store.dart';
import 'package:chatty/common/utils/http.dart';
import 'package:chatty/pages/frame/sign_in/state.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';

import '../../../common/entities/user.dart';

class SignInController extends GetxController{
  SignInController();
  final state = SignInState(); //get the variable

  /**
   * 'openid' enables one to login into many websites and android apps using the same password.
   */
   final GoogleSignIn _googleSignIn = GoogleSignIn(
     scopes: [
       'openid'
     ]
   );

  Future<void> handleSignIng(String type) async {
    //1. email  2. google 3. facebook 4. apple 5. phone
    try{
      if(type == "phone number"){
        print("You are login with phone number...");
      }
      else if(type == "google"){
        //print("login not sure...");
        var user = await _googleSignIn.signIn();
        if(user != null){
          String? displayName = user.displayName; // ? means displayName can be null
          String email = user.email;
          String id = user.id;
          String photoUrl = user.photoUrl??"assets/icons/google.png"; // means if user has photoUrl, use it, else set photoUrl="google.png"

          //create object
          LoginRequestEntity loginPanelListRequestEntity = LoginRequestEntity();
          loginPanelListRequestEntity.avatar = photoUrl;
          loginPanelListRequestEntity.name = displayName;
          loginPanelListRequestEntity.email = email;
          loginPanelListRequestEntity.open_id = id;
          loginPanelListRequestEntity.type = 2; // 2 is google
          asyncPostAllData();

          //print
          print("SUCCESS... LOGIN SUCCESS.... \n Email : $email \n Display Name: $displayName");
          log("SUCCESS... LOGIN SUCCESS....\n Email : $email \n Display Name: $displayName" );
        }
      }
    }
    catch(e){
      if(kDebugMode){
        print("ERROR... Error with login: $e");
        log("ERROR... Error with login: $e");
      }
    }
  }

  asyncPostAllData() async{
    print("Lets go to message page");
    var response = await HttpUtil().get(
        '/api/index'
    );

    //or

    // var response;
    // var dio = Dio();
    // response = await dio.get('https://a9ac-105-163-156-253.in.ngrok.io/api/index');
    // print(response.data.toString());

    print(response);
    UserStore.to.setIsLogin=true;
    Get.offAllNamed(AppRoutes.Message);
  }
}