import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/common/component/horizontal_page_view.dart';
import 'package:ground_b/manufacturing/component/manufacturing_card.dart';
import 'package:ground_b/manufacturing/provider/manufacturing_provider.dart';
import 'package:ground_b/user/model/user_model.dart';
import 'package:ground_b/user/provider/user_provider.dart';

import '../../common/const/image_path.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../component/category_container.dart';
import '../component/manufacturing_request_container.dart';

class ManufacturingScreen extends ConsumerWidget {
  static String get routeName => "manufacturing";

  const ManufacturingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manufactures = ref.watch(manufacturingProvider);
    final user = ref.watch(userProvider) as UserModel;

    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '그라운드 온',
        centerTitle: false,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(ImagePath.manufacturingBanner),
            const SizedBox(height: 40.0),
            const ManufacturingRequestContainer(),
            const SizedBox(height: 40.0),
            const CategoryContainer(),
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                '${user.name}님께 추천드려요',
                style: MyTextStyle.bodyTitleMedium,
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 300.0,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    "${ImagePath.manufacturingDirectory}0.png",
                    width: 160.0,
                    height: 260.0,
                    fit: BoxFit.fill,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 8.0);
                },
                itemCount: 6,
              ),
            ),
            const SizedBox(height: 40.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                '최근 인기 제작사',
                style: MyTextStyle.bodyTitleMedium,
              ),
            ),
            HorizontalPageView(
              height: 350.0,
              itemCount: manufactures.length,
              itemBuilder: (BuildContext context, int index) {
                final manufacture = manufactures[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  child: ManufacturingCard.fromModel(model: manufacture),
                );
              },
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
