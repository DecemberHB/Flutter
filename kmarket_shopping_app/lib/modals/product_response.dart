/*
 * 파일명 : ProductResponse.dart
 * 설명   : 백엔드 서버에서 받은 상품 목록 응답(JSON)을
 *          Flutter에서 다루기 쉽게 변환하는 응답 객체 클래스.
 *
 * 주요 역할 :
 * - ProductService.fetchProductList()의 응답(JSON)을 구조화
 * - 상품 리스트(dtoList), 카테고리명(category), 전체 개수(total)를 담음
 * - ProductListScreen에서 상품 목록 데이터를 표시할 때 사용됨
 *
 * 예시 응답(JSON)
 * {
 *   "dtoList": [ {상품1}, {상품2}, ... ],
 *   "category": "의류",
 *   "total": 42
 * }
 */

import 'package:kmarket_shopping_app/modals/product.dart';

class ProductResponse {

  // 서버에서 받은 데이터 구조를 그대로 반영
  final List<Product> dtoList; // 상품 목록 리스트
  final String category;       // 카테고리 이름
  final int total;             // 전체 상품 개수 (페이징용)

  // 기본 생성자 : JSON 파싱 후 객체로 만들 때 사용
  ProductResponse({
    required this.dtoList,
    required this.category,
    required this.total
  });

  /*
   * 팩토리 생성자 : JSON → ProductResponse 객체로 변환
   *
   * 과정 :
   * 1. json['dtoList']로 상품 리스트(JSON 배열) 가져옴
   * 2. map()을 이용해 각 상품을 Product.fromJson()으로 변환
   * 3. 변환된 Product 리스트를 dtoList에 담음
   * 4. category, total 값도 함께 저장
   */
  factory ProductResponse.fromJson(Map<String, dynamic> json) {

    // dtoList는 JSON 배열 형태이므로 List로 캐스팅
    final dtoList = json['dtoList'] as List;

    // JSON 배열 → Product 객체 리스트로 변환
    List<Product> productList = dtoList.map(
          (product) => Product.fromJson(product),
    ).toList();

    return ProductResponse(
      dtoList: productList,     // 변환된 상품 리스트
      category: json['category'], // 카테고리 이름
      total: json['total'],       // 전체 상품 수 (페이징용)
    );
  }
}
