import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasebasic/src/controller/profile_controller.dart';
import 'package:firebasebasic/src/login_page.dart';
import 'package:flutter/material.dart';
import 'main_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance
          .authStateChanges(), //firebase 상태가 바뀌었는지 아닌지 체크하는 stream.
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        ProfileController.to.authStateChanges(snapshot.data);
        if (!snapshot.hasData) {
          return LoginPage(); //data가 없으면 로그인으로
        } else {
          return MainPage(); // data가 있으면 MainPage로
        }
      },
    );
  }
}
