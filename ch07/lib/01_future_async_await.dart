/*
*   날짜 : 2025/10/29
*   이름 : 박효빈
*   내용 : Flutter 비동기 처리 실습
*
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
        appBar: AppBar(title: const Text('01.Flutter 비동기 처리 실습'),
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

  // 상태 선언
  String result = '결과 대기중 ...';
  bool isLoading = false; // 초기화

  // 비동기 처리 함수
  Future<String> fetchData(){
    return Future.delayed(const Duration(seconds: 3), (){
      return '서버에서 불러온 데이터 Server Data ---....';
    });
  }
  // void loadData
  void loadData() {
    // 비동기 처리 1 : #데일리

    setState(() {
      result ='로딩 중 ... 1';
    }); // 처음 로딩 중 ...

    fetchData() // 3초 뒤에 .then 실행 data => return '서버에서 불러온 데이터 Server Data ---....';

        .then((data){
      setState(() {
        result = data;
      });
    })
        .catchError((err){
          setState(() {
            result = err;
          });
    })
        .whenComplete((){
          setState(() {
            print('작업완료');
          });

          setState(() {
            result = '로딩중 ...2';
          });
    });
  }


  // 비동기 처리 2 : 카운트
  int count = 0;
  bool isCounting = false;

  Future<int> startCounting() async { // 비동기로 처리 ?? async도 붙혀야함
    setState(() {
      isCounting = true;
    });

    for(int i=1; i<=10; i++){

      await Future.delayed(const Duration(seconds: 1)); //1초 멈추고 진행 얘도 비동기 처리라서 await 해줘야함

      setState(() {
        count = i; // 상태값 업데이트 및 화면갱신 진행
      });

    }

    //for문 끝나고는 다시 카운팅값 false로
    setState(() {
      isCounting = false;
    });

    return count; // 숫자라서 int ?? 그러나 비동기처리라서 Future<int>로 반환
  }

  void handleCount() async {
    int result = await startCounting(); // 끝날떄까지 대기 언제까지? i=10이 될떄까지 result = 10;

    setState(() {
      count = result +1; // 최종 결과값 : 11
    });
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(result, style: TextStyle(fontSize: 16),), // 결과값 출력 ..
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: loadData, child: const Text('데이터불러오기')),
            const SizedBox(height: 10,),
            Text('결과출력 : $count'),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              handleCount();
            }, child: const Text('카운트 시작')),
          ],
        ),
    );
  }

}