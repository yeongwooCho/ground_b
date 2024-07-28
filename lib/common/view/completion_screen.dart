import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ground_b/common/const/colors.dart';
import 'package:ground_b/common/layout/default_bottom_button.dart';

import '../../home/view/home_screen.dart';
import '../const/text_styles.dart';
import '../layout/default_layout.dart';

class CompletionScreen extends StatelessWidget {
  static String get routeName => 'completion';

  final String title;
  final String? description;

  const CompletionScreen({
    super.key,
    required this.title,
    this.description,
  });

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
            Text(
              title,
              style: MyTextStyle.headTitle,
            ),
            const SizedBox(height: 20.0),
            if (description != null)
              Text(
                description!,
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
