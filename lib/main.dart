import 'package:chatty/common/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatty/firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'common/style/theme.dart';
import 'common/utils/constants.dart';
import 'common/utils/firebase_messaging_handler.dart';
import 'global.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  await Global.init();

  /**
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
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
      );
  }
      **/

  runApp(const MyApp());

  await firebaseChatInit()
      .whenComplete(() => FirebaseMessagingHandler.config());
}

Future firebaseChatInit() async{
  /// handle background tasks
  FirebaseMessaging.onBackgroundMessage(
      FirebaseMessagingHandler.firebaseMessagingBackground
  );
  if(GetPlatform.isAndroid){
    /// channel for  video/audio call
    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(FirebaseMessagingHandler.channel_call);

    /// channel for messages
    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(FirebaseMessagingHandler.channel_message);
  }
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
          theme: AppTheme.light,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
    ));
  }
}
