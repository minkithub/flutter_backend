import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_sample_profile/src/profile.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ImageCropper',
      theme: ThemeData.light().copyWith(primaryColor: Colors.white),
      home: Profile(),
    );
  }
}
