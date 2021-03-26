import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextEditorWidget extends StatefulWidget {
  final String text;

  TextEditorWidget({this.text});

  @override
  _TextEditorWidgetState createState() => _TextEditorWidgetState();
}

class _TextEditorWidgetState extends State<TextEditorWidget> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _textEditingController.text = widget.text;
    super.initState();
  }

  // @override
  // void dispose() {
  //   _textEditingController.dispose();
  //   super.dispose();
  // }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
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
              Get.back(result: _textEditingController.text); // 뒤로 가면서 값 전달
            },
            child: Text(
              '완료',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _eidtTextField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
            controller: _textEditingController,
            maxLength: 20,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
              counterStyle: TextStyle(color: Colors.white, fontSize: 14),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(0),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            _header(),
            Expanded(
              child: _eidtTextField(),
            )
          ],
        ));
  }
}
