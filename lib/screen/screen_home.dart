import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model_quiz.dart';
import 'package:flutter_application_1/screen/screen_quiz.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Quiz dummy data
  // Start Quiz Now! 버튼을 누를 때 quiz api 호출 == quiz dummy data를 quiz_screen으로 넘겨줌
  List<Quiz> quizzes = [
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
  @override
  Widget build(BuildContext context) {
    // MediaQuery : 반응형 UI 를 만들기위해 기기의 정보 가져옴
    // width 와 height에 곱하기 한 상대적인 값으로 높이, 패딩, 폰트사이즈 값 정함
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return WillPopScope(
      onWillPop: () async => false,
      // SafeArea : 기기의 상단 notice bar 부분, 하단 영역을 침범하지 않는 안전한 영역 잡아주는 위젯
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Quiz App'),
            backgroundColor: Colors.deepPurple,
            // leading 비워두기 : 앱 바 좌측에 있는 버튼 지우기 효과. ex. 페이지 이동시 자동으로 생기는 뒤로가기 버튼 지우기
            leading: Container(),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'images/quiz.jpeg',
                  width: width * 0.8,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.024),
              ),
              Text(
                'Flutter 퀴즈 앱',
                style: TextStyle(
                  fontSize: width * 0.065,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '퀴즈 풀기 전 안내 사항입니다\n꼼꼼히 읽고 퀴즈 풀기를 눌러주세요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.048),
              ),
              _buildStep(width, '1. 랜덤으로 나오는 퀴즈 3개를 풀어보세요.'),
              _buildStep(width, '2. 문제를 잘 읽고 정답을 고른 뒤\n다음 문제 버튼을 눌러주세요.'),
              _buildStep(width, '3. 만점을 향해 도전해보세요.'),
              Padding(
                padding: EdgeInsets.all(width * 0.048),
              ),
              Container(
                padding: EdgeInsets.only(bottom: width * 0.036),
                child: Center(
                  child: ButtonTheme(
                    minWidth: width * 0.8,
                    height: height * 0.05,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      child: Text(
                        'Strat Quiz Now!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.deepPurple),
                      onPressed: () {
                        // 버튼 누르면 screen_quiz 띄우기
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // quiz dummy data 넘겨주기
                            builder: (context) => QuizScreen(
                              quizzes: quizzes,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
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
        children: <Widget>[
          Icon(
            Icons.check_box,
            size: width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.024),
          ),
          Text(title)
        ],
      ),
    );
  }
}
