import 'package:chatty/common/routes/routes.dart';
import 'package:chatty/pages/frame/welcome/state.dart';
import 'package:chatty/pages/profile/state.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  ProfileController();
  final title = "Chatty";
  final state = ProfileState(); //get the variable

  //for navigation and transitions in pages
  @override
  void onReady() {
    super.onReady();
    Future.delayed(
        const Duration(seconds: 3), ()=> Get.offAllNamed(AppRoutes.Message)
    );
  }
}