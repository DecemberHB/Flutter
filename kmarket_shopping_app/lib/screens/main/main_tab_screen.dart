// 앱 시작 메인 화면 -> 로딩 화면
// 로딩 화면 -> 이후의 메인화면 Page

import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/screens/main/cart_tab.dart';
import 'package:kmarket_shopping_app/screens/main/category_tab.dart';
import 'package:kmarket_shopping_app/screens/main/home_tab.dart';
import 'package:kmarket_shopping_app/screens/main/my_tab.dart';
import 'package:kmarket_shopping_app/screens/main/search_tab.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainTabScreenState();


}

class _MainTabScreenState extends State<MainTabScreen> {

  // 속성 선언
  int _selectIndex = 0;
  // onTap
  void _onTanHandler(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
  
  //  5개  TabList
  late final List<Widget> _widgetList = [
    HomeTab(onTapSwitch: _onTanHandler,), // HomeTap page에 선언된 OnTapSwich!
    CategoryTab(),
    SearchTab(),
    MyTab(),
    CartTab()
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: null,
      body: Center(
        // 탭 전환 기능
        child: _widgetList.elementAt(_selectIndex)
      ),
      // 맨 아래쪽에 앱 바 표시
      bottomNavigationBar: BottomNavigationBar(
          items: [
            // 기본 제공 아이콘 사용
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: '카테 고리'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이 페이지'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '장바구니'),

          ],
        currentIndex: _selectIndex, // 속성 인덱스 변수
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        // currentIndex 기능 구현
        onTap: _onTanHandler, // 인덱스 클릭 이벤트
      ),
    );
  }

}