
import 'package:flutter/material.dart';
import 'package:chatty/common/middlewares/middlewares.dart';

import 'package:get/get.dart';

// import '../../pages/frame/welcome/bindings.dart';
// import '../../pages/frame/welcome/view.dart';

import '../../pages/frame/sign_in/bindings.dart';
import '../../pages/frame/sign_in/view.dart';
import '../../pages/frame/welcome/index.dart'; // this will import bindings.dart and view.dart
// import '../../pages/message/bindings.dart';
import '../../pages/message/index.dart';
import '../../pages/message/chat/index.dart';
import '../../pages/profile/bindings.dart';
import '../../pages/profile/index.dart';
import '../../pages/contact/index.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  //static const APPlication = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    //about boot up the page
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
      // middlewares: [
      //   RouteWelcomeMiddleware(priority: 1),
      // ],
    ),

    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),

    /*
    // check if needed to login or not
    GetPage(
      name: AppRoutes.Application,
      page: () => ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),

    */
    GetPage(name: AppRoutes.Contact, page: () => ContactPage(), binding: ContactBinding()),

    // Message
    GetPage(name: AppRoutes.Message, page: () => const MessagePage(), binding: MessageBinding(), middlewares: [
      RouteAuthMiddleware(priority: 1),
    ],),

    //profile
    GetPage(name: AppRoutes.Profile,
        page: () => const ProfilePage(),
        binding: ProfileBinding()),

    // chat page
    GetPage(name: AppRoutes.Chat, page: () => ChatPage(), binding: ChatBinding()),

    /*//我的
    GetPage(name: AppRoutes.Me, page: () => MePage(), binding: MeBinding()),

    GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),*/
  ];






}
