class CardBenefit {
  final int benefitId;
  final int cardId;

  final String benefitCategory;
  final String benefitName;
  final String applicableCategory;

  final String benefitType;        // RATE / AMOUNT
  final double? benefitRate;       // BigDecimal → double
  final int? monthlyLimit;

  CardBenefit({
    required this.benefitId,
    required this.cardId,
    required this.benefitCategory,
    required this.benefitName,
    required this.applicableCategory,
    required this.benefitType,
    this.benefitRate,
    this.monthlyLimit,
  });

  /// JSON → Dart 객체 변환 (Spring DTO 응답 파싱)
  factory CardBenefit.fromJson(Map<String, dynamic> json) {
    return CardBenefit(
      benefitId: json['benefitId'],
      cardId: json['cardId'],
      benefitCategory: json['benefitCategory'],
      benefitName: json['benefitName'],
      applicableCategory: json['applicableCategory'],
      benefitType: json['benefitType'],
      benefitRate: json['benefitRate']?.toDouble(),
      monthlyLimit: json['monthlyLimit'],
    );
  }

  /// Dart 객체 → JSON (필요 시: POST / PUT)
  Map<String, dynamic> toJson() {
    return {
      'benefitId': benefitId,
      'cardId': cardId,
      'benefitCategory': benefitCategory,
      'benefitName': benefitName,
      'applicableCategory': applicableCategory,
      'benefitType': benefitType,
      'benefitRate': benefitRate,
      'monthlyLimit': monthlyLimit,
    };
  }
}
