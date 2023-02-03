import 'dart:ui';

import 'package:flutter/material.dart';

class CandWidget extends StatefulWidget {
  // VoidCallback : CandWidget을 사용하는 부모 위젯에서 지정한 onTap 전달
  VoidCallback tap;
  String text;
  int index;
  double width;
  bool answerState;

// Constructure
  CandWidget(
      {required this.tap,
      required this.text,
      required this.index,
      required this.width,
      required this.answerState});
  _CandWidgetState createState() => _CandWidgetState();
}

// 상태관리
class _CandWidgetState extends State<CandWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.8,
      height: widget.width * 0.1,
      padding: EdgeInsets.fromLTRB(widget.width * 0.048, widget.width * 0.024,
          widget.width * 0.048, widget.width * 0.024),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color.fromARGB(255, 198, 170, 247)),
        // 선택지가 선택됨 -> 보라색, 선택안됨 -> 흰색
        color: widget.answerState
            ? Color.fromARGB(255, 198, 170, 247)
            : Colors.white,
      ),
      child: InkWell(
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.width * 0.035,
            color: widget.answerState ? Colors.white : Colors.black,
          ),
        ),
        onTap: () {
          setState(() {
            widget.tap();
            widget.answerState = !widget.answerState;
          });
        },
      ),
    );
  }
}
