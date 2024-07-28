import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/component/custom_drop_down_single.dart';
import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';

class TossPaymentContainer extends StatefulWidget {
  final ValueChanged onChanged;

  const TossPaymentContainer({
    super.key,
    required this.onChanged,
  });

  @override
  State<TossPaymentContainer> createState() => _TossPaymentContainerState();
}

class _TossPaymentContainerState extends State<TossPaymentContainer> {
  List<String> cards = [
    '카드사 선택',
    '국민카드',
    '현대카드',
    '삼성카드',
    '롯데카드',
    '비씨카드',
    '하나카드',
  ];
  String card = '카드사 선택';

  @override
  Widget build(BuildContext context) {
    const double horizontal = 24.0;
    const double spacing = 8.0;

    final itemWidth =
        (MediaQuery.of(context).size.width - (horizontal * 2) - (spacing * 2)) /
            3;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '결제 방법',
            style: MyTextStyle.bodyTitleMedium,
          ),
          const SizedBox(height: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Badge(
                alignment: Alignment.topLeft,
                largeSize: 32.0,
                offset: const Offset(-4, -8),
                backgroundColor: MyColor.error,
                textStyle: MyTextStyle.descriptionBold.copyWith(
                  color: MyColor.white,
                  fontSize: 14.0,
                  height: 1,
                ),
                label: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: Text('혜택'),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: MyColor.text,
                          width: 2.0,
                        )),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          '신용 · 체크카드',
                          style: MyTextStyle.bodyBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  renderBoxButton(
                    itemWidth: itemWidth,
                    image: Image.asset('asset/img/payment/naver.png'),
                  ),
                  const SizedBox(width: 8.0),
                  renderBoxButton(
                    itemWidth: itemWidth,
                    image: Image.asset('asset/img/payment/kakao.png'),
                  ),
                  const SizedBox(width: 8.0),
                  renderBoxButton(
                    itemWidth: itemWidth,
                    image: Image.asset('asset/img/payment/payco.png'),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  renderBoxButton(
                    itemWidth: itemWidth,
                    image: Image.asset('asset/img/payment/toss.png'),
                  ),
                  const SizedBox(width: 8.0),
                  renderBoxButton(
                    itemWidth: itemWidth,
                    image: const Text(
                      '가상계좌',
                      style: MyTextStyle.descriptionMedium,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  renderBoxButton(
                    itemWidth: itemWidth,
                    image: const Text(
                      '휴대폰',
                      style: MyTextStyle.descriptionMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Container(
                width: itemWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: MyColor.middleGrey,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '더보기',
                          style: MyTextStyle.descriptionMedium,
                        ),
                        const SizedBox(width: 8.0),
                        PhosphorIcon(
                          PhosphorIcons.caretDown(PhosphorIconsStyle.bold),
                          size: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              CustomSingleDropDown(
                dropdownList: [
                  '국민카드',
                  '현대카드',
                  '삼성카드',
                  '롯데카드',
                  '비씨카드',
                  '하나카드',
                ],
                hintText: '카드사 선택',
                onChanged: widget.onChanged,
                dropdownHeight: 220,
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  const Text(
                    '신용카드 무이자 할부 안내',
                    style: MyTextStyle.minimumRegular,
                  ),
                  PhosphorIcon(
                    PhosphorIcons.caretRight(),
                    size: 16.0,
                    color: MyColor.darkGrey,
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: PhosphorIcon(
                      PhosphorIcons.check(PhosphorIconsStyle.bold),
                      color: MyColor.primary,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: Text(
                      '[필수] 결제 서비스 이용 약관, 개인 정보 처리 동의',
                      style: MyTextStyle.descriptionRegular.copyWith(
                        color: MyColor.darkGrey,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  PhosphorIcon(
                    PhosphorIcons.caretRight(),
                    size: 20.0,
                    color: MyColor.darkGrey,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderBoxButton({
    required Widget image,
    required double itemWidth,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: itemWidth,
        height: itemWidth * 2 / 3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: MyColor.middleGrey,
              width: 1.0,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Center(
            child: image,
          ),
        ),
      ),
    );
  }
}
