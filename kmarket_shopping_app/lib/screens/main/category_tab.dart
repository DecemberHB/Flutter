// 홈 인덱스 선택 화면

import 'package:flutter/material.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  State<StatefulWidget> createState() => _CategoryTabState();
  
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈'),),
      body: Column(
        children: [
          Text('카테고리 메인')
        ],
      ),
    );
  }
  
}