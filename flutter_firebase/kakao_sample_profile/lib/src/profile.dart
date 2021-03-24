import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Widget _backgorundImgae() {
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      left: 0,
      child: GestureDetector(
        onTap: () {
          print('Change my bg');
        },
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }

  Widget _header() {
    return Positioned(
      top: Get.mediaQuery.padding.top, //safeArea의 역할을 동일하게 함.
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  print('프로필 편집 취소');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                    Text(
                      '프로필 편집',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('프로필 편집 저장');
                },
                child: Text(
                  '완료',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _oneButton(IconData icon, String title, Function ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(
            height: 10,
          ),
          Text(
            '$title',
            style: TextStyle(fontSize: 12, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _footer() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 1, color: Colors.white.withOpacity(0.4)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _oneButton(Icons.chat_bubble, '나와의 채팅', () {}),
                _oneButton(Icons.edit, '프로필 편집', () {}),
                _oneButton(Icons.chat_bubble_outline, '카카오 스토리', () {})
              ],
            )));
  }

  Widget _profileImage() {
    return Container(
      width: 120,
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.network(
          'https://spnimage.edaily.co.kr/images/photo/files/NP/S/2020/10/PS20100800026.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _profileInfo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text('개발하는남자',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              )),
        ),
        Text(
          '구독과 좋아요 부탁드립니다.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _myProfile() {
    return Positioned(
      bottom: 120,
      left: 0,
      right: 0,
      child: Container(
        height: 200,
        child: Column(
          children: [_profileImage(), _profileInfo()],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3f3f3f),
      body: Container(
        child: Stack(
          children: [_backgorundImgae(), _header(), _myProfile(), _footer()],
        ),
      ),
    );
  }
}
