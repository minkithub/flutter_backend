import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

class AppState {
  bool loading;
  firebaseAuth.User user;

  AppState({this.loading, this.user});
}
