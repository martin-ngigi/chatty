import 'package:chatty/common/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

import 'common/utils/constants.dart';
import 'global.dart';

Future<void> main() async {
  await Global.init();

  //Firebase Initialization
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
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        designSize: Size(360, 780),
        builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
    ));
  }
}
