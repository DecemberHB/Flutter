/*
*
* 날짜 : 2025/10/28
* 이름 : 박효빈
* 내용 : 5장 Flutter 상태 관리 실습
* */

import 'package:flutter/material.dart';
void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('01. 상태 관리 기본'),),
        body: ParentStateApp(),
      ),
    );
  }
}

// 정의
class ParentStateApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ParentStateAppState();

}

// 구현
class _ParentStateAppState extends State<ParentStateApp> {

  // 상태 속성
  int _count = 0;
  String _text = '';

  // 자식 위젯에서 사용할 상태 속성
  bool _favorited = false;
  int _favoriteCount = 0;

  // 처리 함수 여따 선언
  void toggleFavorite() {
    if(_favorited){
      _favorited = false;
      _favoriteCount -= 1;
    }else{
      _favorited = true;
      _favoriteCount += 1;
    }

    setState(() {

    });

    print('_favorited : $_favorited');
  }


  // 상태 처리 함수 1
  void increment() {
    // 위젯 상태를 업데이트하고 UI 재빌드(build 호출)

    // _count ++; 분리하지말고 setState에 넣음
    setState(() {
      _count ++;
      // 호출해야 카운트값 변화함

    });

    print('_count : $_count');
  }
  // 상태 처리 함수 2
  void changeText(String newText) {
    // 위젯 상태를 업데이트하고 UI 재빌드(build 호출)

    //_text = newText; 분리하지말고 setState에 넣음

    setState(() {
      _text = newText;
    });
    print('_text : $_text');


  }

  @override
  Widget build(BuildContext context) { // 얘를 다시 호출해야 화면에 출력 -> >> setState <<

    return Padding(
        padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,// 왼쪽정렬
        children: [
          Text('Count : $_count'),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){
                // 여기서 함수 호출
                increment(); // onPressed : increment도 가능
              },
              child: const Text('증가')
          ),
          Divider(),
          Text(_text),
          const SizedBox(height: 10,),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '자유 입력'
            ),
            onChanged: (value){
              // 매개변수 value값이 텍스트필드안에서 입력 되는 값임
               changeText(value);
            },
          ),
          Divider(),
          // 함수 초기화
          IconWidget(favoited: _favorited, toggleFunction: toggleFavorite,),
          ContentWidget(favoriteCount: _favoriteCount,)
        ],
      ),
    );
  }
}


// 위젯 2개 정의

class IconWidget extends StatelessWidget {

  // 생성자 초기화 해줘야함
  final bool favoited;
  final Function toggleFunction;

  // 부모 상태 받아와서 사용
  const IconWidget({super.key, this.favoited = false, required this.toggleFunction});

  @override
  Widget build(BuildContext context) {

    // 화면 구현
    return Center(
      child: IconButton(
          onPressed: (){
            toggleFunction(); // 호출
          },
          icon: (favoited ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
        iconSize: 100,
        color: Colors.red,
      ),
    );
  }

}


class ContentWidget extends StatelessWidget {
  final int favoriteCount;

  const ContentWidget({super.key, required this.favoriteCount});
  @override
  Widget build(BuildContext context) {


    //화면 구현
    return Center(
      child: Text(
        'favoriteCount 나의 페이뽀릿 : ',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
      ),
    );
  }
}