import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cart/model/cart_model.dart';
import '../../common/component/divider_container.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../../common/utils/data_utils.dart';
import '../component/product_and_amount_card.dart';
import '../model/delivery_model.dart';
import '../model/order_model.dart';
import '../model/payment_model.dart';
import '../provider/order_provider.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'order_detail';

  final String id;

  const OrderDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  bool isSelectedDelivery = false;
  bool isSelectedPayment = false;

  @override
  Widget build(BuildContext context) {
    final order = ref.watch(orderDetailProvider(widget.id));

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '주문상세'),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _renderOrderInfo(order: order),
            DividerContainer(),
            _renderProductInfo(carts: order.carts),
            DividerContainer(),
            _renderDeliveryInfo(
              delivery: order.delivery,
              isSelected: isSelectedDelivery,
              onTap: () {
                setState(() {
                  isSelectedDelivery = !isSelectedDelivery;
                });
              },
            ),
            DividerContainer(),
            _renderPaymentInfo(
              payment: order.payment,
              isSelected: isSelectedPayment,
              onTap: () {
                setState(() {
                  isSelectedPayment = !isSelectedPayment;
                });
              },
            ),
            DividerContainer(),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  Widget _renderOrderInfo({
    required OrderModel order,
  }) {
    final productPrice = order.carts
        .map((e) => e.product.price * e.amount)
        .reduce((value, element) => value + element);
    final totalPrice = order.payment.price;
    final discountPrice = productPrice - totalPrice;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '주문 정보',
            style: MyTextStyle.bodyTitleMedium,
          ),
          const SizedBox(height: 8.0),
          _renderTitleAndDescription(
            title: '주문번호',
            description: DataUtils.extractNumbers(order.id.split('-').join())
                .substring(0, 9),
          ),
          _renderTitleAndDescription(
            title: '주문상태',
            description: order.status.label,
          ),
          _renderTitleAndDescription(
            title: '주문일시',
            description: DataUtils.convertDateTimeToDateTimeString(
              datetime: order.createdAt,
            ),
          ),
          _renderTitleAndDescription(
            title: '주문자',
            description: order.name,
          ),
          _renderTitleAndDescription(
            title: '주문자 연락처',
            description: order.phone,
          ),
          _renderTitleAndDescription(
            title: '상품 금액',
            description: '${DataUtils.convertPriceToMoneyString(
              price: productPrice,
            )} 원',
          ),
          _renderTitleAndDescription(
            title: '할인 금액',
            description: '${DataUtils.convertPriceToMoneyString(
              price: productPrice - totalPrice,
            )} 원',
          ),
          _renderTitleAndDescription(
            title: '최종 결제 금액',
            description: '${DataUtils.convertPriceToMoneyString(
              price: totalPrice,
            )} 원',
          ),
        ],
      ),
    );
  }

  Widget _renderTitleAndDescription({
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.0,
            child: Text(
              title,
              style: MyTextStyle.descriptionRegular,
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: MyTextStyle.descriptionRegular,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderProductInfo({
    required List<CartModel> carts,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '상품 정보',
            style: MyTextStyle.bodyTitleMedium,
          ),
          const SizedBox(height: 8.0),
          ...carts.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ProductAndAmountCard(
                  cart: e,
                  isFixed: true,
                ),
              )),
        ],
      ),
    );
  }

  Widget _renderDeliveryInfo({
    required DeliveryModel delivery,
    required bool isSelected,
    required void Function() onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '배송 정보',
                  style: MyTextStyle.bodyTitleMedium,
                ),
                PhosphorIcon(
                  isSelected
                      ? PhosphorIcons.caretUp()
                      : PhosphorIcons.caretDown(),
                  size: 32.0,
                ),
              ],
            ),
          ),
        ),
        if (isSelected)
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20.0, left: 24.0, right: 24.0),
            child: Column(
              children: [
                _renderTitleAndDescription(
                  title: '받으시는 분',
                  description: delivery.recipientName,
                ),
                _renderTitleAndDescription(
                  title: '연락처',
                  description: delivery.recipientPhone,
                ),
                _renderTitleAndDescription(
                  title: '주소',
                  description: delivery.recipientAddress,
                ),
                _renderTitleAndDescription(
                  title: '배송메모',
                  description: delivery.recipientMemo,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _renderPaymentInfo({
    required PaymentModel payment,
    required bool isSelected,
    required void Function() onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '결제 정보',
                  style: MyTextStyle.bodyTitleMedium,
                ),
                PhosphorIcon(
                  isSelected
                      ? PhosphorIcons.caretUp()
                      : PhosphorIcons.caretDown(),
                  size: 32.0,
                ),
              ],
            ),
          ),
        ),
        if (isSelected)
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20.0, left: 24.0, right: 24.0),
            child: Column(
              children: [
                _renderTitleAndDescription(
                  title: '결제 수단',
                  description: payment.cardName,
                ),
                _renderTitleAndDescription(
                  title: '결제 상태',
                  description: payment.status,
                ),
                _renderTitleAndDescription(
                  title: '결제 일시',
                  description: DataUtils.convertDateTimeToDateTimeString(
                    datetime: payment.createdAt,
                  ),
                ),
                _renderTitleAndDescription(
                  title: '최종 결제 금액',
                  description:
                      '${DataUtils.convertPriceToMoneyString(price: payment.price)} 원',
                ),
              ],
            ),
          ),
      ],
    );
  }
}
