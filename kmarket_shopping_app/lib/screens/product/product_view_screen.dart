/*
 * 파일명 : ProductViewScreen.dart
 * 설명   : 상품 상세페이지 화면 (상품 목록에서 상품 클릭 시 이동되는 페이지)
 *
 * 주요 기능 :
 * - 전달받은 Product 객체의 상세 정보 출력
 * - 원가 / 할인율 / 최종가 표시
 * - 상품 수량 선택 (Dropdown)
 * - 장바구니 담기 / 구매하기 버튼 제공
 * - 상품 상세 이미지 출력
 */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/config/app_config.dart';
import 'package:kmarket_shopping_app/modals/cart.dart';
import 'package:kmarket_shopping_app/modals/product.dart';
import 'package:kmarket_shopping_app/providers/auth_provider.dart';
import 'package:kmarket_shopping_app/screens/member/login_screen.dart';
import 'package:kmarket_shopping_app/services/cart_service.dart';
import 'package:provider/provider.dart';

class ProductViewScreen extends StatefulWidget {

  // 🔸 이전 화면(ProductListItem)에서 전달받은 상품 정보
  final Product product;

  const ProductViewScreen({super.key, required this.product});

  @override
  State<StatefulWidget> createState() => _ProductViewScreen();
}

class _ProductViewScreen extends State<ProductViewScreen> {

  // 🔹 수량 선택 상태 변수 (기본 1개)
  int _quantity = 1;
// 장바구니 서비스 호출
  final cartService = CartService();
  // 장바구니 추가 함수
  Future<void> _addCart() async{
    // pno => product 안에있음
    int pno = widget.product.pno;
    Map<String, dynamic> jsonData = await cartService.addCart(pno, _quantity);
    Cart savedCart = Cart.fromJson(jsonData);
    log('savedCart : $savedCart');

    // 추가 사용자 편의 UI 제공 if문
    if(jsonData.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: const Text('장바구니 등록 성공!!'),
                content: const Text('상품이 장바구니에 담겼습니다.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('확인')),
                ],
              ),

      );
    }
  }

  @override
  Widget build(BuildContext context) {

    // 로그인 상태가져오기 (Provider)
    final authProvider = Provider.of<AuthProvider>(context);
    final isLoggedIn = authProvider.isLoggedIn; // 로그인 상태 가져오기


    // 🔸 부모 위젯(ProductViewScreen)에서 전달받은 상품 참조
    final product = widget.product;

    // 🔸 최종 가격 계산 (할인율 적용)
    final finalPrice = product.price * (1 - product.discount / 100);

    return Scaffold(
      // 상단 앱바 : 상품명 표시
      appBar: AppBar(
        title: Text(product.productName),
      ),

      // 본문 : 스크롤 가능하도록 SingleChildScrollView 사용
      body: SingleChildScrollView(
        padding: EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 상품 대표 이미지
            ClipRect(
              child: Image.network(
                width: double.infinity,
                '${AppConfig.baseUrl}/product/image/${product.thumb240}',
                fit: BoxFit.fitWidth, // 가로폭 전체 채우고 이미지 비율 유지
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 상품 이름
            Text(
              product.productName,
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 10),

            // 🔹 원가 / 할인율 / 최종가 영역
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 왼쪽 : 원가, 할인율
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '원가 : ${product.price}원',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough, // 취소선
                      ),
                    ),
                    Text(
                      '할인율 : ${product.discount}%',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                // 오른쪽 : 최종가 (소수점 제거)
                Text(
                  '${finalPrice.toInt()}원',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Divider(), // 구분선

            // 🔹 수량 선택 드롭다운
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  '수량 선택 : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // DropdownButton : 1~10개 수량 선택
                DropdownButton(
                  value: _quantity,
                  items: List.generate(
                    10,
                        (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}개'),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _quantity = value!;
                    });
                  },
                ),
              ],
            ),

            // 🔹 장바구니 / 구매 버튼
            Row(
              children: [
                // 장바구니 버튼
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if(isLoggedIn) {
                        _addCart();
                      }else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('로그인이 필요합니다'),
                              content: const Text('장바구니에 상품을 담으려면 로그인이 필요합니다, 로그인 화면으로 이동하시겠습니까 ? '),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context),
                                    child: const Text('취소')
                                ),
                                TextButton(onPressed: () {
                                  Navigator.pop(context); // Alert 닫기
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const LoginScreen(),
                                      ),
                                  );
                                },
                                    child: const Text('로그인으로 이동'),
                                )
                              ],
                            )
                        );
                      }
                    },
                    label: const Text('장바구니'),
                    icon: Icon(Icons.shopping_cart),
                  ),
                ),
                const SizedBox(width: 10),
                // 구매 버튼
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: 결제 기능 추가 예정
                    },
                    label: const Text('구매하기'),
                    icon: Icon(Icons.payment),
                  ),
                ),
              ],
            ),

            const Divider(), // 구분선

            // 🔹 상품 상세 설명 섹션
            const Text(
              '상품 상세 설명',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // 상세 이미지
            Image.network(
              '${AppConfig.baseUrl}/product/image/${product.thumb750}',
            ),
          ],
        ),
      ),
    );
  }
}
