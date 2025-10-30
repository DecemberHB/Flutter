// 홈 인덱스 선택 화면

import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/screens/member/login_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<StatefulWidget> createState() => _HomeTabState();
  
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _buildAppBar(context),),
      body: SingleChildScrollView( // 애로 위젯
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildSlideBanner(context),
            _buildProductSection(context, '베스트 상품'),
            _buildProductSection(context, '히트 상품'),
            _buildProductSection(context, '추천 상품'),
            _buildProductSection(context, '최신 상품'),
            _buildProductSection(context, '할인 상품'),
            _buildFooter(context)
          ],
        ),

      )
    );
  }
  
  // 상단 appBar 디자인 함수 (너무 많아서  build에서 처리 힘듦)
  Widget _buildAppBar(BuildContext context){ // Widget 반환
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('images/logo.png',width: 140,),
        IconButton(
            // 로그인 버튼 클릭시 화면 이동
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => LoginScreen())
              );
            },
            icon: Icon(Icons.login, size: 30,)
        )
      ],
    );
  }

  // 검색 바 디자인 함수
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: '상품검색',
          border: null,
        ),
      ),
    );
  }
  
  // 슬라이드 배너 디자인 함수
  Widget _buildSlideBanner(BuildContext context) {
    
    final List<String> bannerImages = [
      'images/slider_item1.jpg',
      'images/slider_item2.jpg',
      'images/slider_item3.jpg',
      'images/slider_item4.jpg',
      'images/slider_item5.jpg',
    ];
    
    return SizedBox(
      height: 200,
      child: PageView.builder(
          itemCount: bannerImages.length,
          itemBuilder: (context, index){
            final pathImage = bannerImages[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              child: Image.asset(pathImage),
            );
          }
      ),
    );
  }

  // 상품 섹션 디자인 함수
  Widget _buildProductSection(BuildContext context, String title){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        SizedBox(
          height: 200,
          // 상품 8개 슬라이드 방식으로 하기 위해
          child: ListView.builder(
            // 기본 수직 이기에 수평으로
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index){
              return Container(
                width: 150,
                height: 150,
                // 상품 이미지 / 상품 가격을 보여주기 위해
                child: Column(
                  children: [
                    Container(
                      // 이미지 테두리
                      width: 140,
                      height: 140,
                      color: Colors.grey,
                      // 상품 이미지
                      child: Image.asset('images/sample_thumb.jpg'),
                    ),
                    // 상품명
                    Text('가을 티셔츠'),
                    // 상품 가격
                    Text('16,000'),
                  ],

                ),
              );

            },
          ),
        )
      ],
    );
  }

  // 하단 푸터 디자인 함수
  Widget _buildFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      color: Colors.grey[200],
      child: Column(
        children: [
          Text('회사 정보 및 약관'),
          Text('고객센터 : 000-000-0000', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          Text('ⓒKmarket Shopping App. All right reserved.',style: TextStyle(fontSize: 10),),
        ],
      ),
    );
  }
}