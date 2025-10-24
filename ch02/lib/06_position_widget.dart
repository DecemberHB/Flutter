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
      home: const MyHomePage(title: '06_Position Widget 실습'),
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

          // Align : 특정 위치에 배치하기
          Container(
            width: double.infinity, // double.infinity 가로폭 100%
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(width: 1)
            ),
            //color: Colors.pink.withValues(alpha: 0.3),
            child: Align(
              alignment: Alignment.topLeft, // 방향
              child: Container(
                width: 100,
                height: 100,
                color: Colors.purple,
              ),
            ),
          ),

          // Fractionaloffset
          Container(
            width: double.infinity,// double.infinity 가로폭 100%
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(width: 1)
            ),
            //color: Colors.pink.withValues(alpha: 0.3),
            child: Align(
              alignment: FractionalOffset(0.5, 0.5), // 위치 값 설정
              child: Container(
                width: 100,
                height: 100,
                color: Colors.pink,
              ),
            ),
          ),

          // Stack : 위젯 겹쳐서 배치
          Stack(
            children: [
              Container(
                width: 150,
                height: 150,
                color:  Colors.amber,
              ),

              Container(
                width: 100,
                height: 100,
                color:  Colors.green,
              ),

              Container(
                width: 50,
                height: 50,
                color:  Colors.yellow,
              )
            ],
          ),

          // IndexedStack : 위젯을 겹쳐서 배치하고 인덱스 번호로 화면에 표시
          IndexedStack(
            index: 1, // 0 - 첫번째 텍스트 1 - 두번쨰 2 - 세번쨰 ..
            children: [
              Text('첫번쨰 텍스트',style: TextStyle(fontSize: 24),),
              Text('두번쨰 텍스트',style: TextStyle(fontSize: 24),),
              Text('세번쨰 텍스트',style: TextStyle(fontSize: 24),),

            ],
          ),

          // Positioned
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(width: 1)
            ),
            child: Stack(
              children: [
                Positioned( // Postioned 위젯은 반드시 Stack 위젯 자식으로 사용 (아니면 안됨)
                  // 방향속성을 통해 배치
                    left:10,
                    top: 10,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.black,
                    )),
                Positioned( // Postioned 위젯은 반드시 Stack 위젯 자식으로 사용 (아니면 안됨)
                  // 방향속성을 통해 배치
                    right:10,
                    bottom: 10,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                    )
                )
              ],
            ),
          )


        ],

      ),
    );
  }
}
