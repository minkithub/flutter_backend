class UserModel {
  String uid;
  String docId;
  String name;
  DateTime createdTime;
  DateTime lastLoginTime;

  UserModel(
      {this.uid, this.docId, this.name, this.createdTime, this.lastLoginTime});

  // UserModel을 map으로 바꿔주는 함수.
  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'name': this.name,
      'created_time': this.createdTime,
      'last_login_time': this.lastLoginTime
    };
  }

  UserModel.fromJson(Map<String, dynamic> json, String docId)
      : uid = json['uid'] as String,
        docId = docId,
        name = json['name'] as String,
        createdTime = json['created_time'].toDate(),
        lastLoginTime = json['last_login_time'].toDate();
}
