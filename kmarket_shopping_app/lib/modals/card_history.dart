class CardHistory {
  final int transactionId;

  final int memberId;
  final int memberCardId;

  final DateTime approvalDatetime;
  final int approvalAmount;

  final String merchantName;
  final String? merchantCategory;

  final int? benefitId;
  final int? benefitAmount;

  final String isPerformance; // Y / N

  final double latitude;
  final double longitude;
  final String merchantAddress;

  CardHistory({
    required this.transactionId,
    required this.memberId,
    required this.memberCardId,
    required this.approvalDatetime,
    required this.approvalAmount,
    required this.merchantName,
    this.merchantCategory,
    this.benefitId,
    this.benefitAmount,
    required this.isPerformance,
    required this.latitude,
    required this.longitude,
    required this.merchantAddress,
  });

  /// JSON → Dart 객체 변환 (Spring DTO 응답 파싱)
  factory CardHistory.fromJson(Map<String, dynamic> json) {
    return CardHistory(
      transactionId: json['transactionId'],
      memberId: json['memberId'],
      memberCardId: json['memberCardId'],
      approvalDatetime: DateTime.parse(json['approvalDatetime']),
      approvalAmount: json['approvalAmount'],
      merchantName: json['merchantName'],
      merchantCategory: json['merchantCategory'],
      benefitId: json['benefitId'],
      benefitAmount: json['benefitAmount'],
      isPerformance: json['isPerformance'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      merchantAddress: json['merchantAddress'],
    );
  }

  /// Dart 객체 → JSON (필요 시)
  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'memberId': memberId,
      'memberCardId': memberCardId,
      'approvalDatetime': approvalDatetime.toIso8601String(),
      'approvalAmount': approvalAmount,
      'merchantName': merchantName,
      'merchantCategory': merchantCategory,
      'benefitId': benefitId,
      'benefitAmount': benefitAmount,
      'isPerformance': isPerformance,
      'latitude': latitude,
      'longitude': longitude,
      'merchantAddress': merchantAddress,
    };
  }
}
