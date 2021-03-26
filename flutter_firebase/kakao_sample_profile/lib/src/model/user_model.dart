import 'dart:io';

import 'package:flutter/foundation.dart';

// db에 파일을 저장하고 그 url만 필요하기 때문에 File은 생성자에서는 제외했다.
class UserModel {
  String uid;
  String docId;
  String name;
  String discription;
  String avatarUrl;
  String backgroundUrl;
  File avatarFile;
  File backgroundFile;
  DateTime lastLoginTime;
  DateTime createdTime;

  UserModel(
      {this.uid,
      this.docId,
      this.name = '', //default값 설정
      this.discription = '', //default값 설정
      this.avatarUrl,
      this.backgroundUrl,
      this.lastLoginTime,
      this.createdTime});

  // controller에서 rollback함수에 일반 UserModel을 두게되면 메모리가 공유되므로 rollback함수가 작동하지 않는다.
  // 따라서 이를 방지하기 위해 clone을 해줘서 메모리가 다른 UserModel을 만드는 것이다.
  UserModel.clone(UserModel user)
      : this(
          uid: user.uid,
          docId: user.docId,
          name: user.name,
          discription: user.discription,
          avatarUrl: user.avatarUrl,
          backgroundUrl: user.backgroundUrl,
          lastLoginTime: user.lastLoginTime,
          createdTime: user.createdTime,
        );

  void initImageFile() {
    avatarFile = null;
    backgroundFile = null;
  } // 이미지 초기화

  //docId는 필요가 없기 때문에 지운거
  // 결과적으로 여기 데이터가 firebase cloud에 저장되는것.
  Map<String, dynamic> toMap() {
    return {
      "uid": this.uid,
      "name": this.name,
      "discription": this.discription,
      "avatar_url": this.avatarUrl,
      "background_url": this.backgroundUrl,
      "last_login_time": this.lastLoginTime,
      "created_time": this.createdTime
    };
  }

  // 위의 firebase collection data를 json으로 바꿔줌
  UserModel.fromJson(Map<String, dynamic> json, String docId)
      : uid = json['uid'] as String,
        docId = docId,
        name = json['name'] as String,
        discription = json['discription'] as String,
        avatarUrl = json['avatar_url'] as String,
        backgroundUrl = json['background_url'] as String,
        lastLoginTime = json['last_login_time'].toDate(),
        createdTime = json['created_time'].toDate();
}
