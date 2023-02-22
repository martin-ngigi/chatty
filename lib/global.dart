import 'package:chatty/common/services/services.dart';
import 'package:chatty/common/store/store.dart';
import 'package:chatty/firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

import 'common/utils/constants.dart';

class Global{
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    //condition to check the where the plaltform the app is running in i.e. android, web, iOS
    if(kIsWeb){
      //run initialization for web
      await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: Constants.apiKey,
      appId: Constants.appId,
      messagingSenderId: Constants.messagingSenderId,
      projectId: Constants.projectId
      ));
    }
    else{
      //run initialization for iOS and android
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
      );
    }


    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<UserStore>(UserStore());
  }
}