/*
  날짜 : 2025/10/27
  이름 : 박효빈
  내용 : TabBar 위젯 실습하기
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  // runApp(TabBarTest()); // 상단 탭바 예제 실행
  runApp(BottomTabBarTest()); // 하단 탭바 예제 실행
}

// =============================
// ▶ 01. 상단 탭바 예제 (TabBarTest)
// =============================
class TabBarTest extends StatelessWidget {
  const TabBarTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // 전체 앱 기본 구조
      home: DefaultTabController( // 탭 컨트롤러 (탭 개수 지정)
        length: 3, // 탭 3개 생성
        child: Scaffold( // 화면의 기본 골격
          appBar: AppBar(
            title: const Text('04.TabBar 위젯 실습'),
            // ↓ 상단 탭바 설정
            bottom: TabBar(
              tabs: const [
                Tab(icon: Icon(Icons.home), text: '홈'),
                Tab(icon: Icon(Icons.star), text: '즐겨찾기'),
                Tab(icon: Icon(Icons.person), text: '프로필'),
              ],
            ),
          ),
          // ↓ 탭 클릭 시 보여줄 화면
          body: const TabBarView(
            children: [
              Center(child: Text('홈 화면', style: TextStyle(fontSize: 20))),
              Center(child: Text('즐겨찾기 화면', style: TextStyle(fontSize: 20))),
              Center(child: Text('프로필 화면', style: TextStyle(fontSize: 20))),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================
// ▶ 02. 하단 탭바 예제 (BottomTabBarTest)
// =============================
class BottomTabBarTest extends StatefulWidget {
  const BottomTabBarTest({super.key});

  @override
  State<BottomTabBarTest> createState() => _BottomTabBarTestState();
}

// 상태를 관리하는 State 클래스
class _BottomTabBarTestState extends State<BottomTabBarTest> {

  // 현재 선택된 탭의 인덱스 (0 = 홈, 1 = 즐겨찾기, 2 = 프로필)
  int _selectedIndex = 0;

  // 탭마다 보여줄 화면 위젯 목록
  final List<Widget> _widgetList = [
    const Center(child: Text('홈 화면', style: TextStyle(fontSize: 20))),
    const Center(child: Text('즐겨찾기 화면', style: TextStyle(fontSize: 20))),
    const Center(child: Text('프로필 화면', style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // 앱 기본 구조
      home: Scaffold( // 화면의 골격
        appBar: AppBar(
          title: const Text('04.Bottom TabBar 실습'),
        ),

        // ▼ 선택된 탭에 맞는 화면 보여줌
        body: _widgetList.elementAt(_selectedIndex),

        // ▼ 하단 탭바 (BottomNavigationBar)
        bottomNavigationBar: BottomNavigationBar(
          // 탭 버튼들 (아이콘 + 라벨)
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: '즐겨찾기'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
          ],

          // 현재 선택된 탭 인덱스
          currentIndex: _selectedIndex,

          // 선택된 아이템 색상
          selectedItemColor: Colors.blue,

          // 탭 클릭 시 실행되는 콜백 함수
          onTap: (index) {
            // setState → 상태 변경 후 화면 다시 그림 (StatefulWidget의 핵심)
            setState(() {
              _selectedIndex = index; // 클릭한 탭 인덱스로 변경
            });
          },
        ),
      ),
    );
  }
}
