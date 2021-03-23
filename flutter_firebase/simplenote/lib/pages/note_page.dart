import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenote/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

class NotesPage extends StatefulWidget {
  static const String routeName = 'note-page';

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    // user.uid를 provider를 이용해 쉽게 접근핧 수 있다.
    final user = context.watch<firebaseAuth.User>();
    print('>>>>> ${user.uid}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AuthProvider>().signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Text('Notes'),
      ),
    );
  }
}
