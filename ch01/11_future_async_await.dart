/*
  날짜 : 2025/10/24
  이름 : 박효빈
  내용 : Dart 비동기 처리 * 중요 *
*/
// 함수 정의
// Future는 미래에 가져오는 값을 의미하는 객체 (비동기)
import 'dart:async';

Future<String> fetchData(){
  // 서버에서 데이터를 가져오는 백엔드 작업 (비동기 작업 정의) - 시간 걸리는 작업을 딜레이로 표현 한 것뿐 deleye >> 통신 들어갈 예정
  return Future.delayed(Duration(seconds: 3),(){ // 3초 진행
    return 'fetchData!';
  });
}

// Stream을 반환하는 함수
Stream<int> countStream() async*{

  for(int i=1; i<=5; i++){
    await Future.delayed(Duration(seconds :1));
    yield i; // 스트림으로 데이터sms 내보내기(emit)
  }

}

void main() async {

  // 비동기 작업 수행
  print('here...1');
  fetchData()
      .then((data){
        // 비동기 함수 결과값

        print('here...2 : $data');
  })
      .catchError((err){
        // 비동기 함수에서 에러가 났을떄
        print('here...3 : $err');
  })
      .whenComplete((){
        // 작업 종료
        print('here...4 비동기 작업 완료!');
  });

    print('here...5'); // 결과값 1 - 5 - 2 - 4

  // async/await 실행
  print('async_await...1');


  try {
    String data = await fetchData(); // await 가 fetch를 대기 >> async main 뒤에 붙혀줌
    print('async_await...2 : $data');
  }catch(e) {
    print('async_await...3 : $e');
  }finally {
    print('async_await...4 비동기 작업 완료');
  }

  print('async_await...5'); // 순서대로 1 - 2 - 4 - 5


  /*
  * Future vs Stream
  *  - Future는 한 번만 비동기 값을 반환하는 비동기 처리
  *  - Stream은 시간이 지남에 따라 여러 데이터를 순차적으로 전달하는 비동기 처리 (잘 안씀 - 채팅, 센서 장비에 씀)
  * */
  // Stream 작업
  final controller = StreamController<String>(); // String은 스트림으로 보내는 데이터 타입

  // Stream 리스너 등록
  controller.stream
      .listen((data){
        print('stream...1 : $data');
  })
      .onError((err){
        print('stream error');
  });

  // 스트림 데이터 전송
  controller.sink.add('hello'); //$data << 여기에
  controller.sink.add('welcome');
  controller.sink.add('greeting');

  // Stream 함수 호출 후 await for 출력
  Stream<int> stream = countStream();

  await for(int number in stream){
    print('스트림 데이터 수신 : $number');

  }

}
