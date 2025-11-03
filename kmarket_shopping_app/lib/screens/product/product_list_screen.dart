/*
 * 파일명 : ProductListScreen.dart
 * 설명   : 선택한 카테고리의 상품 목록 전체를 출력하는 화면.
 *          (카테고리 클릭 시 이동되는 페이지)
 *
 * 주요 기능 :
 * - ProductService를 통해 서버에서 상품 목록 데이터 비동기 로딩
 * - FutureBuilder로 로딩/에러/완료 상태별 화면 처리
 * - 상품 목록을 ListView.builder()로 출력
 * - 각 상품은 ProductListItem 위젯으로 표시됨
 */

import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/modals/product.dart';
import 'package:kmarket_shopping_app/modals/product_response.dart';
import 'package:kmarket_shopping_app/screens/product/product_list_item.dart';
import 'package:kmarket_shopping_app/services/product_service.dart';

class ProductListScreen extends StatefulWidget {

  // 전달받은 카테고리 정보 (번호 + 이름)
  final int categoryNum;
  final String categoryName;

  // 생성자 : CategoryScreen에서 선택한 카테고리 정보 전달받음
  const ProductListScreen({
    super.key,
    required this.categoryNum,
    required this.categoryName
  });

  @override
  State<StatefulWidget> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  // 상품 목록 데이터를 저장할 리스트
  List<Product> _productList = [];

  // 페이징 관련 변수
  int _page = 1;           // 현재 페이지 번호
  bool _isLoading = false; // 로딩 중 여부
  bool _hasMore = true;    // 다음 페이지 존재 여부

  // 상품 목록을 불러올 서비스 객체
  final service = ProductService();

  // 초기 상품 목록 요청 (FutureBuilder용)
  late Future<ProductResponse> _initProductFuture;

  @override
  void initState() {
    super.initState();

    // 화면 빌드 전에 첫 상품 목록 데이터 로딩
    _initProductFuture = _loadInitialProducts();
  }

  // 🔹 상품 목록 데이터를 백엔드에서 가져오는 함수
  Future<ProductResponse> _loadInitialProducts() async {

    // API 요청 (카테고리 번호와 페이지 번호 전달)
    final jsonData = await service.fetchProductList(widget.categoryNum, _page);

    // JSON → ProductResponse 변환
    final productResponse = ProductResponse.fromJson(jsonData);

    // setState로 화면에 상품 리스트 반영
    setState(() {
      _productList.addAll(productResponse.dtoList);
    });

    return productResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱바 : 카테고리명 + 번호 표시
      appBar: AppBar(
        title: Text('${widget.categoryName}(${widget.categoryNum}) 상품 목록'),
      ),

      // 본문 : FutureBuilder로 비동기 처리
      body: FutureBuilder(
        future: _initProductFuture, // Future 비동기 결과 참조
        builder: (context, snapshot) {

          // 🔸 1) 로딩 중 상태
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 🔸 2) 에러 발생 시
          if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          }

          // 🔸 3) 데이터가 없을 경우
          if (_productList.isEmpty) {
            return const Center(child: Text('상품이 없습니다.'));
          }

          // 🔸 4) 정상적으로 상품 목록 표시
          return ListView.builder(
            itemCount: _productList.length,
            itemBuilder: (context, index) {
              // 상품 하나씩 가져와서 ProductListItem 위젯으로 표시
              final product = _productList[index];
              return ProductListItem(product: product);
            },
          );
        },
      ),
    );
  }
}
