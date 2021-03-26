import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kakao_sample_profile/src/model/user_model.dart';

class FirebaseUserRepository {
  static Future<String> signup(UserModel user) async {
    CollectionReference users = FirebaseFirestore.instance.collection(
        "users"); //collection은 firbase의 folder명, document, db의 tabble과 같음
    DocumentReference drf =
        await users.add(user.toMap()); //위에서 만든 users collection에 데이터를 추가하는것.
    return drf.id; //얘는 그냥 유저가 담겨져있는 document의 id
  }

  static Future<UserModel> findUserByUid(String uid) async {
    CollectionReference users = FirebaseFirestore.instance
        .collection("users"); //users collection에 있는 모든 user를 불러옴
    QuerySnapshot data = await users
        .where('uid', isEqualTo: uid)
        .get(); // users에서 String으로 들어온 uid값과 같은 uid를 가진 user를 찾음
    // data.size == 0 이면 같은 uid를 가진 user가 없다는 뜻.
    if (data.size == 0) {
      return null;
    } else {
      return UserModel.fromJson(data.docs[0].data(), data.docs[0].id);
    }
  }

  static void updateLastLoginDate(String docId, DateTime time) {
    CollectionReference users = FirebaseFirestore.instance
        .collection("users"); //users collection에 있는 모든 user를 불러옴
    users.doc(docId).update({"last_login_time": time});
  }

  static void updateImageUrl(String docId, String url, String fieldName) {
    CollectionReference users = FirebaseFirestore.instance
        .collection("users"); //users collection에 있는 모든 user를 불러옴
    users.doc(docId).update({fieldName: url});
  }

  static void updateData(String docId, UserModel user) {
    CollectionReference users = FirebaseFirestore.instance
        .collection("users"); //users collection에 있는 모든 user를 불러옴
    users.doc(docId).update(user.toMap());
  }
}
