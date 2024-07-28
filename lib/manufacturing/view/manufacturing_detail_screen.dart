import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ground_b/common/layout/default_bottom_button.dart';
import 'package:ground_b/manufacturing/component/manufacturing_card.dart';
import 'package:ground_b/manufacturing/component/review_container.dart';
import 'package:ground_b/manufacturing/model/review_model.dart';
import 'package:ground_b/manufacturing/view/manufacturing_request_screen.dart';

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
      bottomNavigationBar: DefaultBottomButton(
        title: '생산요청',
        onPress: () {
          context.goNamed(
            ManufacturingRequestScreen.routeName,
            pathParameters: {'id': id},
          );
        },
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ManufacturingCard.fromModel(
              model: manufacture,
              isDetail: true,
            ),
            const DividerContainer(topHeight: 20.0, bottomHeight: 20.0),
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
                    style: MyTextStyle.bodyRegular,
                  ),
                ],
              ),
            ),
            const DividerContainer(topHeight: 20.0, bottomHeight: 20.0),
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
            const DividerContainer(topHeight: 20.0, bottomHeight: 20.0),
            ReviewContainer(
              title: '후기',
              reviews: [
                ReviewModel(
                  id: '0',
                  title: 'tongtong',
                  description: '주문이 계속 들어와 또 구매합니다. 감사합니다.',
                  createdAt: DateTime(2024, 7, 3),
                ),
                ReviewModel(
                  id: '1',
                  title: 'thisis0811',
                  description: '묶음 단위로 계산하면 괜찮은 상품 중에서 가장 저렴하네요. 상품 추천 드려요.',
                  createdAt: DateTime(2024, 6, 2),
                ),
                ReviewModel(
                  id: '2',
                  title: 'pressbell0808',
                  description:
                      '안녕하세요! 엄청 좋은 상품이라 리뷰 남겨요!\n배송도 빠르고 상품, 포장상태 전부 마음에 드네요. 다음에도 계속 주문하겠습니다. 감사합니다!',
                  createdAt: DateTime(2024, 5, 30),
                ),
              ],
            ),
            const DividerContainer(topHeight: 20.0, bottomHeight: 20.0),
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
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
