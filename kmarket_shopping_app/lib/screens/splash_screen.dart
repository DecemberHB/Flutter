// 앱 시작 시 보이는 로고 화면 구현

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/screens/main/main_tab_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();

}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // 3초 후 메인 탭 이동
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_)=>const MainTabScreen())
      );
    });
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 전체 화면이라 appBar 필요 X
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ //로고, 로딩 화면
            Image.asset('images/logo.png'),
            const SizedBox(height: 50,),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

}