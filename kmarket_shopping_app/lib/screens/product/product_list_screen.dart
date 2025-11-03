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

  final int categoryNum;
  final String categoryName;

  const ProductListScreen({super.key, required this.categoryNum, required this.categoryName});
  @override
  State<StatefulWidget> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  List<Product> _productList = [];

  // 무한 스크롤 상태변수
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  final ScrollController _scrollController = ScrollController();

  final service = ProductService();

  late Future<ProductResponse> _initProductFuture;

  @override
  void initState() {
    super.initState();

    // 화면 빌드하기 전에 상폼 목록 데이터 가져오기
    _initProductFuture = _loadInitialProducts();

    // 스크롤 위치 감지 리스너 등록
    _scrollController.addListener((){

      // 현재 스크롤 위치가 최대 스크롤 범위에 가까워졌을 때
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200){
        if(!_isLoading && _hasMore){
          // 다음 상품 목록 불러오기
          _loadMoreProducts();
        }
      }
    });
  }

  Future<ProductResponse> _loadInitialProducts() async {

    final jsonData = await service.fetchProductList(widget.categoryNum, _page);
    final productResponse = ProductResponse.fromJson(jsonData);

    setState(() {
      _productList.addAll(productResponse.dtoList);

      // 다음 상품 페이지 번호
      _page = 2;

      // 현재 상품 갯수와 총 상품 갯수를 비교해서 총 상품 갯수 보다 크면 더이상 가져올 데이터 없음
      if(_productList.length >= productResponse.total){
        _hasMore = false;
      }

    });

    return productResponse;
  }

  Future<void> _loadMoreProducts() async {

    // 상품 로드 시작
    setState(() {
      _isLoading = true;
    });

    final jsonData = await service.fetchProductList(widget.categoryNum, _page);
    final productResponse = ProductResponse.fromJson(jsonData);

    if(productResponse.dtoList.isNotEmpty){

      setState(() {
        // 리스트뷰 상품 목록 추가
        _productList.addAll(productResponse.dtoList);

        // 다음 상품 페이지
        _page++;

        // 현재 상품 갯수와 총 상품 갯수를 비교해서 총 상품 갯수 보다 크면 더이상 가져올 데이터 없음
        if(_productList.length >= productResponse.total){
          _hasMore = false;
        }
      });
    }else {
      // 빈목록이 돌아오면 더 이상 상품 없음
      setState(() {
        _hasMore = false;
      });
    }

    // 상품 불러오기 끝
    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('${widget.categoryName}(${widget.categoryNum}) 상품 목록'),),
        body: FutureBuilder(
            future: _initProductFuture, // Future 비동기 처리 결과 참조
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('에러 발생: ${snapshot.error}'));
              }

              if (_productList.isEmpty) {
                return const Center(child: Text('상품이 없습니다.'));
              }

              return ListView.builder(
                  controller: _scrollController, // 리스트뷰 스크롤 컨트롤러
                  itemCount: _productList.length,
                  itemBuilder: (context, index){
                    final product = _productList[index];
                    return ProductListItem(product: product);
                  }
              );
            }
        )
    );
  }
}