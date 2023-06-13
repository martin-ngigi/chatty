import 'package:get/get.dart';

// baidu yapi
// const SERVER_API_URL = 'https://yapi.baidu.com/mock/41008';

// const SERVER_API_URL = 'https://www.dbestech.com/';

import 'package:flutter/foundation.dart';

/// if android 10.0.2.2:8000/, else 127.0.0.1:8000/
// String SERVER_API_URL= GetPlatform.isAndroid ? "http://10.0.2.2:8000/" : "http://127.0.0.1:8000/";
String SERVER_API_URL = "http://192.168.1.198:8001/";

class MyServer{
  static late String? _SERVER_API_URL1="";
  static String? get SERVER_API_URL1 => _SERVER_API_URL1;
  String? deviceType(){
    if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
      // iOS-specific device

      /// ios simulator localhost url
      _SERVER_API_URL1="http://127.0.0.1:8000/";
    }
    else{
      /// android simulator  localhost url
      _SERVER_API_URL1="http://10.0.2.2:8000/";

    }
    return _SERVER_API_URL1;
  }

}

/**
 * Obtain it from https://console.agora.io/projects
 */
const APPID = '0bf7c4fdb6504384b986977396a34cb4';

// 本地搭建 yapi
// const SERVER_API_URL = 'http://yapi.ducafecat.tech/mock/11';
