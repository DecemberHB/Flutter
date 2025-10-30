// 홈 인덱스 선택 화면

import 'package:flutter/material.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<StatefulWidget> createState() => _CartTabTabState();
  
}

class _CartTabTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈'),),
      body: Column(
        children: [
          Text('장바구니 메인')
        ],
      ),
    );
  }
  
}