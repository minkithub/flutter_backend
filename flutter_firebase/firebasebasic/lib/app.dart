import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'homewidget.dart';

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
          return HomeWidget();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
