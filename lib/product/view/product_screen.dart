import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/common/component/custom_drop_down_single.dart';
import 'package:ground_b/product/provider/product_filter_provider.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../component/vertical_item_grid.dart';
import '../provider/is_sale_provider.dart';
import '../provider/product_category_provider.dart';
import '../provider/product_provider.dart';

class ProductScreen extends ConsumerWidget {
  static String get routeName => "product";

  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final products = ref.watch(productProvider);
    final categories = ref.watch(productCategoriesProvider);
    final selectedCategory = ref.watch(productCategorySelectedProvider);
    final filters = ref.watch(productFiltersProvider);
    final selectedFilter = ref.watch(productFilterSelectedProvider);
    final randomProducts = ref.watch(productRandomProvider);
    final isSales = ref.watch(isSaleProvider);

    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '상품 리스트',
        centerTitle: false,
        action: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: AnimatedToggleSwitch<bool>.rolling(
              indicatorSize: const Size(72.0, double.infinity),
              current: isSales,
              values: const [true, false],
              height: 48.0,
              onChanged: (bool value) {
                ref.read(isSaleProvider.notifier).state = value;
              },
              iconList: [
                Text(
                  '판매상품',
                  style: MyTextStyle.descriptionBold.copyWith(
                    color: isSales ? MyColor.white : MyColor.primary,
                  ),
                ),
                Text(
                  '구매요청',
                  style: MyTextStyle.descriptionBold.copyWith(
                    color: isSales ? MyColor.primary : MyColor.white,
                  ),
                ),
              ],
              style: const ToggleStyle(
                backgroundColor: MyColor.white,
                indicatorColor: MyColor.primary,
                borderColor: MyColor.text,
              ), // optional style settings
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80.0,
            child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final category = categories[index];

                return Container(
                  decoration: BoxDecoration(
                    color:
                        selectedCategory == category ? MyColor.primary : null,
                    border: Border.all(
                      width: 1.0,
                      color: selectedCategory == category
                          ? MyColor.empty
                          : MyColor.middleGrey,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      ref.read(productCategorySelectedProvider.notifier).state =
                          category;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        category.label,
                        style: MyTextStyle.bodyRegular.copyWith(
                          color: selectedCategory == category
                              ? MyColor.white
                              : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 8.0);
              },
              itemCount: categories.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총 ${randomProducts.length}건',
                  style: MyTextStyle.bodyBold,
                ),
                SizedBox(
                  width: 150.0,
                  child: CustomSingleDropDown(
                    dropdownList: filters.map((e) => e.label).toList(),
                    hintText: '필터',
                    dropdownHeight: 200,
                    onChanged: (String value) {
                      final selectedItem = filters
                          .where((element) => element.label == value)
                          .first;
                      ref.read(productFilterSelectedProvider.notifier).state =
                          selectedItem;
                    },
                    defaultValue: selectedFilter.label,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: VerticalItemGrid(products: randomProducts),
          ),
        ],
      ),
    );
  }

  void onChanged(String value) {
    print(value);
  }
}
