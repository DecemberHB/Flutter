/*
  날짜 : 2025/10/28
  이름 : 박효빈
  내용 : 5장 MultiProvider 상태관리 실습
*/

import 'dart:async';

import 'package:ch05/02_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 1.날짜시간 프로바이더
class ClockProvider extends ChangeNotifier {

  DateTime _dateTime = DateTime.now(); // 현재 시간 저장용 상태 변수
  DateTime get dateTime => _dateTime;  // 외부에서 읽을 때 getter 사용

  ClockProvider(){
    // 1초마다 주기적으로 실행 → 시간 갱신 후 UI에 알림
    Timer.periodic(const Duration(seconds: 1), (timer){
      _dateTime = DateTime.now();  // 현재 시각으로 갱신
      notifyListeners();           // 상태 변경 알림 (UI 자동 업데이트)
    });
  }
}

// 2.카운터 프로바이더
class CouterProvider extends ChangeNotifier {
  int _count = 0;           // 내부 상태값 (초기화)
  int get count => _count;  // 읽기 전용 getter

  void increment(){ //함수 선언 까지
    _count++;               // 카운트 증가
    notifyListeners();      // 변경된 상태 UI에 반영
  }
}

// 3.장바구니 프로바이더
class CartProvider extends ChangeNotifier {

  List<String> _products = []; // 상품 목록 리스트

  List<String> get products => _products;           // 상품 목록 getter
  int get productCount => _products.length;         // 상품 개수 반환

  void add(String product){
    _products.add(product); // 상품 추가
    notifyListeners();      // UI 갱신
  }

  void remove(String product){
    //_products.remove(product); // 상품 제거
    //notifyListeners();

    if (_products.length == 1) {
      _products.clear();
    } else {
      _products.remove(product);
      }
    notifyListeners();
  }

  void clear(){
    _products.clear();      // 장바구니 전체 비우기
    notifyListeners();
  }
}


void main(){
  runApp(

    // MultiProvider : 여러 상태(Provider) 한 번에 등록
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ClockProvider()),   // 시계
          ChangeNotifierProvider(create: (_) => CounterProvider()), // 카운터
          ChangeNotifierProvider(create: (_) => CartProvider()),    // 장바구니
        ],
        child: MyApp(),
      )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('03.MultiProvider 상태 관리 실습'),),
        body: ParentWidget(), // 실제 UI 위젯
      ),
    );
  }
}

class ParentWidget extends StatelessWidget {
  const ParentWidget({super.key});

  @override
  Widget build(BuildContext context) {

    // 프로바이더 구독
    final clockProvider = context.watch<ClockProvider>();           // 시계 상태 구독
    final counterProvider = Provider.of<CounterProvider>(context, listen: true); // 카운터 상태 구독
    final cartProvider = context.watch<CartProvider>();             // 장바구니 상태 구독

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('현재시간'),
        // 시계 상태 변경 시 실시간으로 시간 표시됨
        Text('${clockProvider.dateTime.hour}:${clockProvider.dateTime.minute}:${clockProvider.dateTime.second}'),

        const Divider(),

        const Text('카운트'),
        // 카운터 값 표시
        Text('CounterProvider count : ${counterProvider.count}'),
        ElevatedButton(
            onPressed: counterProvider.increment, // 버튼 클릭 → 증가 함수 호출
            child: const Text('증가')
        ),

        const Divider(),

        const Text('장바구니'),
        // 상품 갯수 및 목록 표시
        Text('장바구니 상품 갯수 : ${cartProvider.productCount}'),
        Text('장바구니 상품 목록 : ${cartProvider.products}'),
        Row(
          children: [
            ElevatedButton(
                onPressed: (){
                  // 상품 추가 (상품-번호 형태)
                  cartProvider.add('상품-${cartProvider.productCount + 1}');
                },
                child: const Text('상품 추가')
            ),
            ElevatedButton(
                onPressed: (){
                  // 상품 제거 (마지막 상품 제거)
                  cartProvider.remove('상품-${cartProvider.productCount - 1}');
                },
                child: const Text('상품 제거')
            ),
            ElevatedButton(
                onPressed: (){
                  // 전체 상품 삭제
                  cartProvider.clear();
                },
                child: const Text('전체 삭제')
            ),
          ],
        )
      ],
    );
  }
}
