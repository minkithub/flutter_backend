import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart'
    as firebaseAuth; // 이르에 대한 혼란 방지
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthProgressState extends Equatable {
  final bool loading;
  AuthProgressState({this.loading});

  AuthProgressState copywith({bool loading}) {
    return AuthProgressState(loading: loading ?? this.loading);
  }

  @override
  List<Object> get props => [loading];
}

class AuthProvider extends ChangeNotifier {
  final _auth = firebaseAuth.FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  AuthProgressState state = AuthProgressState(loading: false);

  Future<void> signUp(BuildContext context,
      {String name, String email, String password}) async {
    state = state.copywith(loading: true);
    notifyListeners();

    try {
      firebaseAuth.UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      firebaseAuth.User signedInUser = userCredential.user;

      await _firestore
          .collection('users')
          .doc(signedInUser.uid)
          .set({'name': name, 'email': email});
      state = state.copywith(loading: false);
      notifyListeners();
      // signup -> signin으로 가고 거기서 다시 함수가 돔
      Navigator.pop(context);
    } catch (e) {
      state = state.copywith(loading: false);
      notifyListeners();
      rethrow; //재시도
    }
  }

  Future<void> signIn({String email, String password}) async {
    state = state.copywith(loading: true);
    notifyListeners();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      state = state.copywith(loading: false);
      notifyListeners();
    } catch (e) {
      state = state.copywith(loading: false);
      notifyListeners();
    }
  }

  void signOut() async {
    _auth.signOut();
  }
}
