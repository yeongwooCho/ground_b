import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/common/component/show/show_custom_toast.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../component/vertical_item_grid.dart';
import '../provider/product_provider.dart';

class MyProductListScreen extends ConsumerWidget {
  static String get routeName => "my_product_list";

  const MyProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider).toList();

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '내 상품'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총 ${products.length}건',
                  style: MyTextStyle.bodyTitleMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    showCustomToast(context, msg: "서비스 준비중입니다.");
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: MyColor.primary,
                    backgroundColor: MyColor.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1.0,
                        color: MyColor.primary,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    textStyle: MyTextStyle.bodyRegular.copyWith(
                      color: MyColor.primary,
                      height: 1.0,
                    ),
                  ),
                  child: Text(
                    '상품 등록',
                    style: MyTextStyle.descriptionRegular.copyWith(
                      color: MyColor.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: VerticalItemGrid(products: products)),
        ],
      ),
    );
  }
}
