import 'package:flutter/material.dart';
import 'package:ground_b/common/const/colors.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/const/text_styles.dart';
import '../../common/utils/data_utils.dart';
import '../model/product_model.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String title;
  final int price;
  final int sale;
  final String mainImageUrl;
  final List<String> detailImageUrls;
  final bool isLike;
  final int likes;
  final DateTime createdAt;

  // widget property
  final String? heroKey; // 히어로 위젯 키
  final bool isSale; // sale, purchase
  final double? itemWidth;

  const ProductCard({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.sale,
    required this.mainImageUrl,
    required this.detailImageUrls,
    required this.isLike,
    required this.likes,
    required this.createdAt,
    this.heroKey,
    this.isSale = true,
    this.itemWidth,
  });

  factory ProductCard.fromModel({
    required ProductModel model,
    bool isSale = true,
    double? itemWidth,
  }) {
    return ProductCard(
      heroKey: model.id,
      id: model.id,
      title: model.title,
      price: model.price,
      sale: model.sale,
      mainImageUrl: model.mainImageUrl,
      detailImageUrls: model.detailImageUrls,
      isLike: model.isLike,
      likes: model.likes,
      createdAt: model.createdAt,
      isSale: isSale,
      itemWidth: itemWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = price * (100 - sale) ~/ 100;

    return SizedBox(
      width: itemWidth ?? 156.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            mainImageUrl,
            fit: BoxFit.cover,
            height: itemWidth ?? 156.0,
          ),
          const SizedBox(height: 6.0),
          Text(
            title,
            style: MyTextStyle.descriptionRegular,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6.0),
          Text(
            isSale ? '판매가' : '희망 구매가격',
            style: MyTextStyle.descriptionRegular.copyWith(
              color: MyColor.darkGrey,
            ),
            textAlign: TextAlign.end,
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PhosphorIcon(
                    PhosphorIcons.heart(PhosphorIconsStyle.fill),
                    color: MyColor.heart,
                    size: 20.0,
                  ),
                  const SizedBox(width: 2.0),
                  Text(
                    likes.toString(),
                    style: MyTextStyle.minimumRegular.copyWith(
                      color: MyColor.heart,
                    ),
                  ),
                ],
              ),
              Text(
                '${DataUtils.convertPriceToMoneyString(price: totalPrice)} 원',
                style: MyTextStyle.bodyBold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
