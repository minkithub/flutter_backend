import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class FireStorageRepository {
  UploadTask uploadImageFile(String uid, String filename, File file) {
    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/$uid') //user/$uid폴더 안에 넣겠다.
        .child('/$filename.jpg');

    return ref.putFile(file);
  }
}
