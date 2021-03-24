import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:simplenote/constants/db_constatns.dart';
import 'package:simplenote/models/user_model.dart';

class ProfileState extends Equatable {
  final bool loading;
  final User user;

  ProfileState({this.loading, this.user});

  ProfileState copywith({
    bool loading,
    User user,
  }) {
    return ProfileState(
        loading: loading ?? this.loading, user: user ?? this.user);
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, user];
}

class ProfileProvider with ChangeNotifier {
  ProfileState state = ProfileState(loading: false);

  Future<void> getUserProfile(String userId) async {
    state = state.copywith(loading: true);
    notifyListeners();

    try {
      DocumentSnapshot userDoc = await usersRef.doc(userId).get();
      if (userDoc.exists) {
        User user = User.fromDoc(userDoc);
        state = state.copywith(loading: false, user: user);
        notifyListeners();
      } else {
        throw Exception('Fail to get user info');
      }
    } catch (e) {
      state = state.copywith(loading: false);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> editUserProfile(String userId, String name, String email) async {
    state = state.copywith(loading: false);
    notifyListeners();

    try {
      await usersRef.doc(userId).update({
        'name': name,
      });
      state = state.copywith(
          loading: false, user: User(id: userId, name: name, email: email));
      notifyListeners();
    } catch (e) {
      state = state.copywith(loading: false);
      notifyListeners();
      rethrow;
    }
  }
}
