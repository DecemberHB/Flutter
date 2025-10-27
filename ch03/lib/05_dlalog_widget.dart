/*
* 날짜 : 2025/10/27
* 이름 : 박효빈
* 내용 : Dialog 위젯 실습하기
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 메인 StatefulWidget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// MyApp의 State 클래스
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('05.Dialog 위젯 실습')),
        body: const DialogTest(), // DialogTest 위젯 연결
      ),
    );
  }
}

// DialogTest 위젯
class DialogTest extends StatefulWidget {
  const DialogTest({super.key});

  @override
  State<DialogTest> createState() => _DialogTestState();
}

// DialogTest의 상태 클래스 (강사님 방식으로 Dialog 함수 작성)
class _DialogTestState extends State<DialogTest> {
  // 기본 대화상자
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 배경영역 터치시 대화상자 닫기 불가능
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('기본 대화상자'),
          content: const Text('내용 ~ _ ~'),
          actions: [
            TextButton(
              onPressed: () {
                // e대화상자 위젯을 네비게이션 스택에서 제거
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // e대화상자 위젯을 네비게이션 스택에서 제거
                Navigator.of(context).pop();

                // 스낵바에 확인 출력
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('확인 클릭'),
                  ),
                );
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // 날짜 대화상자
  void _showDateDialog(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // 현재시간 초기화
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );

    print(selectedDate);
    // 스낵바에 확인 출력
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${selectedDate?.toString()}'), // null일경우 null 출력
      ),
    );
  }

  // 사용자정의 대화상자
  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 배경영역 터치시 대화상자 닫기 불가능
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 다이얼로그 크기 자동 조절
              children: [
                const Text('사용자 정의 대화상자'),
                const SizedBox(height: 10),
                const Text('사용자 정의 대화상자 내용'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('닫기'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _showAlertDialog(context);
            },
            child: const Text('기본 대화상자 출력'),
          ),
          ElevatedButton(
            onPressed: () {
              _showDateDialog(context);
            },
            child: const Text('달력 대화상자 출력'),
          ),
          ElevatedButton(
            onPressed: () {
              _showCustomDialog(context);
            },
            child: const Text('사용자 정의 대화상자 출력'),
          ),
        ],
      ),
    );
  }
}
