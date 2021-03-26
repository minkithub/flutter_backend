import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kakao_sample_profile/src/controller/profile_controller.dart';
import 'package:kakao_sample_profile/src/pages/profile.dart';
import 'login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          ProfileController.to
              .authStateChanges(snapshot.data); //firebase cloud에 데이터를 보내는 과정
          if (!snapshot.hasData) {
            return LoginWidget(); //유저정보가 없으면 로그인 화면으로
          } else {
            return Profile(); //유저정보가 있으면 바로 프로필 화면으로
          }
        });
  }
}
