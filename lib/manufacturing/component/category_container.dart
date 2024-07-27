import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ground_b/common/const/colors.dart';
import 'package:ground_b/manufacturing/provider/category_provider.dart';

import '../../common/const/text_styles.dart';
import '../view/manufacturing_list_screen.dart';

class CategoryContainer extends ConsumerWidget {
  const CategoryContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(manufacturingCategoriesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '카테고리',
            style: MyTextStyle.bodyTitleBold,
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: categories
                .map(
                  (e) => InkWell(
                    onTap: () {
                      ref
                          .read(manufacturingCategorySelectedProvider.notifier)
                          .state = e;

                      context.goNamed(ManufacturingListScreen.routeName);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: MyColor.middleGrey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          e.label,
                          style: MyTextStyle.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
