import 'package:flutter/material.dart';
import 'package:quiz_app/model/model_quiz.dart';
import 'package:quiz_app/screen/screen_quiz.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    // 퀴즈 풀기 버튼을 눌렀을때 튀즈 데이터를 가져오는 방식으로 api 호출
    // 즉 이 말은 화면이 바뀌었을때, 데이터를 넘겨준다는 방식

    // 퀴즈 더미 데이터
    List<Quiz> quizs = [
      Quiz.fromMap({
        'title': 'test',
        'candidates': ['a', 'b', 'c', 'd'],
        'answer': 0
      }),
      Quiz.fromMap({
        'title': 'test',
        'candidates': ['a', 'b', 'c', 'd'],
        'answer': 0
      }),
      Quiz.fromMap({
        'title': 'test',
        'candidates': ['a', 'b', 'c', 'd'],
        'answer': 0
      }),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Quiz APp'),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(width * 0.024),
                  child: Text(
                    '플러터 퀴즈 앱',
                    style: TextStyle(
                        fontSize: width * 0.065, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Text(
                  '퀴즈를 풀기 전 안내사항입니다.\n꼼꼼히 읽고 퀴즈 풀기를 눌러주세요',
                  style: TextStyle(
                      fontSize: width * 0.035, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: width * 0.048,
              ),
              _buildStep(width, '1. 랜덤으로 나오는 퀴즈 3개를 풀어보세요.'),
              _buildStep(width, '2. 문제를 잘 읽고 정답으 고른 뒤\n다음 문제 버튼을 눌러주세요.'),
              _buildStep(width, '3. 만점을 향해 도전해보세요!'),
              SizedBox(
                height: width * 0.048,
              ),
              Container(
                  padding: EdgeInsets.only(bottom: width * 0.036),
                  child: Center(
                      child: ButtonTheme(
                    minWidth: width * 0.8,
                    height: height * 0.05,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: RaisedButton(
                      color: Colors.deepPurple,
                      child: Text(
                        '지금 퀴즈 풀기',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuizScreen(
                                      quizs: quizs,
                                    )));
                      },
                    ),
                  )))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(double width, String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          width * 0.048, width * 0.024, width * 0.048, width * 0.024),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_box, size: width * 0.04),
          SizedBox(height: width * 0.024),
          Text(title)
        ],
      ),
    );
  }
}
