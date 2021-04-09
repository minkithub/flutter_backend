import 'package:firebase_sns_login/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class App extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            selectedItemColor: Colors.black,
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.changePageIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/icons/home_off.svg'),
                  activeIcon: SvgPicture.asset('assets/svg/icons/home_on.svg'),
                  label: '홈'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/icons/compass_off.svg',
                    width: 22,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/icons/compass_on.svg',
                    width: 22,
                  ),
                  label: '탐색'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/icons/plus.svg',
                    width: 35,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/icons/subs_off.svg'),
                  activeIcon: SvgPicture.asset('assets/svg/icons/subs_on.svg'),
                  label: '구독'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/icons/library_off.svg'),
                  activeIcon:
                      SvgPicture.asset('assets/svg/icons/library_on.svg'),
                  label: '보관함'),
            ],
          ),
        ));
  }
}
