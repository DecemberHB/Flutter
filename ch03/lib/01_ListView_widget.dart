/*
* 날짜 : 2025/10/27
* 이름 : 박효빈
* 내용 : ListView 위젯 실습하기
*
* */

import 'package:flutter/material.dart';

void main(){
  // ListView 기본
  //runApp(ListViewTest1());

  // ListView.builder 실습
  //runApp(ListViewTest2());

  // ListView
  runApp(ListViewTest3());
}

class ListViewTest1 extends StatelessWidget{
  const ListViewTest1({super.key});

  @override
  Widget build(BuildContext context) { // 화면그리는거

  return MaterialApp( // 여기서 화면 그리는거
    home: Scaffold( // 앱 골격
      appBar: AppBar(title: Text('01.ListView 위젯 실습'),),
      body: ListView(
        children: [
          for(int i=1; i<=5; i++) // {} << 중괄호 안씀
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  border: Border.all(
                      width: 1,
                      color: Colors.black
                  )
              ),
              child: Text('${i}번째 항목'), // 이전과 달리 const < 빠짐
            ),

          // ListTile은 리스트 아이템 항목을 구성 하는 위젯
          ListTile(
            leading: const Icon(Icons.sunny), // 아이콘/ 사진
            title: const Text('ListTile 제목'),
            subtitle: const Text('ListTiel 내용'),
            trailing: const Icon(Icons.menu),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'),
            ), // 아이콘/ 사진
            title: const Text('ListTile 제목'),
            subtitle: const Text('ListTiel 내용'),
            trailing: const Icon(Icons.more_vert),
            onTap: (){
              print('클릭!');
            },
          ),
          
        ],
      ),
    ),
  );
  }
}

class ListViewTest2 extends StatelessWidget{
  const ListViewTest2({super.key});

  @override
  Widget build(BuildContext context) { // 화면그리는거

    // 항목 추가
    List<String> personList = ['김유신','김춘추','장보고','강감찬','이순신','정약용','안중근','유관순','안창호','김구'];


    return MaterialApp( // 여기서 화면 그리는거
      home: Scaffold( // 앱 골격
        appBar: AppBar(title: Text('02.ListView.builder 위젯 실습'),),
        /*
         ListView.builder는 아이템 갯 수가 많거나 동적으로 위젯을 생성해서 메모리 자원을 효율적으로 사용함
         Lazy Loading으로 성능 극대화 ( 필요할 때 마다 로딩 )
        */
        body: ListView.builder( // ListView << 해당 방법을 많이 사용함

          // itemCount, Buileder로 화면 구성
          itemCount: personList.length, // 목록에 출력할 총 아이템 갯수
          itemBuilder: (context, index){ // 인덱스를 기반으로 각 아이템 위젯 생성
            return      Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  border: Border.all(
                      width: 1,
                      color: Colors.black
                  )
              ),
              child: Text(personList[index]), // 이전과 달리 const < 빠짐
            );
          },
        ),
      ),
    );
  }
}

class ListViewTest3 extends StatelessWidget{
  const ListViewTest3({super.key});

  @override
  Widget build(BuildContext context) { // 화면그리는거

    // 항목 추가
    List<User> userList = [
      User('a101', '김유신', '1990-09-01', 'https://picsum.photos/id/237/200/300', 23),
      User('a102', '김춘추', '1991-09-01', 'https://picsum.photos/id/238/200/300', 21),
      User('a103', '장보고', '1992-09-01', 'https://picsum.photos/id/239/200/300', 33),
      User('a104', '강감찬', '1993-09-01', 'https://picsum.photos/id/240/200/300', 43),
      User('a105', '이순신', '1994-09-01', 'https://picsum.photos/id/241/200/300', 53),

    ];


    return MaterialApp( // 여기서 화면 그리는거
      home: Scaffold( // 앱 골격
        appBar: AppBar(title: Text('03.ListView.separated 위젯 실습'),),
        /*
         ListView.builder는 아이템 갯 수가 많거나 동적으로 위젯을 생성해서 메모리 자원을 효율적으로 사용함
         Lazy Loading으로 성능 극대화 ( 필요할 때 마다 로딩 )
        */
        body: ListView.separated( // separated는 ListView.builder에서 목록 구분선을 커스텀 할 수 있는 위젯

          itemCount: userList.length, // 목록에 출력할 총 아이템 갯수
          itemBuilder: (context, index){ // 인덱스를 기반으로 각 아이템 위젯 생성
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(userList[index].avatar),
              ), // 아이콘/ 사진
              title:  Text('${userList[index].name}(${userList[index].userid})'),
              subtitle:  Text('${userList[index].age}세,${userList[index].birth}'),
              trailing:  Icon(Icons.more_vert),
              onTap: (){
                print('클릭!');
              },
            );
          },
          separatorBuilder: (BuildContext context, int index){
            return Divider(height: 1, color: Colors.black,);
          },
        ),
      ),
    );
  }
}

class User { // Spring의 DTO <-> Flutter의 model ( Spring의 DTO 역할 )
  String userid;
  String name;
  String birth;
  int age;
  String avatar; // 사용자 섬네일 이미지

  // 초기화
  User(this.userid, this.name, this.birth, this.avatar, this.age);
}