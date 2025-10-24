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
      home: const MyHomePage(title: '02_Images Widget 실습'),
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
          
          /*
          * 이미지 에셋 등록 설정 😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀
          *  - pubspce.yaml > flutter 하위에 assets 주석 제거 후 이미지 경로 입력
          * */
          
          Image.asset('images/flower1.jpg'),
          Image.asset(
              'images/flower2.jpg',
              width: 200,
              height: 200,

          ),
          Image.asset(
            'images/flower3.jpg',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
            repeat: ImageRepeat.noRepeat,
          ),
          Image.network(
              'https://picsum.photos/id/237/200/300',
              width: 100,
              height: 100,
          ), // 웹 이미지경로

          Image.network(
            'https://picsum.photos/id/238/200/300',
            width: 100,
            height: 100,
          )
        ],

      ),
    );
  }
}
