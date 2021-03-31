import 'package:firebase_core/firebase_core.dart';
import 'package:firebasebasic/src/home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text('Firebase load fail'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Home();
        } else {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
