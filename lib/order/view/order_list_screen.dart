import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../common/component/divider_container.dart';
import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../../common/utils/data_utils.dart';
import '../component/order_list_card.dart';
import '../model/order_model.dart';
import '../provider/order_provider.dart';
import 'order_detail_screen.dart';

class OrderListScreen extends ConsumerWidget {
  static String get routeName => 'order_list';

  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderProvider);
    final readyOrders =
        orders.where((e) => e.status == OrderStatus.ready).toList();
    final doingOrders =
        orders.where((e) => e.status == OrderStatus.doing).toList();
    final doneOrders =
        orders.where((e) => e.status == OrderStatus.done).toList();

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '주문 내역'),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: MyColor.middleGrey,
                ),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  renderDeliveryAmount(count: orders.length, title: '전체'),
                  renderDeliveryAmount(count: readyOrders.length, title: '준비중'),
                  renderDeliveryAmount(count: doingOrders.length, title: '배송중'),
                  renderDeliveryAmount(count: doneOrders.length, title: '배송완료'),
                ],
              ),
            ),
          ),
          DeliveryListView(orders: orders),
        ],
      ),
    );
  }

  Widget renderDeliveryAmount({
    required int count,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: MyTextStyle.bigTitleBold,
          ),
          Text(
            title,
            style: MyTextStyle.minimumRegular,
          ),
        ],
      ),
    );
  }
}

class DeliveryListView extends StatelessWidget {
  final List<OrderModel> orders;

  const DeliveryListView({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GroupedListView<OrderModel, String>(
        physics: const BouncingScrollPhysics(),
        elements: orders,
        groupBy: (element) => DataUtils.convertDateTimeToDateTimeString(
          datetime: element.createdAt,
        ),
        groupSeparatorBuilder: (String groupByValue) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DividerContainer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Text(
                groupByValue,
                style: MyTextStyle.bodyRegular,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        itemBuilder: (context, OrderModel element) {
          return InkWell(
            onTap: () {
              context.pushNamed(OrderDetailScreen.routeName, pathParameters: {
                'id': element.id,
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(height: 1.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: OrderListCard(order: element),
                  ),
                ],
              ),
            ),
          );
        },
        itemComparator: (item1, item2) => item1.createdAt.compareTo(
          item2.createdAt,
        ),
        order: GroupedListOrder.DESC,
        separator: Text('asdf'),
      ),
    );
  }
}
