import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/providers/auth_provider.dart';
import 'package:kmarket_shopping_app/screens/member/login_screen.dart';
import 'package:provider/provider.dart';

class MyTab extends StatefulWidget {
  const MyTab({super.key});

  @override
  State<StatefulWidget> createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {

  // 로그인 화면 디자인 함수
  // 비로그인 my page 화면
  Widget _buildLogin() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('로그인이 필요합니다.'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('로그인 이동'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedIn() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =====================
            // 상단 사용자 영역
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '유저',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: const [
                    Text('메인페이지'),
                    SizedBox(width: 12),
                    Text('알림'),
                    SizedBox(width: 12),
                    Text('로그아웃'),
                  ],
                )
              ],
            ),

            const SizedBox(height: 16),

            // =====================
            // 배너 광고
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: const [
                  Text(
                    '배너광고',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('• MAP 이벤트 안내'),
                  Text('• MAP으로 이동'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =====================
            // 내 카드 타이틀
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '내 카드 >',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text('내 카드 관리'),
              ],
            ),

            const SizedBox(height: 12),

            // =====================
            // 카드 정보 카드
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('카드명 | 카드번호 뒷자리'),
                        SizedBox(height: 8),
                        Text(
                          'N월 이용금액',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '000,000원',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Text('카드 이미지'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =====================
            // 받은 혜택
            const Text(
              '받은 혜택',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            _buildBenefitBar('교통', 0.7, '000,000원'),
            _buildBenefitBar('외식', 0.5, '000,000원'),
            _buildBenefitBar('여가', 0.3, '000,000원'),

            const SizedBox(height: 20),

            // =====================
            // 마이 화면 편집 버튼
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('마이 화면 편집'),
              ),
            ),
          ],
        ),
      ),
    );
  }


    Widget _buildInfoTile(String title, String value) {
      return ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(value),
        onTap: () {
          // 해당 내역 화면으로 이동 로직
        },
      );
    }
  Widget _buildBenefitBar(String title, double value, String amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(amount),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);
    bool isLoggedin = authProvider.isLoggedIn;
    return Scaffold(
      appBar: AppBar(title: const Text('마이페이지'),),
      body: isLoggedin ? _buildLoggedIn() : _buildLogin()
    );
  }
}