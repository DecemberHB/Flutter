/*
  날짜 : 2025/10/28
  이름 : 박효빈
  내용 : 6장 Navigation Argument 데이터 전달 실습
*/

import 'package:flutter/material.dart'; // 기본 플러터 UI 패키지

// 앱 시작 함수 (main 함수가 제일 먼저 실행됨)
void main() {
  runApp(const MyApp()); // MyApp 위젯을 화면에 띄움
}

// 앱 전체를 감싸는 기본 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // const 생성자 (불변 객체로 최적화)

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // 앱의 첫 화면을 FirstScreen으로 지정
      home: FirstScreen(),
    );
  }
}

// 첫 번째 화면 (사용자가 이름과 나이를 입력함)
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FirstScreenState();
}

// StatefulWidget은 화면에 “변하는 값”을 가질 수 있음
class _FirstScreenState extends State<FirstScreen> {
  // TextField 입력값을 관리하는 컨트롤러 2개 생성
  final TextEditingController _nameController = TextEditingController(); // 이름 입력용
  final TextEditingController _ageController = TextEditingController();  // 나이 입력용

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 화면의 기본 뼈대 (AppBar + Body)
      appBar: AppBar(title: const Text('02. 네비게이션 Routes 기본 실습')),
      body: Padding( // 화면 여백 설정
        padding: const EdgeInsets.all(16.0),
        child: Column( // 세로 방향으로 위젯 배치
          children: [
            // 이름 입력창
            TextField(
              controller: _nameController, // 입력된 값을 이 컨트롤러로 관리
              decoration: const InputDecoration(
                border: OutlineInputBorder(), // 테두리 표시
                labelText: '이름 입력', // 입력창 위에 표시되는 라벨
              ),
            ),

            const SizedBox(height: 10), // 위젯 간 간격 주기

            // 나이 입력창
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number, // 숫자 전용 키보드 표시
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '나이 입력',
              ),
            ),

            const SizedBox(height: 20),

            // 단순 안내 텍스트
            const Text('First Screen', style: TextStyle(fontSize: 36)),

            const SizedBox(height: 10),

            // 버튼을 누르면 다음 화면(SecondScreen)으로 이동
            ElevatedButton(
              onPressed: () {
                // 사용자가 입력한 값을 가져오기
                final name = _nameController.text; // 문자열로 이름
                final age = int.tryParse(_ageController.text) ?? 0; // 문자열 → 숫자 변환 (입력 없으면 0)

                // SecondScreen으로 이동하면서 데이터를 함께 전달
                Navigator.push(
                  context, // 현재 화면의 위치 정보
                  MaterialPageRoute( // 페이지 이동 방식 지정
                    builder: (context) => SecondScreen( // SecondScreen 으로 데이터 전달
                      name: name, // 입력받은 이름 전달
                      age: age,   // 입력받은 나이 전달
                    ),
                  ),
                );
              },
              child: const Text('Second Screen 이동'), // 버튼에 표시될 글자
            ),
          ],
        ),
      ),
    );
  }
}

// 두 번째 화면 (전달받은 이름과 나이를 표시함)
class SecondScreen extends StatelessWidget {
  // 전달받은 데이터를 담을 변수
  final String name; // 이름
  final int age;     // 나이

  // 생성자에서 필수로 받아야 함 (required)
  const SecondScreen({super.key, required this.name, required this.age});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('02. 네비게이션 Routes 기본 실습')),
      body: Column(
        children: [
          // 화면 제목
          const Text('Second Screen', style: TextStyle(fontSize: 36)),

          const SizedBox(height: 10),

          // 첫 번째 화면에서 전달받은 데이터 표시
          Text('이름 : $name, 나이 : $age'),

          const SizedBox(height: 10),

          // 뒤로가기 버튼
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // 이전 화면으로 돌아감
            },
            child: const Text('First Screen 이동'),
          ),
        ],
      ),
    );
  }
}
