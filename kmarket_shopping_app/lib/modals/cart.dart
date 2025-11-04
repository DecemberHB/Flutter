// 카트 모델 클래스

import 'package:kmarket_shopping_app/modals/product.dart';

class Cart {
  final int? cartId;
  final String? userid;
  final Product product;
  final int quantity;

  Cart({this.cartId, this.userid, required this.product, required this.quantity});

  // 생성자
factory Cart.fromJson(Map<String, dynamic> json){




  // 프로덕트 캐스팅
  final product = json['productDTO'] as Map<String, dynamic>;

  return Cart(
      cartId: json['cartId'],
      userid: json['userid'],
      product: Product.fromJson(product), // .. 리뷰 필요
      quantity: json['quantity'],
  );

}
}