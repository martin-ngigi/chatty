import 'package:chatty/common/entities/entities.dart';

import '../utils/http.dart';

class UserAPI{
  static Future<UserLoginResponseEntity> Login({
    LoginRequestEntity? params
  }) async {
       var response = await HttpUtil().post(
         'api/login',
         queryParameters: params?.toJson()
       );
      return UserLoginResponseEntity.fromJson(response);
    }

  static Future<UserLoginResponseEntity> get_profile() async {
    var response = await HttpUtil().post(
        'api/get_profile'
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  static Future<UserLoginResponseEntity> update_profile({ //BaseResponseEntity
    LoginRequestEntity? params
  }) async {
    var response = await HttpUtil().post(
        'api/update_profile',
        queryParameters: params?.toJson()
    );
    return UserLoginResponseEntity.fromJson(response);
  }
}