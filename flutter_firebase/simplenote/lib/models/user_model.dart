import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;

  User({this.id, this.name, this.email});

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data();

    return User(
        id: userDoc.id, name: userData['name'], email: userData['email']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }

  @override
  // []안의 세 변수가 같으면 같은 변수라고 취급
  List<Object> get props => [id, name, email];
}
