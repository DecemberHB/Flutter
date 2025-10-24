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
      home: const MyHomePage(title: '07_size Widget(크기 관련 위젯 실습'),
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



          // IntrinsicWidth
          Container(
            color: Colors.yellow,
            child: IntrinsicWidth( // 같은 배치 관계에서 너비가 가장 큰 위젯을 기준으로 너비 크기가 결정
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.red, width: 150, height: 150, child: Text('A'),),
                  Container(
                    color: Colors.blue, width: 300, height: 300, child: Text('B'),)
                ],
              ),
            ),
          ),
            // IntrinsicHeight
          Container(
            color: Colors.yellow,
            child: IntrinsicHeight( // 같은 배치 관계에서 너비가 가장 큰 위젯을 기준으로 너비 크기가 결정
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.red, width: 100, height: 150, child: Text('A'),),
                  Container(
                    color: Colors.blue, width: 200, height: 300, child: Text('B'),)
                ],
              ),
            ),
          )

        ],

      ),
    );
  }
}
