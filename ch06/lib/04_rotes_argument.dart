/*
  날짜 : 2025/10/28
  이름 : 박효빈
  내용 : 6장 Navigation Routes 실습 (데이터 전달 + 리턴)
*/

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// 1️⃣ 사용자 정보를 저장할 데이터 클래스 (User)
// ---------------------------------------------------------------------
class User {
  String userid; // 아이디
  String name;   // 이름
  int age;       // 나이

  // 생성자 (User를 만들 때 userid, name, age 모두 필요)
  User({required this.userid, required this.name, required this.age});

  // 객체 정보를 문자열로 바꿔주는 함수 (toString)
  @override
  String toString() {
    return 'User{userid: $userid, name: $name, age: $age}';
  }
}

// ---------------------------------------------------------------------
// 2️⃣ 앱 시작 부분
// ---------------------------------------------------------------------
void main() {
  runApp(const MyApp()); // 앱 실행 시 MyApp부터 시작
}

// ---------------------------------------------------------------------
// 3️⃣ MyApp: 앱 전체를 감싸는 최상위 위젯
// ---------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 앱이 처음 시작할 때 보여질 첫 번째 화면의 경로 이름
      initialRoute: '/first',

      // 라우트(경로) 등록 → 경로 이름으로 화면을 찾아감
      routes: {
        '/first': (context) => FirstScreen(),      // 첫 화면
        '/second': (context) => const SecondScreen(), // 두 번째 화면
      },
    );
  }
}

// ---------------------------------------------------------------------
// 4️⃣ FirstScreen: 사용자 입력 + SecondScreen으로 이동하는 화면
// ---------------------------------------------------------------------
class FirstScreen extends StatefulWidget {
  // 정의
  @override
  State<StatefulWidget> createState() => _FirstScreenState();
}

// 상태가 변할 수 있는 위젯 → 입력값 변경 시 setState()로 화면 갱신
// 구현
class _FirstScreenState extends State<FirstScreen> {
  // 텍스트 입력창을 관리하는 컨트롤러 3개
  final TextEditingController _useridController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // SecondScreen에서 다시 전달받은 사용자 정보 저장용
  String savedUser = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('04. Routes Argument 실습')),
      body: Column(
        children: [
          const Text('First Screen', style: TextStyle(fontSize: 36)),

          // 아이디 입력칸
          TextField(
            controller: _useridController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '아이디',
            ),
          ),
          const SizedBox(height: 10),

          // 이름 입력칸
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '이름',
            ),
          ),
          const SizedBox(height: 10),

          // 나이 입력칸
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '나이',
            ),
          ),
          const SizedBox(height: 10),

          // SecondScreen에서 되돌아온 데이터 표시
          Text('savedUser : $savedUser'),

          // ---------------------------------------------------------------
          // SecondScreen으로 이동 버튼
          // ---------------------------------------------------------------
          ElevatedButton(
            onPressed: () async {
              // 입력값을 가져옴
              String userid = _useridController.text;
              String name = _nameController.text;
              int age = int.tryParse(_ageController.text) ?? 0;

              // 입력값으로 User 객체 생성
              final user = User(userid: userid, name: name, age: age);

              // Navigator.pushNamed() :
              //  → '/second' 경로로 이동
              //  → arguments로 user 데이터를 함께 보냄
              //  → await : SecondScreen에서 pop할 때까지 기다림
              final returnedUser = await Navigator.pushNamed(
                context,
                '/second',
                arguments: {'user': user},
              );

              // SecondScreen에서 pop(context, receivedUser) 로 넘긴 데이터를 받음
              // setState()를 써서 화면에 표시되도록 갱신
              setState(() {
                savedUser = returnedUser.toString();
              });
            },
            child: const Text('Second Screen 이동'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 5️⃣ SecondScreen: 데이터를 전달받아 표시하고, 다시 돌려보내는 화면
// ---------------------------------------------------------------------
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ---------------------------------------------------------------
    // (1) Navigator로부터 전달받은 arguments 데이터를 꺼냄
    // ---------------------------------------------------------------
    // ModalRoute.of(context) → 현재 페이지의 라우트 정보 가져오기
    // settings.arguments → 전달된 arguments 접근
    final Map<String, dynamic> arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // arguments 안에 들어 있는 'user' 키의 값을 꺼내서 User 타입으로 캐스팅
    final User receivedUser = arguments['user'] as User;

    // ---------------------------------------------------------------
    // (2) 화면 UI 구성
    // ---------------------------------------------------------------
    return Scaffold(
      appBar: AppBar(title: const Text('04. Routes Arguments 실습')),
      body: Column(
        children: [
          const Text('Second Screen', style: TextStyle(fontSize: 36)),

          // FirstScreen에서 전달받은 User 데이터 출력
          Text(
            '아이디 : ${receivedUser.userid}, 이름 : ${receivedUser.name}, 나이 : ${receivedUser.age}',
            style: const TextStyle(fontSize: 24),
          ),

          const SizedBox(height: 10),

          // -----------------------------------------------------------
          // (3) FirstScreen으로 돌아가기 버튼
          // -----------------------------------------------------------
          ElevatedButton(
            onPressed: () {
              // Navigator.pop(context, 데이터)
              //  → 현재 화면을 닫고 (뒤로가기)
              //  → () 안의 데이터를 이전 화면으로 전달
              Navigator.pop(context, receivedUser);
            },
            child: const Text('First Screen 이동'),
          ),
        ],
      ),
    );
  }
}
