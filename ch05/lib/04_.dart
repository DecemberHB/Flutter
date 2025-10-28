/*
  날짜 : 2025/10/28
  이름 : 박효빈
  내용 : 5장 MultiProvider 상태관리 실습
*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/*
* Riverpod 의존성 설정
*  ^2.6.1 추가
* */

// 상태관리 모델 클래스 정의
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

// 상태 관리 모델 클래스 프로바이더 등록

final counterProvider = StateNotifierProvider<CounterNotifier, int>(
    (ref) => CounterNotifier()
);

final checkProvider = StateProvider((ref) => false);


void main(){
  runApp(const ProviderScope( // reverpod 프로바이더를 사용하기 위해  ProviderScope 처리
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('05.Revpod 상태 관리 실습'),),
        body: ParentWidget(),
      ),
    );
  }
}

//Riverpod 프로바이더 제공을 위한 ConsumerWidget 상속
class ParentWidget extends ConsumerWidget {
  const ParentWidget({super.key});

  @override
  //WidgetRef ref 추가 됨
  // ref : Riverpod 상태 모델 접근을 위한 인자값
  Widget build(BuildContext context, WidgetRef ref) {

    // 상태 구독
    final counter = ref.watch(counterProvider);
    final check = ref.watch(checkProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('reverpod counter : ${counter} '),
        Row(
          children: [
            ElevatedButton(
                onPressed: (){
                  ref.read(counterProvider.notifier).increment();
                },
                child: const Text('증가')
            ),
            ElevatedButton(
                onPressed: (){
                  ref.read(counterProvider.notifier).decrement();
                },
                child: const Text('감소')
            ),
          ],
        ),
        const Divider(),
        Text(check ? '동의하셨습니다' : '동의하셔야합니다.'),
        CheckboxListTile(
            title: const Text('동의'),
            value: check,
            onChanged: (value){
             ref.read(checkProvider.notifier).state = value ?? false;
            },
            )
      ],
    );
  }
}