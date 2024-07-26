import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ground_b/manufacturing/view/manufacturing_screen.dart';
import 'package:ground_b/product/view/product_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/const/colors.dart';
import '../../common/const/data.dart';
import '../../common/const/image_path.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../../notification/view/notification_screen.dart';

class HomeScreen extends ConsumerWidget {
  static String get routeName => "home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '',
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(ImagePath.logo),
        ),
        leadingWidth: 110,
        action: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                context.pushNamed(NotificationScreen.routeName);
              },
              icon: PhosphorIcon(
                PhosphorIcons.bell(),
                size: 28.0,
              ),
            ),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(ImagePath.homeBanner),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Row(
                children: [
                  _renderRouterButton(
                    title: "생산 의뢰",
                    iconData: PhosphorIcons.handshake(),
                    onTap: () {
                      context.goNamed(ManufacturingScreen.routeName);
                    },
                  ),
                  const SizedBox(width: 8.0),
                  _renderRouterButton(
                    title: "리셀 마켓",
                    iconData: PhosphorIcons.storefront(),
                    onTap: () {
                      context.goNamed(ProductScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            const _Footer(),
          ],
        ),
      ),
    );
  }

  Widget _renderRouterButton({
    required String title,
    required IconData iconData,
    required Function() onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: MyColor.middleGrey,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhosphorIcon(
                  iconData,
                  size: 30.0,
                  color: MyColor.primary,
                ),
                const SizedBox(width: 8.0),
                Text(
                  title,
                  style: MyTextStyle.bodyTitleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColor.lightGrey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final title = footerData[index];

            return Padding(
              padding: EdgeInsets.only(top: (index == 4) ? 12.0 : 0.0),
              child: Text(
                title,
                style: (index == 0 || index == 4)
                    ? MyTextStyle.minimumRegular.copyWith(
                        fontWeight: FontWeight.bold,
                        color: MyColor.darkGrey,
                      )
                    : MyTextStyle.minimumRegular.copyWith(
                        color: MyColor.darkGrey,
                      ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 4.0);
          },
          itemCount: footerData.length,
        ),
      ),
    );
  }
}
