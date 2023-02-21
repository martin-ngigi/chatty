import 'package:chatty/pages/frame/welcome/state.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController{
  WelcomeController();
  final title = "Chatty";
  final state = WelcomeState(); //get the variable

  //for navigation and transitions in pages
  @override
  void onReady() {
    super.onReady();
    print("Welcome controller.");
  }
}