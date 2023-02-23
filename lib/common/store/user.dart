import 'dart:convert';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/routes/names.dart';
import 'package:chatty/common/services/services.dart';
import 'package:chatty/common/values/values.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // if logged in or not
  final _isLogin = false.obs;
  // login  token
  String token = '';
  //user  profile
  //final _profile = UserLoginResponseEntity().obs;
  final _profile = UserItem().obs;

  bool get isLogin => _isLogin.value;
  //UserLoginResponseEntity get profile => _profile.value;
  UserItem get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;
  set setIsLogin(login)=>_isLogin.value=login;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _isLogin.value = true;
      //_profile(UserLoginResponseEntity.fromJson(jsonDecode(profileOffline)));
      _profile(UserItem.fromJson(jsonDecode(profileOffline)));
    }
  }

  // saving token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  // get profile
  Future<String> getProfile() async {
    if (token.isEmpty) return "";
    // var result = await UserAPI.profile();
    // _profile(result);
    // _isLogin.value = true;
   return StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
  }

  // saving profile
  //Future<void> saveProfile(UserLoginResponseEntity profile) async {
  Future<void> saveProfile(UserItem profile) async {
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    //setToken(profile.accessToken!);
    _profile(profile);
    setToken(profile.access_token!);
  }

  // during logout
  Future<void> onLogout() async {
   // if (_isLogin.value) await UserAPI.logout();
    /*await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageService.to.remove(STORAGE_USER_PROFILE_KEY);
    _isLogin.value = false;
    token = '';*/
    Get.offAllNamed(AppRoutes.SIGN_IN);
  }
}
