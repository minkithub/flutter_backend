import 'package:firebase_sns_login/controller/app_controller.dart';
import 'package:get/instance_manager.dart';

// controller를 등록하는 과정
class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
  }
}
