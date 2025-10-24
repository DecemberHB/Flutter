import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { // 화면 그리는 함수
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: '09_button_gesture_widget 실습'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 실제 화면
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.question_answer),
        onPressed: (){
          print('플러팅 버튼 클릭');
        },
      ),
      body: Column( // 앱화면
        children: [
          // 텍스트 버튼
          TextButton(
              onPressed: (){
                print('텍스트버튼 클릭');
                },
              child: const Text('텍스트버튼') // 메모리효율성을 위해 const 선언
          ),

          // 아웃라인 버튼
          OutlinedButton(
              onPressed: (){
                print('아웃라인 버튼 클릭');
              },
              child: const Text('아웃라인버튼')
          ),

          // 엘리베이트 버튼 (입체버튼) -잘 쓰임
          ElevatedButton(
              onPressed: (){
                print('엘리베이트 버튼 클릭');
              },
              child: const Text('엘리베이트 버튼')
          ),

          // 아이콘 버튼
          IconButton(
              onPressed: (){
                print('아이콘 버튼 클릭');
              },
              icon: Icon(Icons.plus_one)
          ),

          // 제스처 감지 위젯
          GestureDetector( //t 사용자
            onTap: (){
              print('탭 제스쳐');
            },
            onDoubleTap: (){
              print('더블 탭 제스쳐');
            },
            onLongPress: (){
              print('롱프레스 제스쳐');
            },
            child: Container(
              width: 400,
              height: 200,
              color: Colors.blue,
              child: Text('제스쳐 감지 박스'),
            ),

          )
        ],
      ),
    );
  }
}
