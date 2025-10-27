/*
* 날짜 : 2025/10/27
* 이름 : 박효빈
* 내용 : Stateful 동적 위젯 실습
*/

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget { // 얘는 유지
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('02_Stateful 위젯 실습'),
        ),
        body: const StatefulTest(), // MyApp - 실제내용 분리해서 사용하기 위해서 이렇게 호출하는 방식
      ),
    );
  }
}

// ✅ StatefulWidget 구현
// Stateful 위젯은 상태를 통해 화면을 갱신하는 동적 위젯
class StatefulTest extends StatefulWidget {
  const StatefulTest({super.key}); // 생성자 (const 붙여서 경고 제거)

  @override
  State<StatefulTest> createState() => _StatefulTestState();
}

// ✅ State 클래스 (StatefulTest와 연결)
class _StatefulTestState extends State<StatefulTest> {

  // 상태속성
  int counter = 0; // 속성

  // 함수 정의
  void _increment() {
    
    // 상태를 업데이트하고, build를 재호출
    setState(() {
      counter++;
    });
    
    print('counter : $counter');
  }

  @override
  Widget build(BuildContext context) {

    print('build...');

    return Column(
      children: [
        Text(
          '카운터 : $counter',
          style: const TextStyle(fontSize: 24),
        ),
        ElevatedButton(
          onPressed: _increment,
          child: const Text('카운트'),
        ),
      ],
    );
  }
}
