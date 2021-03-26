import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_sample_profile/src/controller/profile_controller.dart';

import 'app.dart';
import 'src/controller/image_crop_controller.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(() => ProfileController());
        Get.lazyPut<ImageCropController>(() => ImageCropController());
      }),
      title: 'ImageCropper',
      theme: ThemeData.light().copyWith(primaryColor: Colors.white),
      home: App(),
    );
  }
}
