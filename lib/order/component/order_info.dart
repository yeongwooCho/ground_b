import 'package:flutter/material.dart';

import '../../common/const/text_styles.dart';
import '../../common/utils/data_utils.dart';
import '../../user/model/user_model.dart';

class OrderInfo extends StatelessWidget {
  final UserModel user;
  final int productPrice;
  final int totalPrice;

  const OrderInfo({
    super.key,
    required this.user,
    required this.productPrice,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
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
            title: '주문자',
            description: user.name,
            isEmphasis: false,
          ),
          const SizedBox(height: 4.0),
          _renderTitleAndDescription(
            title: '주문자 연락처',
            description: user.phone,
            isEmphasis: false,
          ),
          const SizedBox(height: 4.0),
          _renderTitleAndDescription(
            title: '상품 금액',
            description:
                '${DataUtils.convertPriceToMoneyString(price: productPrice)} 원',
            isEmphasis: false,
          ),
          const SizedBox(height: 4.0),
          _renderTitleAndDescription(
            title: '할인 금액',
            description:
                '${DataUtils.convertPriceToMoneyString(price: productPrice - totalPrice)} 원',
            isEmphasis: false,
          ),
          const SizedBox(height: 4.0),
          _renderTitleAndDescription(
            title: '최종 결제 금액',
            description:
                '${DataUtils.convertPriceToMoneyString(price: totalPrice)} 원',
            isEmphasis: true,
          ),
        ],
      ),
    );
  }

  Widget _renderTitleAndDescription({
    required String title,
    required String description,
    required bool isEmphasis,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: isEmphasis
                ? MyTextStyle.bodyBold
                : MyTextStyle.descriptionRegular,
          ),
          Text(
            description,
            style: isEmphasis
                ? MyTextStyle.bodyBold
                : MyTextStyle.descriptionRegular,
          ),
        ],
      ),
    );
  }
}
