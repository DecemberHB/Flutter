// 로그인 화면 구현
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/providers/auth_provider.dart';
import 'package:kmarket_shopping_app/screens/member/terms_screen.dart';
import 'package:kmarket_shopping_app/services/member_service.dart';
import 'package:kmarket_shopping_app/services/token_storage_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
  }



class _LoginScreenState extends State<LoginScreen> {

  // 입력 정보 저장할 컨트롤러 생성
  final _idController = TextEditingController();
  final _pwController = TextEditingController();

  // 로그인 서비스 불러오기
  final service = MemberService();

  // 토큰 스토리지 서비스 선언
  final tokenStorageService = TokenStorageService();
  // 로그인 함수
  void _procLogin () async{

    final usid = _idController.text;
    final pass = _pwController.text;

    if(usid.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디, 비번 입력하세요'))
      );

      return;
    }

    //https://chhak0503.notion.site/BNK-DT-2-2297537e85eb800481d4c44f117f255b
    
    // 서비스 호출(실 서비스 구현) 비동기 함수라 await , async  + 예외처리
    try {
      Map<String, dynamic> jsonData = await service.login(usid, pass);
      // 액세스 토큰 가져오기 (중요())
      String accessToken = jsonData['accessToken'];
      log('accessToken: $accessToken');

      if(accessToken.isNotEmpty) {
        // 토큰 저장 (SharedPreference or SecureStorage) * Provider로 저장
        // tokenStorageService.saveToken(accessToken); -> 프로바이더로 저장해야됨
        
        context.read<AuthProvider>().login(accessToken); // 이거도 가능
        //로그인 화면 닫기
        Navigator.of(context).pop();

        // 두 곳 중 하나 요즘은 SecureStrage 애용(보안 ) << 의존성 추가해야함
        // flutter_secure_storagecopy "flutter_secure_storage: ^9.2.4" to clipboard

      }
    } catch(err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('에러 발생 : $err'))
      );
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('로그인'),),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png'),
              const SizedBox(height: 20,),
              const Text('쇼핑몰 로그인', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),

              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _idController, // ✅ 컨트롤러는 TextField의 속성
                decoration: InputDecoration(
                  labelText: '아이디 입력',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: _pwController,
                  obscureText: true,
                  decoration: InputDecoration(
                  labelText: '비밀번호 입력',
                  border: OutlineInputBorder()
              ),),
              // Login submit >>>>
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: _procLogin,
                    child: const Text('로그인', style: TextStyle(color: Colors.black, fontSize: 20),)
                ),
              ),
              const SizedBox(height: 10,),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => TermsScreen()),
                    );
                  },
                  child: const Text('회원가입', style: TextStyle(color: Colors.black),)
              ),
            ],
          ),
          
        ),
      ),
    );
  }

}