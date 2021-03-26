import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:firebasebasic/appstate_model.dart';
import 'package:firebasebasic/crud.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final firebaseAuth.FirebaseAuth _auth = firebaseAuth.FirebaseAuth.instance;

  //초기 앱의 상태를 정의함. signin 과정 중에서 loading = true로 바꿔줘야함.
  final app = AppState(loading: false, user: null);

  Future<String> signInWithGoogle() async {
    setState(() {
      app.loading = true;
    });

    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final firebaseAuth.GoogleAuthCredential credential =
        firebaseAuth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final firebaseAuth.UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final firebaseAuth.User user = authResult.user;

    setState(() {
      app.loading = false;
      app.user = user;
    });

    // Once signed in, return the UserCredential
    return 'success';
  }

  Widget _loginPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('id'),
            Text('passward'),
            RaisedButton(
              child: Text('login'),
              onPressed: () {
                signInWithGoogle();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (app.user == null) {
      return _loginPage();
    } else {
      return CrudPage();
    }
  }
}
