/*
* 날짜 : 2025/10/27
* 이름 : 박효빈
* 내용 : State 생명 주기 실습
*/

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // 앱 시작점
}

// ===========================
// ▶ MyApp (메인 앱 구조)
// ===========================
class MyApp extends StatelessWidget { // StatelessWidget은 상태 변화가 없음
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('03_State Lifecycle(생명주기) 위젯 실습'),
        ),
        // ↓ 실제 실습할 Stateful 위젯 호출
        body: const ParentStatefulTest(),
      ),
    );
  }
}

// ===========================
// ▶ ParentStatefulTest (부모 StatefulWidget)
// ===========================
class ParentStatefulTest extends StatefulWidget {
  const ParentStatefulTest({super.key});

  // 부모 위젯과 연결될 State 객체 생성
  @override
  State<ParentStatefulTest> createState() => _ParentStatefulTestState();
}

// ===========================
// ▶ 부모 State 클래스
// ===========================
class _ParentStatefulTestState extends State<ParentStatefulTest> {
  int counter = 0; // 상태값 (자식에게 전달됨)
  bool showChild = true; // 자식 위젯 표시 여부 (true면 보여줌)

  // 카운터 증가 함수
  void _increment() {
    setState(() {
      counter++;
    });
    print('counter : $counter');
  }

  // 자식 위젯 보이기 / 숨기기 토글 함수
  void _toggleChild() {
    setState(() {
      showChild = !showChild;
    });
    print('자식 위젯 ${showChild ? "보이기" : "숨기기"}');
  }

  @override
  Widget build(BuildContext context) {
    // build()는 상태가 변경될 때마다 다시 호출됨
    print('Parent build...');

    return Column(
      children: [
        // showChild 값에 따라 자식 위젯 표시 or 제거
        showChild
            ? ChildWidget(count: counter) // 자식에게 counter 전달
            : const Text(
          'ChildWidget 제거됨',
          style: TextStyle(fontSize: 26),
        ),

        // 카운트 증가 버튼
        ElevatedButton(
          onPressed: _increment,
          child: const Text('ChildWidget 상태 변경'),
        ),

        // 자식 생성/제거 버튼
        ElevatedButton(
          onPressed: _toggleChild,
          child: const Text('ChildWidget 생성/제거'),
        ),
      ],
    );
  }
}

// ===========================
// ▶ ChildWidget (자식 StatefulWidget)
// ===========================
class ChildWidget extends StatefulWidget {
  // 부모에서 count 값을 받아옴 (required: 필수 매개변수)
  ChildWidget({super.key, required this.count});

  int count; // 부모의 counter 값을 전달받음

  @override
  State<ChildWidget> createState() {
    print('createState() 실행 — ChildWidget의 State 객체 생성');
    return _ChildWidgetState();
  }
}

// ===========================
// ▶ ChildWidget의 State 클래스 (진짜 생명주기 테스트 핵심)
// ===========================
class _ChildWidgetState extends State<ChildWidget> {
  // 1️⃣ 위젯이 처음 생성될 때 단 한 번 실행됨
  @override
  void initState() {
    super.initState();
    // 위젯이 처음 트리에 삽입될 때 한번만 호출
    print('initState() 실행 — 위젯 최초 생성 시 1회 호출');
  }

  // 2️⃣ initState 직후 호출 (context나 상위 위젯 데이터 접근 가능)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies() 실행 — 상위 의존성이 변경될 때 호출');
  }

  // 3️⃣ 위젯이 화면에 그려질 때마다 실행 (가장 많이 호출됨)
  @override
  Widget build(BuildContext context) {
    print('build() 실행 — 화면을 다시 그림');
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(10),
      color: Colors.blue,
      child: Text(
        'ChildWidget count : ${widget.count}', // 부모의 count 값 사용
        style: const TextStyle(fontSize: 26, color: Colors.white),
      ),
    );
  }

  // 4️⃣ 부모에서 전달받은 값이 바뀌면 실행됨 (ex. count 변경) 잘 안쓰임
  // 부모 위젯이 새 데이터와 함께 위젯을 rebuild 할 때 호출
  @override
  void didUpdateWidget(covariant ChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget() 실행 old = ${oldWidget.count}, new=${widget.count} — 부모의 속성이 변경되면 호출됨');
  }

  // 5️⃣ 위젯이 트리에서 제거될 때 실행됨
  // 해당 위젯이 위젯 트리에서 제거 될 때 호출
  @override
  void dispose() {
    super.dispose();
    print('dispose() 실행 — 위젯 제거 시 호출');
  }
}
