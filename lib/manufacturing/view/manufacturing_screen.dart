import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/image_path.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../component/category_container.dart';
import '../component/manufacturing_request_container.dart';

class ManufacturingScreen extends ConsumerWidget {
  static String get routeName => "manufacturing";

  const ManufacturingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
