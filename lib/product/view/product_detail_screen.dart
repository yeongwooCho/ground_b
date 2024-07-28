import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hidable/hidable.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cart/provider/cart_provider.dart';
import '../../common/component/default_button.dart';
import '../../common/component/divider_container.dart';
import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../../common/utils/data_utils.dart';
import '../../manufacturing/component/review_container.dart';
import '../../manufacturing/model/review_model.dart';
import '../../order/view/create_order_screen.dart';
import '../component/horizontal_item_list.dart';
import '../model/product_model.dart';
import '../provider/product_provider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'product_detail';

  final String id;

  const ProductDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productDetailProvider(widget.id));
    final productPrefer = ref.watch(productPreferProvider);

    final fullWidth = MediaQuery.of(context).size.width;
    final safeTopPadding = MediaQuery.of(context).padding.top;

    return DefaultLayout(
      appbar: Hidable(
        preferredWidgetSize:
            Size.fromHeight(DefaultAppBar.defaultAppBarHeight + safeTopPadding),
        controller: scrollController,
        child: const DefaultAppBar(title: ''),
      ),
      bottomNavigationBar: Hidable(
        controller: scrollController,
        preferredWidgetSize: const Size.fromHeight(100),
        child: SafeArea(
          bottom: true,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      width: 1.0,
                      color: MyColor.middleGrey,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      ref.read(productProvider.notifier).updateLike(
                            productId: product.id,
                            isLike: !product.isLike,
                          );
                    },
                    icon: product.isLike
                        ? PhosphorIcon(
                            PhosphorIcons.heart(PhosphorIconsStyle.fill),
                            color: MyColor.heart,
                            size: 32.0,
                          )
                        : PhosphorIcon(
                            PhosphorIcons.heart(),
                            color: MyColor.middleGrey,
                            size: 32.0,
                          ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).removeAll();

                      ref
                          .read(cartProvider.notifier)
                          .addProduct(product: product, amount: 1);

                      context.pushNamed(CreateOrderScreen.routeName);
                    },
                    child: const Text('구매하기'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              product.mainImageUrl,
              width: fullWidth,
              height: fullWidth,
              fit: BoxFit.fitWidth,
            ),
            renderProductInfo(product: product),
            const DividerContainer(),
            renderDescriptionImages(detailImages: product.detailImageUrls),
            const SizedBox(height: 40.0),
            const DividerContainer(),
            ReviewContainer(
              title: '문의',
              reviews: [
                ReviewModel(
                  id: '0',
                  title: 'hour01',
                  description: '맞춤형 제품 제작 가능이 가능한가요?',
                  createdAt: DateTime(2024, 7, 13),
                ),
                ReviewModel(
                  id: '1',
                  title: 'thisis0811',
                  description: '최소 주문 수량은 얼마인가요?',
                  createdAt: DateTime(2024, 7, 2),
                ),
                ReviewModel(
                  id: '2',
                  title: 'pressbell0808',
                  description: '상품 주문 후 생산 및 배송 소요 시간이 어떻게 되는지 여쭤봐도 될까요?',
                  createdAt: DateTime(2024, 6, 30),
                ),
              ],
            ),
            const DividerContainer(),
            const Padding(
              padding: EdgeInsets.only(
                  left: 24.0, right: 24.0, top: 20.0, bottom: 8.0),
              child: Text(
                '추천 상품',
                style: MyTextStyle.bodyTitleBold,
              ),
            ),
            HorizontalItemList(products: productPrefer),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  Widget renderProductInfo({
    required ProductModel product,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            product.title,
            style: MyTextStyle.bodyTitleMedium,
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${product.sale}%',
                style: MyTextStyle.bigTitleBold.copyWith(
                  color: MyColor.heart,
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                DataUtils.convertToTotalMoney(
                    price: product.price, sale: product.sale),
                style: MyTextStyle.bigTitleBold,
              ),
              const SizedBox(width: 12.0),
              Text(
                '${DataUtils.convertPriceToMoneyString(price: product.price)} 원',
                style: MyTextStyle.bodyRegular.copyWith(
                  color: MyColor.darkGrey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${DateTime.now().difference(product.createdAt).inDays}일 전',
                style: MyTextStyle.minimumRegular.copyWith(
                  color: MyColor.darkGrey,
                ),
              ),
              Row(
                children: [
                  PhosphorIcon(
                    PhosphorIcons.heart(PhosphorIconsStyle.fill),
                    color: MyColor.heart,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '${product.likes}',
                    style: MyTextStyle.minimumRegular.copyWith(
                      color: MyColor.heart,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderDescriptionImages({
    required List<String> detailImages,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24.0, top: 20.0, bottom: 8.0),
          child: Text(
            '상품 정보',
            style: MyTextStyle.bodyTitleBold,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: detailImages.length,
          itemBuilder: (context, index) {
            return Container(
              color: MyColor.darkGrey,
              child: Image.asset(
                detailImages[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ],
    );
  }
}
