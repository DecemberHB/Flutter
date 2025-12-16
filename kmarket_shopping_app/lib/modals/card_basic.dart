
class CardBasic {
  final int cardId;
  final String cardName;
  final String bankName;
  final int annualFee;
  final String cardType;
  final String cardGrade;
  final int minPerformanceAmount;
  final String cardImageUrl;

  CardBasic({
    required this.cardId,
    required this.cardName,
    required this.bankName,
    required this.annualFee,
    required this.cardType,
    required this.cardGrade,
    required this.minPerformanceAmount,
    required this.cardImageUrl,
  });

  /// JSON → Dart 객체 변환 (Spring DTO 응답 파싱)
  factory CardBasic.fromJson(Map<String, dynamic> json) {
    return CardBasic(
      cardId: json['cardId'],
      cardName: json['cardName'],
      bankName: json['bankName'],
      annualFee: json['annualFee'],
      cardType: json['cardType'],
      cardGrade: json['cardGrade'],
      minPerformanceAmount: json['minPerformanceAmount'],
      cardImageUrl: json['cardImageUrl'],
    );
  }

  /// Dart 객체 → JSON (필요 시: POST / PUT)
  Map<String, dynamic> toJson() {
    return {
      'cardId': cardId,
      'cardName': cardName,
      'bankName': bankName,
      'annualFee': annualFee,
      'cardType': cardType,
      'cardGrade': cardGrade,
      'minPerformanceAmount': minPerformanceAmount,
      'cardImageUrl': cardImageUrl,
    };
  }
}
