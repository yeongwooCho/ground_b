
import '../../cart/model/cart_model.dart';
import 'delivery_model.dart';
import 'payment_model.dart';

enum OrderStatus {
  // order('주문중'),
  ready('준비중'),
  doing('배송중'),
  done('배송완료');

  const OrderStatus(this.label);

  final String label;
}

class OrderModel {
  final String id; // 주문 번호
  final OrderStatus status; // 주문 상태
  final DateTime createdAt; // 주문 일시
  final String name; // 주문자
  final String phone; // 주문자 번호
  final List<CartModel> carts;
  final DeliveryModel delivery;
  final PaymentModel payment;

  OrderModel({
    required this.id,
    this.status = OrderStatus.ready,
    required this.createdAt,
    required this.name,
    required this.phone,
    required this.carts,
    required this.delivery,
    required this.payment,
  });

  OrderModel copyWith({
    String? id,
    OrderStatus? status,
    DateTime? createdAt,
    String? name,
    String? phone,
    List<CartModel>? carts,
    DeliveryModel? delivery,
    PaymentModel? payment,
  }) {
    return OrderModel(
      id: id ?? this.id,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      carts: carts ?? this.carts,
      delivery: delivery ?? this.delivery,
      payment: payment ?? this.payment,
    );
  }
}
