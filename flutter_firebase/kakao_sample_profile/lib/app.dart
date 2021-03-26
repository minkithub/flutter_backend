import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakao_sample_profile/src/pages/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Firebase load fail'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Home(); //Home에서 로그인처리
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
