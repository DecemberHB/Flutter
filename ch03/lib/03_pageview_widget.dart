/*
* 날짜 : 2025/10/27
* 이름 : 박효빈
* 내용 : PageView 위젯 실습하기
*
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(PageViewTest2());
}

class PageViewTest extends StatelessWidget {
  const PageViewTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('03.PageView 위젯 실습'),
          ),
          body: PageView(
            children: [
              Container(
                color: Colors.red,
                alignment: Alignment.center,
                child: const Text(
                  '페이지 1',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                color: Colors.green,
                alignment: Alignment.center,
                child: const Text(
                  '페이지 2',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text(
                  '페이지 3',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          )),
    );
  }
}

// StatefulWidget으로 변경해야 _PageViewTest2State를 사용할 수 있음
class PageViewTest2 extends StatefulWidget {
  const PageViewTest2({super.key});

  @override
  State<PageViewTest2> createState() => _PageViewTest2State();
}

// StateFulWidget 구현 클래스
class _PageViewTest2State extends State<PageViewTest2> {
  // PageView Controller 생성
  PageController _pageController = PageController(
    initialPage: 0, // 시작 페이지 인덱스
  );
  int _currentPage = 0;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('03.PageView 위젯 실습'),
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index){

              // 상태 변경 함수를 호출 해서 화면 새갱신
              setState(() {
                _currentPage = index;

              });
            },
            children: [
              Container(
                color: Colors.red,
                alignment: Alignment.center,
                child:  Text(
                  '페이지 1\n현재 인덱스 $_currentPage',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                color: Colors.green,
                alignment: Alignment.center,
                child:  Text(
                  '페이지 2\n현재 인덱스 $_currentPage',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child:  Text(
                  '페이지 3\n현재 인덱스 $_currentPage',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          )),
    );
  }
}
