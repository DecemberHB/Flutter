/*
*   날짜 : 2025/10/29
*   이름 : 박효빈
*   내용 : Flutter JSON 처리 실습
*
*/


import 'dart:convert';

import 'package:flutter/material.dart';

// 속성 초기화 (밑의 JSON)선언

class Todo {
  int id;
  String title;
  bool complete;

  // 기본 생성자, 이름이 있는 매개변수
  Todo({required this.id, required this.title, required this.complete});

  // factory 생성자 , JSON 객체를 Todo 객체로 변환 할때 사용함
  // JSON 객체 -> Todo 객체
  factory Todo.fromJson(Map<String, dynamic> json){ // value 값이 int, String, bool 등 다양하니깐 dynamic 사용

    // 기본생성자를 호출
    return Todo(
      id: json['id'],
      title: json['title'],
      complete: json['complete'],
    );
  }

  // Todo 객체를 JSON 변환하는 함수  Todo -> JSON 변환
  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "title" : title,
      "complete" : complete,
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, complete: $complete}';
  }


}

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('03.Flutter JSON 처리 실습'),
        ),
        body: JsonScreen(),
      ),
    );
  }
}

class JsonScreen extends StatefulWidget {
  const JsonScreen({super.key});

  @override
  State<StatefulWidget> createState() => _JsonScreenState();
}

class _JsonScreenState extends State<JsonScreen> {

  // 함수 및 속성 선언 시작

  // JSON 문자열
  final String jsonString = '''
  {
    "id" : 1,
    "title" : "Flutter JSON 실습",
    "complete": false
  }
  ''';

  Map<String, dynamic>? jsonData; // null이되면 안되니깐 ? 붙혀서 방지
  Todo? todo;
  String? encodedJson;


  // JSON 문자열 -> Todo 객체 변환(Decoding)
  void decodeingTodo(){
    // 처리 + 화면갱신
    setState(() {
      Map<String, dynamic> todoMap = jsonDecode(jsonString); //jsonDecode = Flutter에서 제공
      todo = Todo.fromJson(todoMap);
    });

  }
  // Todo 객체 -> JSON 문자열 변환(encoding)
  void encodingTodo(){

        setState(() {

          encodedJson = jsonEncode(todo?.toJson());
        });

  }

  // JSON 문자열 -> Map 객체 변환(Parsing)
  void parsingTodo(){

    setState(() {
      jsonData = jsonDecode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text('Todo :${jsonData.toString()}'),
            ElevatedButton(onPressed: parsingTodo, child: const Text('JSON Parsing')),
            const SizedBox(height: 20,),

            Text('Todo : ${todo.toString()} '),
            ElevatedButton(onPressed: decodeingTodo, child: const Text('JSON Decode')),
            const SizedBox(height: 20,),

            Text('Todo : $encodedJson'),
            ElevatedButton(onPressed: encodingTodo, child: const Text('JSON Encode')),
            const SizedBox(height: 20,),
          ],
        ),
    );
  }

}