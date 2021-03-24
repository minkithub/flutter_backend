import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenote/pages/home_page.dart';
import 'package:simplenote/pages/note_page.dart';
import 'package:simplenote/pages/signup_page.dart';
import 'package:simplenote/providers/auth_provider.dart';
import 'package:simplenote/providers/note_provider.dart';
import 'package:simplenote/providers/profile_provider.dart';
import 'pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

void main() async {
  //firebase initiallize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //user의 로그인 상태에 따라 첫 페이지 변경
  Widget isAuthenticated(BuildContext context) {
    if (context.watch<firebaseAuth.User>() != null) {
      return HomePage();
    } else {
      return SigninPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<firebaseAuth.User>.value(
          value: firebaseAuth.FirebaseAuth.instance.authStateChanges(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<NoteList>(
          create: (context) => NoteList(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'note',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Builder(builder: (context) => isAuthenticated(context)),
        routes: {
          SigninPage.routeName: (context) => SigninPage(),
          SignUpPage.routeName: (context) => SignUpPage(),
          NotesPage.routeName: (context) => NotesPage()
        },
      ),
    );
  }
}
