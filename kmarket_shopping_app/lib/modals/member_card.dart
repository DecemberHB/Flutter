class MemberCard {
  final int memberCardId;

  final int memberId;
  final int cardId;

  final String cardNumber;

  final DateTime issueDate;
  final DateTime expiryDate;

  final String cardStatus;

  final int paymentDay;
  final String paymentBank;
  final String paymentAccount;

  MemberCard({
    required this.memberCardId,
    required this.memberId,
    required this.cardId,
    required this.cardNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.cardStatus,
    required this.paymentDay,
    required this.paymentBank,
    required this.paymentAccount,
  });

  /// JSON → Dart 객체 변환 (Spring DTO 응답 파싱)
  factory MemberCard.fromJson(Map<String, dynamic> json) {
    return MemberCard(
      memberCardId: json['memberCardId'],
      memberId: json['memberId'],
      cardId: json['cardId'],
      cardNumber: json['cardNumber'],
      issueDate: DateTime.parse(json['issueDate']),
      expiryDate: DateTime.parse(json['expiryDate']),
      cardStatus: json['cardStatus'],
      paymentDay: json['paymentDay'],
      paymentBank: json['paymentBank'],
      paymentAccount: json['paymentAccount'],
    );
  }

  /// Dart 객체 → JSON (필요 시: POST / PUT)
  Map<String, dynamic> toJson() {
    return {
      'memberCardId': memberCardId,
      'memberId': memberId,
      'cardId': cardId,
      'cardNumber': cardNumber,
      'issueDate': issueDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'cardStatus': cardStatus,
      'paymentDay': paymentDay,
      'paymentBank': paymentBank,
      'paymentAccount': paymentAccount,
    };
  }
}
