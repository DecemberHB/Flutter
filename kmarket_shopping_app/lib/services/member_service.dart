//맴버 서비스 구현

import 'dart:convert';

import 'package:kmarket_shopping_app/modals/member.dart';

// import 수동 입력
import 'package:http/http.dart' as http;




class MemberService {
  final String baseUrl = 'http://10.0.2.2:8080/ch09';

  // 사용자 로그인 구현 10.31
  Future<Map<String,dynamic>> login(String usid, String pass) async {

    // 비동기 처리

    try {
      final response = await http.post(Uri.parse('$baseUrl/user/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "usid": usid,
            "pass": pass,
          })
      );
      // 수신 처리
      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      }else{
        throw Exception(response.statusCode);
      }
    }catch(err){
      throw Exception('예외 발생: $err');
    }
  }

  Future<Map<String, dynamic>> register(Member member) async {
    try {
// Spring Post 주소로 보냄 (회원가입)
      final response = await http.post(
          Uri.parse('$baseUrl/user/register'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(member.toJson())
      );

      if(response.statusCode == 200){
        // savedUser 반환
        return jsonDecode(response.body);
        // 맨 위의 반환값 변경 MAP~
      }else {
        throw Exception('response.statusCode : ${response.statusCode}');

      }
    }catch (err){
      throw Exception('에러발생 : $err');
    }
  }
}