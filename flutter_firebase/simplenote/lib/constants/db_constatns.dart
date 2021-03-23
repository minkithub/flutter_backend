//firebase의 collection을 reference하기 위한 페이지

import 'package:cloud_firestore/cloud_firestore.dart';

// 반복사용을 막기 위함
final notesRef = FirebaseFirestore.instance.collection('notes');
