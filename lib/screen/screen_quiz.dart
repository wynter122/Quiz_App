import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model_quiz.dart';
import 'package:flutter_application_1/widget/widget_candidate.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizzes;

  // 이전 화면으로부터 퀴즈 데이터 넘겨받음
  QuizScreen({required this.quizzes});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

// 세가지 상태정보 필요
// 1. 각 퀴즈별 사용자의 정답을 담아놓을 _answers list. init_val = -1
// 2. 퀴즈 하나에 대하여 각 선택지가 선택되었는지 bool로 기록. init_val = false
// 3. 현재 어떤 문제 보고있는지에 대한 정보
class _QuizScreenState extends State<QuizScreen> {
  List<int> _answers = [-1, -1, -1]; // 문제 개수 == 리스트 element 개수
  List<bool> _answerState = [
    false,
    false,
    false,
    false
  ]; // 보기개수 == 리스트 element 개수
  int _currentIndex = 0;
  SwiperController _controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
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
              physics:
                  NeverScrollableScrollPhysics(), // Swipe 모션을 통해 퀴즈가 넘어가지 않음
              loop: false,
              itemCount: widget.quizzes.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuizCard(widget.quizzes[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q' + (_currentIndex + 1).toString() + '.',
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012),
            child: AutoSizeText(
              // 퀴즈 제목이 길 경우 대비
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(), // 이후 배치할 위젯을 아래로 배치
          ),
          Column(
            children:
                _buildCandidates(width, quiz), // 목록들이 특별한 기능이 있기때문에 함수로 작성
          ),
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.5,
                height: height * 0.05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // 현재 인덱스가 마지막 퀴즈라면 결과보기. 아니라면 다음문제
                child: ElevatedButton(
                  child: _currentIndex == widget.quizzes.length - 1
                      ? Text('결과 보기')
                      : Text('다음 문제'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                  ),
                  // 정답이 맞는지 체크. -1이라면 오답, 아니라면 정답 -> 다음문제
                  onPressed: _answers[_currentIndex] == -1
                      ? null
                      : () {
                          if (_currentIndex == widget.quizzes.length - 1) {
                          } else {
                            _answerState = [false, false, false, false];
                            _currentIndex += 1;
                            _controller.next();
                          }
                        },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for (int i = 0; i < 4; i++) {
      _children.add(
        CandWidget(
          tap: () {
            setState(() {
              for (int j = 0; j < 4; j++) {
                if (j == i) {
                  _answerState[j] = true;
                  _answers[_currentIndex] = j;
                } else {
                  _answerState[j] = false;
                }
              }
            });
          },
          text: quiz.candidates[i],
          index: i,
          width: width,
          answerState: _answerState[i],
        ),
      );
      _children.add(
        Padding(
          padding: EdgeInsets.all(width * 0.024),
        ),
      );
    }

    return _children;
  }
}
