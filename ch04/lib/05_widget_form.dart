/*
* 날짜 : 2025/10/27
* 이름 : 박효빈
* 내용 : widget Form 실습
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // ✅ 앱 실행 시작점
}

// 앱의 전체 틀 (Scaffold + AppBar + Body)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('05. 폼 위젯 실습'), // 상단 제목
        ),
        body: FormPage(), // 실제 폼 내용 표시
      ),
    );
  }
}

// ===============================
// ✅ StatefulWidget : FormPage
// ===============================
// 상태 변화가 일어나는 폼 위젯
class FormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormPageState();
}

// ===============================
// ✅ State 클래스 : _FormPageState
// ===============================
// 실제 입력 및 로직을 담당하는 클래스
class _FormPageState extends State<FormPage> {

  // Form 상태를 추적하기 위한 고유 키 (폼 유효성 검사에 필요)
  final _formKey = GlobalKey<FormState>();

  // 입력 필드(TextFormField) 제어용 컨트롤러
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // 상태 변수들
  String _email = '';          // 이메일 입력 값 저장
  bool _isCheck = false;       // 체크박스 상태
  String _gender = 'M';        // 라디오 버튼 (기본값: 남자)
  bool _isSwitched = false;    // 스위치 상태
  String _submitResult = '';   // 제출 결과 메시지 출력용

  // ===============================
  // ▶ 폼 초기화 (취소 버튼 기능)
  // ===============================
  void _cancelForm() {
    _formKey.currentState!.reset(); // Form 전체 리셋
    _idController.clear();          // ID 입력창 초기화
    _pwController.clear();          // 비밀번호 입력창 초기화
    _nameController.clear();        // 이름 입력창 초기화

    // 상태값 초기화 후 다시 빌드
    _isCheck = false;
    _isSwitched = false;
    _gender = 'M';
    _email = '';
    _submitResult = '';

    setState(() {}); // 화면 갱신
  }

  // ===============================
  // ▶ 폼 제출 함수
  // ===============================
  void _submitForm() {
    // 유효성 검사 실행
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // onSaved() 실행

      // 각 필드 값 가져오기
      String idValue = _idController.text;
      String pwValue = _pwController.text;
      String nameValue = _nameController.text;

      // 결과 텍스트 업데이트
      setState(() {
        _submitResult = '입력 성공\n'
            '아이디 : $idValue\n'
            '비밀번호 : $pwValue\n'
            '이름 : $nameValue\n'
            '이메일 : $_email\n'
            '가입 동의 : $_isCheck\n'
            '성별 : $_gender\n'
            '푸시 알림 허용 : $_isSwitched';
      });
    } else {
      // 유효성 검사 실패 시
      setState(() {
        _submitResult = '입력 실패 ! 입력 항목을 재확인하세요.';
      });
    }
  }

  // ===============================
  // ▶ 화면 UI
  // ===============================
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // 폼 전체 스크롤 가능하게
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey, // 폼과 키 연결 (유효성 검사에 사용)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ID 입력 폼
            TextFormField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return '아이디를 입력해주세요';
                if (value.length < 4) return '아이디는 4자 이상입니다.';
                return null;
              },
            ),
            const SizedBox(height: 10),

            // 비밀번호 입력 폼
            TextFormField(
              controller: _pwController,
              obscureText: true, // 입력값 마스킹
              decoration: const InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return '비밀번호를 입력해주세요';
                if (value.length < 6) return '비밀번호는 6자 이상입니다.';
                return null;
              },
            ),
            const SizedBox(height: 10),

            // 이름 입력 폼
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return '이름을 입력해주세요';
                return null;
              },
            ),
            const SizedBox(height: 10),

            // 이메일 입력 폼 (컨트롤러 없이 onSaved로 처리)
            TextFormField(
              decoration: const InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) return '이메일을 입력해주세요';
                if (!value.contains('@')) return '유효한 이메일이 아닙니다.';
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            const SizedBox(height: 10),

            // 회원가입 동의 체크박스
            CheckboxListTile(
              title: const Text('회원가입에 동의합니다.'),
              value: _isCheck,
              onChanged: (value) {
                setState(() {
                  _isCheck = value ?? false; // null 방지
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 10),

            // 성별 선택 (라디오 버튼)
            const Text('성별 선택 :', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('남자'),
                    value: 'M',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('여자'),
                    value: 'F',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 푸시 알림 스위치
            Row(
              children: [
                const Text('푸시 알림 허용'),
                const Spacer(),
                Switch(
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 제출 & 취소 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _cancelForm, // 취소 버튼
                  child: const Text('취소'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _submitForm, // 제출 버튼
                  child: const Text('제출'),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 결과 텍스트 표시
            Text(
              _submitResult,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
