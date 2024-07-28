import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/model/cart_model.dart';
import '../../common/utils/data_utils.dart';
import '../../product/model/product_model.dart';
import '../../product/provider/product_provider.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_provider.dart';
import '../model/delivery_model.dart';
import '../model/order_model.dart';
import '../model/payment_model.dart';

final orderDetailProvider = Provider.family<OrderModel, String>((ref, id) {
  final orders = ref.watch(orderProvider);

  return orders.firstWhere((element) => element.id == id);
});

final orderProvider =
    StateNotifierProvider<OrderStateNotifier, List<OrderModel>>((ref) {
  final products = ref.read(productProvider);
  final user = ref.read(userProvider) as UserModel;

  return OrderStateNotifier(
    products: products,
    user: user,
  );
});

class OrderStateNotifier extends StateNotifier<List<OrderModel>> {
  final List<ProductModel> products;
  final UserModel user;

  OrderStateNotifier({
    required this.products,
    required this.user,
  }) : super([]) {
    state = getOrders();
  }

  void orderFromCarts({
    required List<CartModel> carts,
    required UserModel user,
    required String cardName,
    required int totalPrice,
  }) {
    final delivery = DeliveryModel(
      id: DataUtils.getUuid(),
      recipientName: user.address.name,
      recipientPhone: user.address.phone,
      recipientAddress: user.address.address + user.address.detailAddress,
      recipientMemo: user.address.memo,
    );

    final payment = PaymentModel(
        id: DataUtils.getUuid(),
        cardName: cardName,
        status: '완료',
        price: totalPrice,
        createdAt: DateTime.now(),
    );

    state = [
      ...state,
      OrderModel(
        id: DataUtils.getUuid(),
        createdAt: DateTime.now(),
        name: user.name,
        phone: user.phone,
        carts: carts,
        delivery: delivery,
        payment: payment,
      ),
    ];
  }

  List<OrderModel> getOrders() {
    int amount = 10;

    return [
      ...products.map((e) {
        DateTime createdAt = DateTime(
          2024,
          Random().nextInt(DateTime.now().month + 1),
          Random().nextInt(DateTime.now().day + 1),
          Random().nextInt(DateTime.now().hour + 1),
          Random().nextInt(DateTime.now().minute + 1),
        );

        return OrderModel(
          id: DataUtils.getUuid(),
          createdAt: createdAt,
          name: user.name,
          phone: user.phone,
          status: OrderStatus.done,
          carts: [
            CartModel(
              id: DataUtils.getUuid(),
              product: e,
              amount: amount,
              isSelected: true,
            )
          ],
          delivery: DeliveryModel(
            id: DataUtils.getUuid(),
            recipientName: user.address.name,
            recipientPhone: user.address.phone,
            recipientAddress:
                '${user.address.address}\n${user.address.detailAddress}',
            recipientMemo: user.address.memo,
          ),
          payment: PaymentModel(
            id: DataUtils.getUuid(),
            cardName: '국민카드',
            price: e.price,
            createdAt: createdAt,
          ),
        );
      }),
    ];
  }
}
