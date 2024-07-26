import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/manufacturing/model/manufacturing_model.dart';
import 'package:ground_b/manufacturing/provider/category_provider.dart';
import 'package:ground_b/manufacturing/provider/manufacturing_provider.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../component/vertical_item_list.dart';

class ManufacturingListScreen extends ConsumerWidget {
  static String get routeName => 'manufacturing_list';

  const ManufacturingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ManufacturingModel> manufactures =
        ref.watch(manufacturingProvider);
    final categories = ref.watch(manufacturingCategoriesProvider);
    final selectedCategory = ref.watch(manufacturingCategorySelectedProvider);

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '제작사 리스트'),
      child: Column(
        children: [
          SizedBox(
            height: 64.0,
            child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(manufacturingCategorySelectedProvider.notifier)
                          .state = category;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
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
          Expanded(
            child: VerticalItemList(manufactures: manufactures),
          ),
        ],
      ),
    );
  }
}
