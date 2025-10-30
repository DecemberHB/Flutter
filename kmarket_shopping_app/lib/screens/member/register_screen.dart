// 로그인 화면 구현
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/modals/member.dart';
import 'package:kmarket_shopping_app/services/member_service.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
  }



class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>(); // 전송 버튼 누를때 해당 키로 유효성 검사 진행

  // 입력 필드 컨트롤러
  final _usidController = TextEditingController();
  final _pass1Controller = TextEditingController();
  final _pass2Controller = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  // 서비스생성(register.service)
  final _service = MemberService();

  // 상태 로딩
  bool _isLoading = false;


  // 폼 전송 함수 생성 (submit)
  void _submitForm() async {
    // 유효성 검사 체크
    if(!_formKey.currentState!.validate()){ // 유효성 검사가 (입력 필드)실패했을때 그냥 끝냄
      return;
    }

    // 입력 데이터 -> JSON DATA로
    final member = Member(
        usid: _usidController.text,
        pass: _pass1Controller.text,
        name: _nameController.text,
        email: _emailController.text,
        role : 'USER'
    );
    log('member: $member');

    //서비스 호출
    try {
      final savedUser = await _service.register(member);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('회원가입 완료  ! : $savedUser')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );


    }catch(err){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('에러 발생 ! : $err'))
,      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입'),),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          // 회원가입이므로 Form으로 변경
            child: Form(
              // 여기다 키 선언
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('기본 정보 입력'),
                  const SizedBox(height: 10,),
                  _buildInputField(
                      controller:_usidController,
                      title: '아이디 입력',
                      validator: (value) {
                        if(value == null || value.length < 4){
                          return '아이디는 4자 이상이여야 합니다.';
                        }
                        return null;

                      }
                  ),
                  const SizedBox(height: 10,),
                  _buildInputField(
                      controller:_pass1Controller,
                      title: '비밀번호 입력',
                      isPass: true,
                      validator: (value) {
                        if(value == null || value.length < 5){
                          return '비밀번호는 5자 이상이여야 합니다.';
                        }
                        return null;

                      }
                  ),
                  const SizedBox(height: 10,),
                  _buildInputField(
                      controller:_pass2Controller,
                      title: '비밀번호 확인',
                      isPass: true,
                      validator: (value) {
                        if(value == null || value.length < 5){
                          if(value != _pass1Controller.text){
                            return '비밀번호 불일치';
                          }
                          return '비밀번호는 5자 이상이여야 합니다.';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 10,),
                  _buildInputField(
                      controller:_nameController,
                      title: '이름 입력',
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return '이름은 필수 입력 항목 입니다.';
                        }
                        return null;

                      }
                  ),
                  const SizedBox(height: 10,),
                  _buildInputField(
                      controller:_emailController,
                      title: '이메일 입력(선택)',
                      validator: (value) {
                        return null;
                      }
                  ),

                  // 회원가입 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: (){
                          // 취소시 로그인 이동
                          Navigator.of(context).pop();
                        }, child: const Text('취소')),

                        const SizedBox(height: 10,),
                        ElevatedButton(onPressed: _submitForm,

                            child: const Text('가입'),

                        ),
                      ],
                    ),
                  )
                ],
              )
            )
        ),
      ),
    );
  }

  // 입력 필드 디자인 함수 여기서 컨트롤러 연결
  Widget _buildInputField({
    required TextEditingController controller, // 이름이 있는 매개변수 선언
    required String title,
    required String? Function(String?) validator,
    bool isPass = false
  }) {
    return TextFormField(
      controller: controller, // 매개 변수
      obscureText: isPass,
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 15)
      ),
      // 유효성 검사 진행하는 곳 ( validator )
      validator: validator,

    );
  }


  @override
  void dispose() { // 화면이 사라질 때  컨트롤러들을 해제하기 위함
    super.dispose();
    _usidController.dispose();
    _pass1Controller.dispose();
    _pass2Controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
  }

}