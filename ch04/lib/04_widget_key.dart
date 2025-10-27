/*
* 날짜 : 2025/10/27
* 이름 : 박효빈
* 내용 : widget Key 실습
*/

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // ✅ Flutter 앱 시작 (MyApp을 최상위 위젯으로 실행)
}

// ==============================
// ▶ MyApp 클래스 (앱의 뼈대)
// ==============================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Flutter 앱의 전체 구조를 제공하는 위젯
      home: Scaffold( // 화면의 기본 골격 (AppBar + Body)
        appBar: AppBar(
          title: const Text('04.위젯 키 실습'), // 상단 제목 표시줄
        ),
        body: WidgetKeyTest(), // ✅ 실제 Key 실습 위젯을 body에 연결
      ),
    );
  }
}

// ==============================
// ▶ StatefulWidget : WidgetKeyTest
// ==============================
// Key의 작동 방식 확인용 StatefulWidget
class WidgetKeyTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _widgetKeyTestState();
}

// ==============================
// ▶ State 클래스 : _widgetKeyTestState
// ==============================
class _widgetKeyTestState extends State<WidgetKeyTest> {

  bool _swap = false; // false면 (파랑, 빨강) / true면 (빨강, 파랑)

  @override
  Widget build(BuildContext context) {
    return Column( // 세로로 위젯 배치
      children: [
        // ✅ 순서를 바꾸는 버튼
        ElevatedButton(
          onPressed: () {
            setState(() {
              _swap = !_swap; // 버튼 누를 때마다 순서 반전
            });
          },
          child: const Text('순서 바꾸기'),
        ),

        // ✅ 색상 박스 2개를 가로로 배치
        Row(
          children: _swap
          // _swap이 true일 경우 : 빨강 → 파랑
              ? [
            // Valuekey는 위젯을 구분하기 위한 식별값 , 위젯트리를 업데이트 할 때 위젯의 상태를 보존
            CounterBox(key: ValueKey(101), color: Colors.red),
            CounterBox(key: ValueKey(201), color: Colors.blue),
          ]
          // _swap이 false일 경우 : 파랑 → 빨강
              : [
            CounterBox(key: ValueKey(201), color: Colors.blue),
            CounterBox(key: ValueKey(101), color: Colors.red),
          ],
        )
      ],
    );
  }
}

// ==============================
// ▶ StatefulWidget : CounterBox
// ==============================
// 박스를 클릭하면 카운트가 증가하는 위젯
class CounterBox extends StatefulWidget {
  final Color color; // 박스 색상 (파랑 or 빨강)

  const CounterBox({super.key, required this.color}); // 생성자

  @override
  State<StatefulWidget> createState() => _CounterBoxState();
}

// ==============================
// ▶ State 클래스 : _CounterBoxState
// ==============================
// 실제 박스 내부 동작 담당
class _CounterBoxState extends State<CounterBox> {
  int _count = 0; // 클릭 횟수 저장 변수

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // 제스처 감지 위젯 (터치 이벤트 인식)
      onTap: () {
        setState(() {
          _count++; // 박스 클릭 시 카운트 +1
        });
      },
      child: Container( // 실제 박스 UI
        width: 200,
        height: 200,
        color: widget.color, // 부모로부터 전달받은 색상
        child: Center(
          child: Text(
            '_count : $_count', // 현재 카운트 출력
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
