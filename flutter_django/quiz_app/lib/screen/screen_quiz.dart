import 'package:flutter/material.dart';
import 'package:quiz_app/model/model_quiz.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:quiz_app/widget/widget_candidates.dart';

import 'screen_result.dart';

class QuizScreen extends StatefulWidget {
  final List<Quiz> quizs;
  QuizScreen({this.quizs});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> _answer = [-1, -1, -1];
  List<bool> _answerState = [false, false, false, false];
  int _currenIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    SwiperController _controller = SwiperController();

    List<Widget> _buildCandidates(double width, Quiz quiz) {
      List<Widget> _children = [];
      for (int i = 0; i < 4; i++) {
        _children.add(CandiWidget(
          index: i,
          text: quiz.candidates[i],
          width: width,
          answerState: _answerState[i],
          tap: () {
            setState(() {
              for (int j = 0; j < 4; j++) {
                if (j == i) {
                  _answerState[j] = true;
                  _answer[_currenIndex] = j;
                } else {
                  _answerState[j] = false;
                }
              }
            });
          },
        ));
        _children.add(SizedBox(height: width * 0.024));
      }
      return _children;
    }

    Widget _buildQuizCard(Quiz quiz, double width, double height) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
              child: Text(
                'Q' + (_currenIndex + 1).toString() + '.',
                style: TextStyle(
                    fontSize: width * 0.06, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: width * 0.8,
              padding: EdgeInsets.only(top: width * 0.012),
              child: AutoSizeText(
                quiz.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                    fontSize: width * 0.048, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Column(children: _buildCandidates(width, quiz)),
            Container(
              padding: EdgeInsets.all(width * 0.024),
              child: Center(
                child: ButtonTheme(
                  minWidth: width * 0.5,
                  height: height * 0.05,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RaisedButton(
                    child: _currenIndex == widget.quizs.length - 1
                        ? Text('결과보기')
                        : Text('다음문제'),
                    textColor: Colors.white,
                    color: Colors.deepPurple,
                    onPressed: _answer[_currenIndex] == -1
                        ? null
                        : () {
                            setState(() {
                              if (_currenIndex == widget.quizs.length - 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultScreen(
                                              answers: _answer,
                                              quizs: widget.quizs,
                                            )));
                              } else {
                                // 정답을 맞췄기때문에 넘어가면서 기존 변수들 초기화 하고 Index는 1추가
                                _answerState = [false, false, false, false];
                                _currenIndex += 1;
                                // 다음 문제로 넘어감
                                _controller.next();
                              }
                            });
                          },
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepPurple),
            ),
            width: width * 0.85,
            height: height * 0.5,
            child: Swiper(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              loop: false,
              itemCount: widget.quizs.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuizCard(widget.quizs[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }
}
