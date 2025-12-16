/*
 * 파일명 : ProductListItem.dart
 * 설명   : 상품 목록 화면(ProductListScreen)에서
 *          상품 1개를 카드 형태로 표시하는 위젯.
 *          즉, 상품 리스트 내의 ‘한 줄’을 담당하는 UI 컴포넌트.
 *
 * 주요 기능 :
 * - 상품 썸네일, 이름, 가격, 할인율, 최종가격 표시
 * - 클릭 시 SnackBar 출력 (→ 나중에 상세페이지로 이동 예정)
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/config/app_config.dart';
import 'package:kmarket_shopping_app/modals/product.dart';
import 'package:kmarket_shopping_app/screens/product/product_view_screen.dart';

class ProductListItem extends StatelessWidget {

  // Product 모델 객체 (상품 한 개의 데이터)
  final Product product;

  // 생성자 : ProductListScreen에서 product 전달받음
  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    // 할인율을 적용한 최종 판매가 계산
    final finalPrice = product.price * (1 - product.discount / 100).round();

    return GestureDetector(
      // 🔹 상품 클릭 시 이벤트 (현재는 SnackBar만 표시)
      // 🔸 나중에 상세페이지(ProductDetailScreen)로 이동 예정
      onTap: () {
       /* ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('상세 상품 이동')),
        );*/
        
        // 상품 상세 이동
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductViewScreen(product: product,)),
        );
      },

      // 🔹 카드 형태 UI
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              // 상품 썸네일 이미지
              SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  '${AppConfig.baseUrl}/product/image/${product.thumb120}',
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 10),

              // 상품 정보 텍스트 영역
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment .start,
                  children: [
                    Text('상품번호 : ${product.pno}'),
                    Text(
                      product.productName,
                      overflow: TextOverflow.ellipsis, // 긴 상품명은 "..." 처리
                    ),
                    Text('가격 : ${product.price} (할인율 : ${product.discount}%)'),
                    Text('최종가격 : $finalPrice',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.purpleAccent
                      ),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
