/*
 * 파일명 : Product.dart
 * 설명   : 백엔드(ProductDTO) 구조를 그대로 반영한
 *          Flutter 클라이언트용 상품 데이터 모델 클래스.
 *
 * 주요 역할 :
 * - 서버에서 전달받은 상품 정보를 Flutter에서 다루기 쉽게 구조화
 * - JSON 데이터를 Product 객체로 변환 (fromJson)
 * - ProductListScreen, ProductListItem 등에서 공통으로 사용
 */

class Product {

  // 🧩 상품의 주요 속성 (백엔드 ProductDTO와 동일한 필드명)
  final int pno;            // 상품번호 (PK)
  final String productName; // 상품명
  final String category;    // 카테고리 코드 (예: 'C01')
  final int price;          // 상품가격
  final int point;          // 적립 포인트
  final int discount;       // 할인율 (%)
  final int delivery;       // 배송비
  final int stock;          // 재고 수량
  final String? etc;        // 비고 (nullable, optional 값)

  // 🖼️ 추가 필드 (썸네일 이미지 경로)
  final String thumb120;    // 작은 이미지
  final String thumb240;    // 중간 이미지
  final String thumb750;    // 큰 이미지

  /*
   * 생성자 : Flutter에서 Product 객체를 직접 만들 때 사용
   * 백엔드의 DTO 구조를 그대로 반영하면서
   * nullable 필드(etc)는 required 해제
   */
  Product({
    required this.pno,
    required this.productName,
    required this.category,
    required this.price,
    required this.point,
    required this.discount,
    required this.delivery,
    required this.stock,
    this.etc, // nullable 필드
    required this.thumb120,
    required this.thumb240,
    required this.thumb750,
  });

  /*
   * 팩토리 생성자 : JSON → Product 객체로 변환
   * 백엔드에서 받은 JSON 데이터를 Product로 매핑
   *
   * 사용 예시 :
   * final product = Product.fromJson(jsonData);
   */
  // 여기의 json => response에서 넘어온 product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      pno: json['pno'],
      productName: json['productName'],
      category: json['category'],
      price: json['price'],
      point: json['point'],
      discount: json['discount'],
      delivery: json['delivery'],
      stock: json['stock'],
      etc: json['etc'],
      thumb120: json['thumb120'],
      thumb240: json['thumb240'],
      thumb750: json['thumb750'],
    );
  }
}
