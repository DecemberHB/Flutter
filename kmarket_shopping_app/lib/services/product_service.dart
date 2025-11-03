/*
 * 파일명 : ProductService.dart
 * 설명   : 백엔드(Spring Boot) 서버와 통신해서
 *          상품 목록(JSON 데이터)을 받아오는 서비스 클래스.
 *
 * 주요 기능 :
 * - HTTP GET 요청으로 상품 목록 데이터를 요청
 * - 응답으로 받은 JSON 문자열을 Map 형태로 변환해서 반환
 * - ProductListScreen에서 이 데이터를 사용함
 */

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ProductService {

  // 🔹 로컬 서버 주소 (Android 에뮬레이터에서는 10.0.2.2 사용)
  final String baseUrl = 'http://10.0.2.2:8080/ch09';

  /*
   * 함수명 : fetchProductList()
   * 역할   : 카테고리 번호와 페이지 번호를 이용해
   *          상품 목록 데이터를 서버에서 가져옴.
   * 매개변수 :
   *   - int category : 카테고리 번호
   *   - int pg       : 페이지 번호
   * 반환값 :
   *   - Future<Map<String, dynamic>> : 비동기로 받아온 JSON 데이터
   */
  Future<Map<String, dynamic>> fetchProductList(int category, int pg) async {

    try {
      // 🔹 GET 요청 보내기 (백엔드 API 호출)
      final response = await http.get(
        Uri.parse('$baseUrl/product?category=$category&pg=$pg'));

      log('페이지 : $pg');


      // 🔹 응답 상태코드가 200(성공)일 때
      if (response.statusCode == 200) {
        // JSON 문자열을 Map 형태로 변환
        final jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        // 서버 에러 코드 발생 시 예외 처리
        throw Exception(response.statusCode);
      }

    } catch (err) {
      // 네트워크 오류, 예외 등 모든 오류를 예외로 던짐
      throw Exception(err);
    }
  }
}
