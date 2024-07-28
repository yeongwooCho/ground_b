class DeliveryModel {
  final String id;
  final String recipientName;
  final String recipientPhone;
  final String recipientAddress;
  final String recipientMemo;
  // final String invoice_number; // 운송장 번호
  // 주문 정보와 배송 정보는 다르다.
  // 주문 정보 : 주문/결제 완료, 준비중, 배송중, 배송완료, 구매 확정
  // 배송 정보 : 배송전, 배송중, 배송완료 -> 운송장 API 를 따라간다.

  DeliveryModel({
    required this.id,
    required this.recipientName,
    required this.recipientPhone,
    required this.recipientAddress,
    required this.recipientMemo,
  });
}
