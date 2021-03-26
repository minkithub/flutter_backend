import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:kakao_sample_profile/src/model/user_model.dart';
import 'package:kakao_sample_profile/src/repository/firebase_user_repository.dart';
import 'package:kakao_sample_profile/src/repository/firestorage_repository.dart';
import 'image_crop_controller.dart';

enum ProfileImageType { THUMBNAIL, BACKGROUND }

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  RxBool isEditMyProfile = false.obs;
  UserModel originMyProfile = UserModel(); // 디폴트값 설정
  Rx<UserModel> myProfile = UserModel().obs;
  FireStorageRepository _fireStorageRepository = FireStorageRepository();

  // firebase에 유저 데이터 보내는 과정
  void authStateChanges(User firebaseUser) async {
    if (firebaseUser != null) {
      UserModel userModel =
          await FirebaseUserRepository.findUserByUid(firebaseUser.uid);
      // 데이터가 있다는건 이미 가입되어 있다는 뜻
      if (userModel != null) {
        originMyProfile = userModel;
        FirebaseUserRepository.updateLastLoginDate(
            userModel.docId, DateTime.now());
      } else {
        // 여기서 받는것이 구글로그인의 데이터이자 디폴트값임.
        originMyProfile = UserModel(
          uid: firebaseUser.uid,
          name: firebaseUser.displayName,
          avatarUrl: firebaseUser.photoURL,
          createdTime: DateTime.now(),
          lastLoginTime: DateTime.now(),
        );
        String docId = await FirebaseUserRepository.signup(
            originMyProfile); //drf.id가 return값이니까 docId가 받는거.
        originMyProfile.docId = docId;
      }
    }
    myProfile(UserModel.clone(originMyProfile)); //롤백함수 대비용 클론 데이터 만듦
  }

  @override
  void onInit() {
    isEditMyProfile(false);
    super.onInit();
  }

  void toggleEditProfile() {
    isEditMyProfile(!isEditMyProfile.value);
  }

  void rollback() {
    myProfile.value.initImageFile();
    myProfile(
        originMyProfile); //originMyProfile은 항상 현 시점의 데이터이므로 rollback을 하면 결국 바뀌지 않음
    toggleEditProfile();
  }

  void updateName(String updateName) {
    // GetX 데이터 업데이트
    myProfile.update((my) {
      my.name = updateName;
    });
  }

  void updateDiscription(String updataDis) {
    myProfile.update((my) {
      my.discription = updataDis;
    });
  }

  void pickedImage(ProfileImageType type) async {
    if (!isEditMyProfile.value) return; //false면 null return
    File file = await ImageCropController.to.selectImage(type);
    if (file == null) return;
    switch (type) {
      case ProfileImageType.THUMBNAIL:
        myProfile.update((my) => my.avatarFile = file);
        break;
      case ProfileImageType.BACKGROUND:
        myProfile.update((my) => my.backgroundFile = file);
        break;
    }
  }

  void _updateProfileImageUrl(String downloadUrl) {
    originMyProfile.avatarUrl = downloadUrl;
    myProfile.update((user) => user.avatarUrl = downloadUrl);
  }

  void _updateBackGroundImageUrl(String downloadUrl) {
    originMyProfile.backgroundUrl = downloadUrl;
    myProfile.update((user) => user.backgroundUrl = downloadUrl);
  }

  // fireabse storage에 데이터 저장
  void save() {
    originMyProfile = myProfile.value;

    if (originMyProfile.avatarFile != null) {
      UploadTask task = _fireStorageRepository.uploadImageFile(
          originMyProfile.uid, "profile", originMyProfile.avatarFile);
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes) {
          String downloadUrl = await event.ref.getDownloadURL();
          _updateProfileImageUrl(downloadUrl);
          FirebaseUserRepository.updateImageUrl(
              originMyProfile.docId, downloadUrl, "avatar_url");
        }
      });
    }

    if (originMyProfile.backgroundFile != null) {
      UploadTask task = _fireStorageRepository.uploadImageFile(
          originMyProfile.uid, "background", originMyProfile.backgroundFile);
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes) {
          String downloadUrl = await event.ref.getDownloadURL();
          _updateBackGroundImageUrl(downloadUrl);
          FirebaseUserRepository.updateImageUrl(
              originMyProfile.docId, downloadUrl, "background_url");
        }
      });
    }

    FirebaseUserRepository.updateData(originMyProfile.docId, originMyProfile);
    toggleEditProfile();
  }
}
