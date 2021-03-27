import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sns_login/src/pages/home.dart';
import 'package:flutter/material.dart';

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
          return Home();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
