import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/profile_controller.dart';
import 'repository/firebase_user_repository.dart';

class MainPage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Main Page'),
          backgroundColor: Colors.black,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                onTap: () {
                  print('signOut');
                  FirebaseUserRepository.signOut();
                },
              ),
            )
          ],
        ),
        body: Obx(
          () => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('name : ${controller.myProfile.value.name}'),
                Text('uid : ${controller.myProfile.value.uid}'),
                Text('docId : ${controller.myProfile.value.docId}'),
                Text('createdTime : ${controller.myProfile.value.createdTime}'),
                Text(
                    'lastLoginTime : ${controller.myProfile.value.lastLoginTime}'),
              ],
            ),
          ),
        ));
  }
}
