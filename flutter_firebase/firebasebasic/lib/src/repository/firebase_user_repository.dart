import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasebasic/src/model/user_model.dart';

class FirebaseUserRepository {
  static Future<UserModel> findUserByUid(String uid) async {
    // users collection에 있는 모든 user들을 users에 담음.
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // users collection에서 현재 firebaseUser.uid인 user만 가져와서 이를 data에 옮김
    QuerySnapshot data = await users.where('uid', isEqualTo: uid).get();
    // 여기서 data.size가 0이면 결국 같은 uid를 가진 user가 없다는 뜻.
    if (data.size == 0) {
      return null;
    } else {
      return UserModel.fromJson(data.docs[0].data(), data.docs[0].id);
    }
  }

  static Future<String> saveUserToFirebase(UserModel firebaseUser) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // firebase의 users collection에 data를 추가하는 것.
    DocumentReference drf = await users.add(firebaseUser.toMap());
    // user id 반환
    return drf.id;
  }

  static void updateLoginTime(String docId) {
    // userdata가 있다면 마지막 로그인 시간을 업데이트 해줘야함.
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(docId).update({'last_login_time': DateTime.now()});
  }

  static void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
