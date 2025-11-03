
// 1차 카테고리 모델 클래스
import 'package:kmarket_shopping_app/modals/category_sub.dart';

class Category {
  final String id;
  final String name;
  final List<CategorySub> subCategories;

  Category({required this.id, required this.name, required this.subCategories});
}