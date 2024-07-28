import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ground_b/product/component/product_card.dart';
import 'package:ground_b/product/provider/is_sale_provider.dart';
import 'package:ground_b/product/view/product_purchase_detail_screen.dart';

import '../model/product_model.dart';
import '../view/product_detail_screen.dart';

class VerticalItemGrid extends ConsumerWidget {
  final List<ProductModel> products;

  const VerticalItemGrid({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isSale = ref.watch(isSaleProvider);

    const double itemSpacing = 16.0;
    const double horizontalPadding = 24.0;
    final double itemWidth = (MediaQuery.of(context).size.width -
            (horizontalPadding * 2) -
            itemSpacing) /
        2;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: horizontalPadding,
      ),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: itemWidth / (itemWidth + 108),
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return GestureDetector(
          onTap: () {
            print(isSale);
            if (isSale) {
              context.pushNamed(
                ProductDetailScreen.routeName,
                pathParameters: {'id': product.id.toString()},
              );
            } else {
              context.pushNamed(
                ProductPurchaseDetailScreen.routeName,
                pathParameters: {'id': product.id.toString()},
              );
            }
          },
          child: ProductCard.fromModel(
            model: product,
            itemWidth: itemWidth,
            isSale: isSale,
          ),
        );
      },
    );
  }
}
