/*
*
* 날짜 : 2025/10/28
* 이름 : 박효빈
* 내용 : 5장 Flutter Provider 상태 관리 실습
* */


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider 정의 (App 공용 상태 저장소) ChangeNotifier를 상속받아야함
class CounterProvider extends ChangeNotifier {
  // 상태 선언
  int _count = 0;

  // 상태값에 접근할 수 있는 Getter
  int get count => _count;

  // 상태 변경 함수

  void increment(){
    _count ++;
    // 상태 변경 알림     notifyListeners();( 호출 )
    notifyListeners(); // 상태 변경 알림
  }

  void decrement(){
    _count --;
    notifyListeners(); // 상태 변경 알림

  }
}

void main() {
  //MyApp() --> 요렇게 바꿔야함
  runApp(
    // provider 의존성 설정 : pubspec.yaml > provider : ^6.1.5+1 추가(provider는 pub.dev 에서 검색)
      ChangeNotifierProvider(create: (_) => CounterProvider(), // _ 매개변수는 context가 들어오지만 우리는 이 함수에서 사용 하지 않겠다는 선언
      child: MyApp() // MyApp 하위 위젯 트리에서 CounterProvider 접근,
      )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('02.Provider 상태 관리 실습'),),
        body: ParentWidget(),
      ),
    );
  }
}

class ParentWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ParentWidget();

}

class _ParentWidget extends State<ParentWidget> {




  @override
  Widget build(BuildContext context) {

    // provider 모델 접근하기
    final counterProvider = context.watch<CounterProvider>();

    return Column(
      children: [

        Text('Provider Count : ${counterProvider._count} ', style: Theme.of(context).textTheme.headlineMedium,
        ),

        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  counterProvider.increment();
                },
                child: const Text('증가')
            ),
            ElevatedButton(
                onPressed: (){
                  counterProvider.decrement();
                },
              child: const Text('감소')
             ),
          ],
        ),
        const Divider(),
        Child1Widget(),
        const Divider(),
        Child2Widget(),


      ],
    );
  }
}

class Child1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Provider 구독
    final counterProvider = Provider.of<CounterProvider>(context);

    return Column(
      children: [

        Text('Cild1 Provider Count : ${counterProvider.count}', style: Theme.of(context).textTheme.headlineMedium,
        ),

        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  counterProvider.increment();
                },
                child: const Text('증가')
            ),
            ElevatedButton(
                onPressed: (){

                  context.read<CounterProvider>().decrement();
                },
                child: const Text('감소')
            ),
          ],
        )
      ],
    );
  }
}

// Consumer Ver.
class Child2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context,notifier,child){
        return Column(
          children: [

            Text('Cild2 Provider Count : ${notifier._count}', style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      notifier.increment();

                    },
                    child: const Text('증가')
                ),
                ElevatedButton(
                    onPressed: (){
                      notifier.decrement();

                    },
                    child: const Text('감소')
                ),
              ],
            ),
            const Divider(),
            //Child3Widget()
          ],
        );
      }
    );

  }
}
