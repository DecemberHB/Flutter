import 'package:ch07/user1/user1.dart';
import 'package:ch07/user1/user1_service.dart';
import 'package:flutter/material.dart';

class User1Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _User1RegisterState();
}

// 글로벌 key 선언 및 , 컨트롤러 ( 데이터 저장 )
class _User1RegisterState extends State<User1Register> {
  final _formKey = GlobalKey<FormState>();
  final _useridController = TextEditingController();
  final _nameController = TextEditingController();
  final _birthController = TextEditingController();
  final _ageController = TextEditingController();

  // 서비스를 호출
  final service = User1Service();

  String message = ''; // 완료 시 메세지

  // 전송 함수 (submit)
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    User1 inputUser = User1(
      userid: _useridController.text,
      name: _nameController.text,
      birth: _birthController.text,
      // int 형은 따로 체크해줘야함
      age: int.tryParse(_ageController.text) ?? 0,
    );

    try {
      // 서비스로 넘겨서 Dart -> JSON 변환 (MAP)
      User1 savedUser = await service.postUser(inputUser); // await ~ << 부분이 service로 넘어감
      //print('savedUser : $savedUser 등록');
      await _showDialog('등록 성공', '사용자가 성공적으로 등록되었습니다.');
    } catch (err) {
      setState(() {
        message = '등록 실패, 에러 발생: $err';
      });
    }
  }

// ✅ 다이얼로그 표시 함수
  Future<void> _showDialog(String title, String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  // 생년월일 선택 함수
  Future<void> selectBirth() async {
    DateTime now = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (selectedDate != null) {
      setState(() {
        _birthController.text = selectedDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User1 등록'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                controller: _useridController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '아이디입력',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '이름입력',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _birthController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '생년월일 입력',
                ),
                readOnly: true,
                onTap: selectBirth,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '나이 입력',
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('취소'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('등록'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
