import 'package:get/get.dart';

// BottomNavigation은 앱이 종료될때까지 계속 유지되어야 하므로 GetxService로 설정해줌.
class AppController extends GetxService {
  // AppController 안에 find를 to로 해주면 Get.find<AppController>()를 해줄필요가 없다.
  static AppController get to => Get.find();

  RxInt currentIndex = 0.obs;

  void changePageIndex(int index) {
    currentIndex(index);
  }
}
