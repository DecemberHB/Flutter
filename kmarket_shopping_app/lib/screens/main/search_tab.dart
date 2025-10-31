import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  // 가상 API 데이터
  final List<String> _recentSearches = ['신발', '원피스', '갤럭시 005'];
  final List<String> _suggestedKeywords = ['여름 세일', '캠핑 용품', '데일리룩'];
  final List<String> _popularKeywords = ['청바지', '에어컨', '선글라스'];

  // 실제 앱에서는 API 호출을 통해 데이터를 불러오는 FutureBuilder를 사용합니다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildSearchBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSectionTitle('최근 검색어'),
              _buildKeywordChips(_recentSearches, true), // 삭제 기능 포함
              const Divider(height: 30),

              _buildSectionTitle('추천 검색어'),
              _buildKeywordChips(_suggestedKeywords, false),
              const Divider(height: 30),

              _buildSectionTitle('인기 검색어 (실시간)'),
              _buildPopularKeywordList(_popularKeywords),
            ],
          ),
        ),
      ),
    );
  }

  // 검색바 UI
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        decoration: const InputDecoration(
          hintText: '검색어를 입력하세요',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
        ),
        onSubmitted: (value) {
          // 검색 결과 화면으로 이동 로직
        },
      ),
    );
  }

  // 섹션 제목
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 검색어 칩 목록 (최근 검색어, 추천 검색어)
  Widget _buildKeywordChips(List<String> keywords, bool canDelete) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: keywords.map((keyword) {
        return Chip(
          label: Text(keyword),
          deleteIcon: canDelete ? const Icon(Icons.close, size: 18) : null,
          onDeleted: canDelete
              ? () {
            setState(() {
              _recentSearches.remove(keyword); // 가상 삭제 로직
            });
          }
              : null,
          backgroundColor: Colors.grey[100],
        );
      }).toList(),
    );
  }

  // 인기 검색어 목록
  Widget _buildPopularKeywordList(List<String> keywords) {
    return Column(
      children: List.generate(keywords.length, (index) {
        // 번호와 마침표 사이에 공백 제거: 1.청바지
        final displayIndex = (index + 1).toString().padLeft(3, '0'); // 3자리 숫자
        return ListTile(
          leading: Text(
            '$displayIndex.', // 요청하신 형식 반영 (예: 001.청바지)
            style: TextStyle(
                fontWeight: index < 3 ? FontWeight.bold : FontWeight.normal,
                color: index < 3 ? Colors.red : Colors.black),
          ),
          title: Text(keywords[index]),
          trailing: const Icon(Icons.arrow_forward_ios, size: 15),
          onTap: () {
            // 해당 키워드로 검색 결과 화면 이동 로직
          },
        );
      }),
    );
  }
}