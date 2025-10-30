// 회원가입 모델 -> json data 변환

class Member {
  final String usid;
  final String pass;
  final String name;
  final String email;
  final String role;

  Member({required this.usid,
          required this.pass,
          required this.name,
          required this.email,
          this.role = 'USER', // role 기본값 설정 USER로
  });

  Map<String, dynamic> toJson() {

    return {
      "usid" : usid,
      "pass" : pass,
      "name" : name,
      "email" : email,
      "role" : role,
    };
  }
}