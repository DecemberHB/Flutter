

import 'dart:convert';
import 'dart:developer';

import 'package:ch07/user1/user1.dart';
// 직접입력
import 'package:http/http.dart' as http;
class User1Service {
  // Flutter 애물레이터 -> 외부 10.0.2.2 << 애뮬레이터 외부 아이피주소
  static const String baseurl ='http://10.0.2.2:8080/ch08'; // 전역 설정

  // 반환타입 List 형태로 변환
  Future<List<User1>> getUsers() async{
    // 유저 목록
    //예외 처리
    try{
      // log 남기기
      log('getUsers...1');
      // 유저 목록이 있는 주소 (JSON) LIST 형태로 변환
      // response -> 전체 Http 응답 패키지 response.body << 내가 필요한 정보
      final response = await http.get(Uri.parse('$baseurl/user1'));
      log('getUsers...2 : $response');

      // GET 성공 코드 200 / POST 성공 코드 201
      if(response.statusCode == 200) {

        //JSON 문자열을 Dart 리스트/맵으로 변환
       List<dynamic> jsonList = jsonDecode(response.body);
       log('getUsers...3 : $jsonList');



       // 각 JSON → User1 객체로 변환
       return jsonList.map((json)=> User1.fromJson(json)).toList();



      }else {
        throw Exception('예외 발생 : ${response.statusCode}');
      }

    }catch(err){
      throw Exception('예외발생 :$err');
    }
  }

  void getUser() {}

  // 유저 등록
  Future<User1> postUser(User1 user) async {
    try{


          // 값을 저장하는 주체 (response)
          final response = await http.post( // 사용자정보 등록

          // Datt 객체를 JSON으로 변환 (보낼 때)
          Uri.parse('$baseurl/user1'),
          headers: {'Content-Type':'application/json'},
          body: jsonEncode(user.toJson()) // Dart => JSON
      );

      if(response.statusCode == 201){
        return User1.fromJson(jsonDecode(response.body));
      }else {
        throw Exception('예외 발생 : ${response.statusCode}');
      }

    }catch (err){
      throw Exception('에러발생 : $err');
    }
  }

  void putUser() {}

  void deleteUser() {}
}