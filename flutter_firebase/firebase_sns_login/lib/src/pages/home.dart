import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/material.dart';

import 'loginPage.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: firebaseAuth.FirebaseAuth.instance
            .authStateChanges(), //firebase login이 됐는지 안됐는지 판별하기 위함.
        builder:
            (BuildContext context, AsyncSnapshot<firebaseAuth.User> snapshot) {
          if (!snapshot.hasData) {
            return LoginWidget();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${snapshot.data.displayName} 환영합니다.'),
                  FlatButton(
                    color: Colors.black,
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      firebaseAuth.FirebaseAuth.instance.signOut();
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
