import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/providers/auth_provider.dart';
import 'package:kmarket_shopping_app/screens/main/main_tab_screen.dart';
import 'package:kmarket_shopping_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  //runApp(const MyApp());

  runApp(

    // 최초 앱을 실행 할 때 AuthProvider로 로그인 여부 체크
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
    child: MyApp(),
  )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// 메인 화면 구성 (앱 시작점)
  // 1. 로고 화면 로딩 ... (splash) 2~3초 : 버전 체크 진행
  // 2. 메인 화면 진입
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 바로 로딩 화면으로 이동 (앱 시작시)
      home: SplashScreen()
      //home: MainTabScreen()
    );
  }
}