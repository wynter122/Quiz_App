import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model_quiz.dart';

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
          ),
        ),
      ),
    );
  }
}
