/*
  날짜 : 2025/10/27
  이름 : 박효빈
  내용 : State 생명주기 실습
*/
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp()); // 앱 시작점
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp은 앱 전체의 기본 뼈대를 제공함
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('03.상태 생명주기 실습'),
        ),
        body: ParentWidget(), // 부모 Stateful 위젯 실행
      ),
    );
  }
}

// ===============================
// ▶ 부모 Stateful 위젯
// ===============================
class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParentWidgetState(); // State 객체 생성
}

// ===============================
// ▶ 부모 State 클래스 (실제 동작 담당)
// ===============================
class _ParentWidgetState extends State<ParentWidget> {

  // 상태값 정의
  int counter = 0;      // 자식에게 전달할 카운트 값
  bool showChild = true; // 자식 위젯 표시 여부

  // 카운트 증가 함수
  void _increment(){
    setState(() {
      counter++; // counter 값을 1 증가
    });
  }

  // 자식 위젯 표시/숨김 토글 함수
  void _toggleChild(){
    setState(() {
      showChild = !showChild; // true ↔ false 전환
    });
  }

  @override
  Widget build(BuildContext context) {
    // build()는 setState가 호출될 때마다 재실행됨 (화면 다시 그림)
    return Column(
      children: [
        // showChild가 true일 때는 ChildWidget을 보여주고, false면 제거
        showChild
            ? ChildWidget(count: counter) // 자식에게 counter 값 전달
            : Text('ChildWidget 제거', style: TextStyle(fontSize: 26),),

        // counter 값을 증가시키는 버튼
        ElevatedButton(
            onPressed: _increment,
            child: const Text('ChildWidget 상태 변경')
        ),

        // 자식 위젯을 생성/제거하는 버튼
        ElevatedButton(
            onPressed: _toggleChild,
            child: const Text('ChildWidget 생성/제거')
        )
      ],
    );
  }
}

// ===============================
// ▶ 자식 Stateful 위젯 선언부
// ===============================
class ChildWidget extends StatefulWidget {

  // 부모로부터 count 값을 전달받음 (required: 반드시 전달되어야 함)
  ChildWidget({super.key, required this.count});

  int count; // 전달받은 값 저장

  @override
  State<StatefulWidget> createState() {
    print('createState...'); // State 객체가 처음 생성될 때 한 번만 실행
    return _ChildWidgetState(); // 자식의 State 반환
  }
}

// ===============================
// ▶ 자식 State 클래스 (생명주기 핵심)
// ===============================
class _ChildWidgetState extends State<ChildWidget> {

  @override
  void initState() {
    // 위젯이 처음 위젯 트리에 추가될 때 한 번만 실행됨
    print('initState...');
  }

  @override
  void didChangeDependencies() {
    // initState 다음에 호출되며, 상위 위젯의 데이터가 변경되면 다시 실행됨
    print('didChangeDependencies...');
  }

  @override
  Widget build(BuildContext context) {
    // build는 화면이 다시 그려질 때마다 호출됨
    return Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.all(10),
      color: Colors.blue,
      child: Text(
        // 부모에서 전달받은 count 값을 표시
        'ChildWidget count : ${widget.count}',
        style: TextStyle(fontSize: 26, color: Colors.white),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ChildWidget oldWidget) {
    // 부모 위젯이 새로운 데이터를 전달해 rebuild 될 때 실행
    // oldWidget은 이전의 데이터 상태를 가짐
    print('didUpdateWidget... old=${oldWidget.count}, new=${widget.count}');
  }

  @override
  void dispose() {
    // 위젯이 트리에서 완전히 제거될 때 호출됨 (메모리 해제용)
    print('dispose...');
  }
}
