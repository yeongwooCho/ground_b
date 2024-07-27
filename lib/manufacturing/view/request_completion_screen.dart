import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ground_b/common/const/colors.dart';
import 'package:ground_b/common/layout/default_bottom_button.dart';

import '../../common/const/text_styles.dart';
import '../../common/layout/default_layout.dart';
import '../../home/view/home_screen.dart';

class RequestCompletionScreen extends StatelessWidget {
  static String get routeName => 'request_completion';

  const RequestCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: DefaultBottomButton(
        title: '홈으로 이동',
        onPress: () {
          context.goNamed(HomeScreen.routeName);
        },
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 140.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '제작 요청이\n완료되었습니다.',
              style: MyTextStyle.headTitle,
            ),
            const SizedBox(height: 20.0),
            const Text(
              '제작사 확인 후 고객님의',
              style: MyTextStyle.bodyMedium,
            ),
            Text(
              '연락처로 답변이 전달될 예정입니다!',
              style: MyTextStyle.bodyMedium.copyWith(
                color: MyColor.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
