import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';

class ProductScreen extends ConsumerWidget {
  static String get routeName => "product";

  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final products = ref.watch(productProvider);

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '마켓'),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40.0),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
