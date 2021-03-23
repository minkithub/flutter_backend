import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

class ProfilePage extends StatefulWidget {
  static const String routeName = 'profile-page';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // user.uid를 provider를 이용해 쉽게 접근핧 수 있다.
    final user = context.watch<firebaseAuth.User>();
    print('>>>>> ${user.uid}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
