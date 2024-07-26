import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/user/provider/user_provider.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../user/model/user_model.dart';

class ManufacturingRequestContainer extends ConsumerWidget {
  const ManufacturingRequestContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModel user = ref.watch(userProvider) as UserModel;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${user.name}님의 생산요청 현황',
            style: MyTextStyle.bodyTitleMedium,
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _RequestButton(
                title: '생산요청',
                count: 13,
                onTap: () {
                  // ref
                  //     .read(productCategorySelectedProvider.notifier)
                  //     .update((state) => ProductCategoryStatus.foreignSales);
                  // context.pushNamed(ProductFullListScreen.routeName);
                },
              ),
              _RequestButton(title: '요청확인', count: 13, onTap: () {}),
              _RequestButton(title: '제작중', count: 13, onTap: () {}),
              _RequestButton(title: '제작완료', count: 13, onTap: () {}),
              _RequestButton(title: '확정', count: 13, onTap: () {}),
            ],
          )
        ],
      ),
    );
  }
}

class _RequestButton extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onTap;

  const _RequestButton({
    super.key,
    required this.title,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final itemWidth = (MediaQuery.of(context).size.width - 48 - 8) / 2;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: MyColor.middleGrey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: MyTextStyle.bodyBold,
              ),
              Text(
                count.toString(),
                style: MyTextStyle.bodyRegular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
