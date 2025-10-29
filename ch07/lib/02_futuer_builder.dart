/*
*   날짜 : 2025/10/29
*   이름 : 박효빈
*   내용 : Flutter 비동기 처리 실습
*
*
* futuer builder -> futter에서 제공됨
*/


import 'package:flutter/material.dart';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('02.FlutterBuilder  비동기 처리 실습'),
        ),
        body: FutureScreen(),
      ),
    );
  }
}

class FutureScreen extends StatefulWidget {
  const FutureScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FutureScreen();

}

class _FutureScreen extends State<FutureScreen> {

// Future 결과 상태 변수
  Future<String>? futureResult;

// 비동기 처리 함수
  Future<String> fetchData(){
    return Future.delayed(const Duration(seconds: 3), (){
      return '서버에서 불러온 데이터 Server Data ---....';
    });
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          // FutureBuilder : 비동기 작업의 진행 상태에 따라서 자동으로 UI를 갱신해주는 위젯

          // * 중요 *
          FutureBuilder(
              future: futureResult, // future 속성은 비동기 작업에 Future 결과 객체
              // 함수로 됨
              builder: (context, snapshot) { // snapshot은 현재 상태의 결과를 담고있는 결과 객체
                //3초 동안 진행되는 행동
                if(snapshot.connectionState == ConnectionState.waiting){
                  // 비동기처리가 진행 중인 경우..
                  return const CircularProgressIndicator(); // 돌아가는 로딩바

                }else if(snapshot.hasError){
                  //에러 발생시
                  return  Text('에러발생 : ${snapshot.error}');
                }else if(snapshot.hasData){
                  // 비동기 처리 결과 데이터
                  return  Text('결과 : ${snapshot.data}');
                }else {
                  return Text('데이터를 불러오세요...');
                }

              }
          ),
          // 버튼 생성
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {

            setState(() {
              futureResult = fetchData();
            });
          }, child: const Text('데이터불러오기'))

        ],
      ),
    );
  }

}