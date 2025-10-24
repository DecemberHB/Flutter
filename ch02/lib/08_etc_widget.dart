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
      home: const MyHomePage(title: '08_etc_Widget(기타 위젯들) 실습'),
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
      body: Column( // 앱화면
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text 왼쪽 정렬
          const Text(
            'Text Left !!!',
            style: TextStyle(fontSize: 26),
          ),

          // Center (가운데 정렬 위젯)
          const Center(
            child: Text(
              'Text Center!!!',
              style: TextStyle(fontSize: 25),
            ),
          ),

          // Expanded
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: 50,
                  height: 100,
                  color: Colors.red,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: 50,
                  height: 100,
                  color: Colors.green,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: 50,
                  height: 100,
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          // Card : 그림자가 있는 둥근 사각형 박스
          Card(
            elevation: 3, // 그림자 크기
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(12),
            child: Container(
              width: 200,
              height: 100,
              child: const Column(
                children: [
                  Text('제목'),
                  Text('내용'),
                ],
              ),
            ),
          ),

          // Padding
          const Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text('Padding 10'),
              ],
            ),
          ),

          // Icon : 웹 아이콘 출력 위젯
          Row(
            children: [
              Icon(
                Icons.home,
                size: 60,
              ),
              Icon(
                Icons.favorite,
                size: 60,
                color: Colors.black,
              ),
              Icon(
                Icons.handshake,
                size: 60,
                color: Colors.black,
              ),
            ],
          ),

          // Spacer : d위젯과 위젯 사이의 빈공간 배치
          Row(
            children: [
            Icon(
            Icons.home,
            size: 60,
          ),
          Spacer(),
          Icon(
            Icons.favorite,
            size: 60,
            color: Colors.black,
          ),
              Spacer(
                flex: 2,
              ),
          Icon(
            Icons.handshake,
            size: 60,
            color: Colors.black,
          ),
        ],
          ),

          // SizedBox : 위젯과 위젯 사이 여백 줄 때
          SizedBox(
            width: 300,
            height: 100,
            child: Container(
              color: Colors.blue,
            ),
          ),


          // SingleChildScrollView
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 400,
                  height: 200,
                  color: Colors.red,
                  child: Text('Box1'),
                ),
                Container(
                  width: 400,
                  height: 200,
                  color: Colors.green,
                  child: Text('Box2'),
                ),
                Container(
                  width: 400,
                  height: 200,
                  color: Colors.black,
                  child: Text('Box3'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
