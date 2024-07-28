class PaymentModel {
  final String id;
  final String cardName;
  final String status;
  final int price;
  final DateTime createdAt;

  PaymentModel({
    required this.id,
    required this.cardName,
    this.status = '완료',
    required this.price,
    required this.createdAt,
  });
}
