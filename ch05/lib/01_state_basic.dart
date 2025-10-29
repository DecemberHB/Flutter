/*
*
* 날짜 : 2025/10/28
* 이름 : 박효빈
* 내용 : 5장 Flutter 상태 관리 실습
*
* 핵심 개념 :
* - setState() : 상태(state)가 바뀌면 화면을 다시 그림 (build 재호출)
* - 부모 위젯에서 상태를 관리하고, 자식 위젯에게 데이터를 전달
* - 자식 위젯은 부모의 함수를 호출해서 상태를 바꾸는 구조
*/

import 'package:flutter/material.dart';

void main() {
  // 앱 시작점
  runApp(MyApp()); // MyApp 위젯 실행
}

// 앱의 전체 뼈대 (StatelessWidget: 상태가 없는 위젯)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 앱의 기본 골격
      home: Scaffold(
        appBar: AppBar(title: const Text('01. 상태 관리 기본')), // 상단 바
        body: ParentStateApp(), // 메인 본문 (상태 관리 담당)
      ),
    );
  }
}

// -----------------------------------------------------------
// StatefulWidget : 상태(state)를 가질 수 있는 위젯 정의
// -----------------------------------------------------------
class ParentStateApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParentStateAppState();
}

// -----------------------------------------------------------
// 상태(State) 구현부
// -----------------------------------------------------------
class _ParentStateAppState extends State<ParentStateApp> {
  // 상태 변수들 (화면에 표시될 데이터)
  int _count = 0;          // 숫자 카운트
  String _text = '';       // 입력된 텍스트
  bool _favorited = false; // 좋아요 버튼 상태 (눌림/안 눌림)
  int _favoriteCount = 0;  // 좋아요 개수

  // -------------------------------------------------------
  // 1. 좋아요 토글 함수 (자식 IconWidget이 이 함수 호출함)
  // -------------------------------------------------------
  void toggleFavorite() {
    // 현재 좋아요 상태에 따라 개수를 늘리거나 줄임
    if (_favorited) {
      _favorited = false;
      _favoriteCount -= 1;
    } else {
      _favorited = true;
      _favoriteCount += 1;
    }

    // setState() 호출 → 화면(build) 다시 그림
    setState(() {});

    print('_favorited : $_favorited');
  }

  // -------------------------------------------------------
  // 2. 카운트 증가 함수
  // -------------------------------------------------------
  void increment() {
    // setState 내부에서 상태값을 변경해야 화면에 반영됨
    setState(() {
      _count++;
    });

    print('_count : $_count');
  }

  // -------------------------------------------------------
  // 3. 텍스트 변경 함수
  // -------------------------------------------------------
  void changeText(String newText) {
    // 입력된 텍스트를 상태 변수에 저장
    setState(() {
      _text = newText;
    });

    print('_text : $_text');
  }

  // -------------------------------------------------------
  // build() : 실제 화면(UI) 구성 부분
  // setState()가 호출되면 이 함수가 다시 실행됨
  // -------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10), // 화면 여백
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
        children: [
          // 카운트 출력
          Text('Count : $_count'),

          const SizedBox(height: 10),

          // "증가" 버튼 → 클릭 시 increment() 호출
          ElevatedButton(
            onPressed: () {
              increment(); // 상태값 변경
            },
            child: const Text('증가'),
          ),

          Divider(), // 구분선

          // 입력된 텍스트 출력
          Text(_text),

          const SizedBox(height: 10),

          // 텍스트 입력창 → 입력이 바뀌면 changeText() 실행
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '자유 입력',
            ),
            onChanged: (value) {
              changeText(value); // 입력값을 전달받아 상태 변경
            },
          ),

          Divider(),

          // 하트 아이콘 위젯 (좋아요 기능)
          // 부모 상태 전달 : favoited / 함수 전달 : toggleFavorite
          IconWidget(
            favoited: _favorited,
            toggleFunction: toggleFavorite,
          ),

          // 좋아요 개수 표시 위젯
          ContentWidget(favoriteCount: _favoriteCount),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------
// 자식 위젯 1️⃣ : 하트(좋아요) 버튼
// -----------------------------------------------------------
class IconWidget extends StatelessWidget {
  // 부모로부터 받을 데이터
  final bool favoited;           // 좋아요 상태
  final Function toggleFunction; // 좋아요 토글 함수

  // 생성자 (필요한 값들을 부모로부터 받음)
  const IconWidget({
    super.key,
    this.favoited = false,
    required this.toggleFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        // 버튼 클릭 시 부모의 toggleFavorite() 호출
        onPressed: () {
          toggleFunction(); // 부모의 상태 변경 함수 실행
        },
        // favoited 값에 따라 하트 모양 바뀜
        icon: (favoited
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border)),
        iconSize: 100,
        color: Colors.red,
      ),
    );
  }
}

// -----------------------------------------------------------
// 자식 위젯 2️⃣ : 좋아요 개수 표시
// -----------------------------------------------------------
class ContentWidget extends StatelessWidget {
  // 부모로부터 좋아요 개수를 받음
  final int favoriteCount;

  const ContentWidget({super.key, required this.favoriteCount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        // 좋아요 개수를 화면에 표시
        'favoriteCount 나의 페이뽀릿 : $favoriteCount',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
