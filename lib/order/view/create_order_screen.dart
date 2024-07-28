import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../cart/provider/cart_provider.dart';
import '../../common/component/default_button.dart';
import '../../common/component/divider_container.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../../common/view/completion_screen.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_provider.dart';
import '../component/delivery_info.dart';
import '../component/order_info.dart';
import '../component/product_info.dart';
import '../component/toss_payment_container.dart';
import '../provider/order_provider.dart';

class CreateOrderScreen extends ConsumerStatefulWidget {
  static String get routeName => 'create_order';

  const CreateOrderScreen({super.key});

  @override
  ConsumerState<CreateOrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<CreateOrderScreen> {
  bool isLoading = false;
  int productPrice = 0;
  int totalPrice = 0;

  String cardName = ''; // 카드사 이름

  @override
  Widget build(BuildContext context) {
    final carts = ref.watch(selectedCartProvider);
    final user = ref.watch(userProvider) as UserModel;

    // price
    if (carts.isNotEmpty) {
      productPrice = carts
          .map((e) => e.product.price * e.amount)
          .reduce((value, element) => value + element);

      totalPrice = carts
          .map((e) =>
              (e.product.price * (100 - e.product.sale) ~/ 100) * e.amount)
          .reduce((value, element) => value + element)
          .toInt();
    } else {
      productPrice = 0;
      totalPrice = 0;
    }

    return DefaultLayout(
      isLoading: isLoading,
      appbar: const DefaultAppBar(title: '주문/결제'),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductInfo(carts: carts),
            const DividerContainer(),
            OrderInfo(
              user: user,
              productPrice: productPrice,
              totalPrice: totalPrice,
            ),
            const DividerContainer(),
            DeliveryInfo(address: user.address),
            const DividerContainer(),
            TossPaymentContainer(
              onChanged: (value) {
                cardName = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: PrimaryButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await Future.delayed(const Duration(seconds: 2));
                  setState(() {
                    isLoading = false;
                  });

                  // 주문/결제하기
                  ref.read(orderProvider.notifier).orderFromCarts(
                        carts: carts,
                        user: user,
                        cardName: cardName,
                        totalPrice: totalPrice,
                      );
                  ref.read(cartProvider.notifier).removeAllSelectedProduct();

                  context.goNamed(
                    CompletionScreen.routeName,
                    pathParameters: {'title': '결제가\n정상적으로\n완료되었습니다.'},
                  );
                },
                child: const Text('결제하기'),
              ),
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
