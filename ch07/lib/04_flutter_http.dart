/*
*   날짜 : 2025/10/29
*   이름 : 박효빈
*   내용 : Flutter JSON 처리 실습
*
*/

import 'dart:convert';
import 'package:flutter/material.dart';

// 직접 입력
import 'package:http/http.dart' as http; // 별칭 부여 http

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('04.Flutter http  처리 실습'),
        ),
        body: HttpScreen(),
      ),
    );
  }
}

class HttpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HttpScreenState();

}

class _HttpScreenState extends State<HttpScreen> {

  //API 서비스해 주는 사이트로 통신 jsonplaceholder
  
  // 요청함수 생성
  String result = '대기중...';


  //GET 처리
  Future<void> fetchGet() { // 반환값 비동기 처리인데 반환이 없다는 뜻 Future<void>
    // 1. 주소 생성
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
    //http 의존성 추가 필요함 pub.dev http: ^1.5.0
    return http.get(url, headers: {'Content-Type': 'application/json'})
        .then((response){ //data -> response
          if(response.statusCode == 200){ // 통신성공
            var jsonResult = jsonDecode(response.body); // 타입을 모를 때 var 알면 Map<key , values>
            setState(() {
              result = 'GET 요청 결과 : $jsonResult';
            });
          }else { // 그외

            setState(() {
              result = 'GET 결과 코드 : ${response.statusCode}';
            });

          }
    })
        .catchError((err){
          setState(() {
            result = '에러발생 : $err';
          });

    })
        .whenComplete((){
          print('통신 완료...'); // 굳이 안써도됨

    });
  }


  //https://jsonplaceholder.typicode.com/todos POSTMAN 통신 테스트
  //https://jsonplaceholder.typicode.com/posts 새로운 ID값 할당되는거 확인
  //POST 처리
  Future<void> fetchPost() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos');

    try {
      // 주소  + 전송 데이터
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "userId": 1001,
            "title": "Flutter HTTP POST TEST",
            "completed": false,
          })
      );

      if(response.statusCode == 201) { // 성공결과코드가 201이였음
        final returndData= jsonDecode(response.body);

        setState(() {
          result = 'POST 요청 성공 : $returndData';
        });

      }else {
        // 성공 이외
        setState(() {
          result = 'POST 결과 코드 : ${response.statusCode}';
        });

      }

    }catch (err) {
      result = 'POST 요청 에러 : $err';
    }
  }
  
  
  
  @override
  Widget build(BuildContext context) {
   return Padding(
       padding: EdgeInsets.all(10),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text('요청 결과 : $result'),
         Row(
           children: [
             ElevatedButton(onPressed: fetchGet,
                 child: const Text('GET 요청하기',)
             ),
             ElevatedButton(onPressed: fetchPost,
                 child: const Text('POST 요청하기',)
             ),
           ],
         )

       ],
     ),
   );
  }
}