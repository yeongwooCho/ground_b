import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/common/layout/default_bottom_button.dart';
import 'package:ground_b/manufacturing/component/manufacturing_card.dart';

import '../../common/component/divider_container.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../provider/manufacturing_provider.dart';

class ManufacturingDetailScreen extends ConsumerWidget {
  static String get routeName => 'manufacturing_detail';

  final String id;

  const ManufacturingDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final referenceItemWidth = (MediaQuery.of(context).size.width - 48 - 8) / 2;
    final manufacture = ref.watch(manufacturingDetailProvider(id));

    return DefaultLayout(
      appbar: DefaultAppBar(title: manufacture.title),
      bottomNavigationBar: DefaultBottomButton(title: '생산요청', onPress: () {}),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ManufacturingCard.fromModel(
              model: manufacture,
              isDetail: true,
            ),
            const DividerContainer(topHeight: 20.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '소개',
                    style: MyTextStyle.bodyTitleBold,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    manufacture.description,
                    style: MyTextStyle.descriptionRegular,
                  ),
                ],
              ),
            ),
            const DividerContainer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '레퍼런스',
                    style: MyTextStyle.bodyTitleBold,
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      ...manufacture.referenceImageUrls.map(
                        (e) => Image.asset(
                          e,
                          width: referenceItemWidth,
                          height: referenceItemWidth / 160 * 260,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const DividerContainer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '레퍼런스',
                    style: MyTextStyle.bodyTitleBold,
                  ),
                  const SizedBox(height: 12.0),
                  // Wrap(
                  //   spacing: 8.0,
                  //   runSpacing: 8.0,
                  //   children: pt.detailImages
                  //       .map(
                  //         (e) => Image.asset(e,
                  //             fit: BoxFit.fitHeight,
                  //             width: imageWidth,
                  //             height: imageWidth),
                  //       )
                  //       .toList(),
                  // )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
