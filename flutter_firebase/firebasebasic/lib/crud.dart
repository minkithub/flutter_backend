import 'package:firebasebasic/appstate_model.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CrudPage extends StatefulWidget {
  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  final app = AppState();

  void _signOut() async {
    await GoogleSignIn().signOut();
    setState(() {
      app.user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app.user'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              _signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('login'),
              onPressed: () {},
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              child: Text('login'),
              onPressed: () {},
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              child: Text('login'),
              onPressed: () {},
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              child: Text('login'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
