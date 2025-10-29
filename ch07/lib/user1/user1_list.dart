
import 'package:ch07/user1/user1.dart';
import 'package:ch07/user1/user1_register.dart';
import 'package:ch07/user1/user1_service.dart';
import 'package:flutter/material.dart';

class User1List extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _User1ListState();
}

class _User1ListState extends State<User1List> {

  final service = User1Service();

  // late : 초기화를 연기하고 선언
  late Future<List<User1>> futureUserList;

  @override
  void initState() {
    super.initState();

    // 목록 데이터 요청하기
    futureUserList = service.getUsers();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User1 목록'),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // 등록 이동
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => User1Register()
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: futureUserList,
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }else if(snapshot.hasError) {
              return Text('에러발생 : ${snapshot.error}');
            }

            final userList = snapshot.data!;

            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {

                  final user = userList[index];

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(user.name[0]),
                      ),
                      title: Text('${user.name}(${user.userid})'),
                      subtitle: Text('${user.age}세(${user.birth})'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit), color: Colors.blue,),
                          IconButton(onPressed: (){}, icon: Icon(Icons.delete), color: Colors.red,),
                        ],
                      ),

                    ),
                  );
                }
            );

          }
      ),
    );
  }

}