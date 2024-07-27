import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/enum/product_category_status.dart';

final productCategorySelectedProvider = StateProvider<ProductCategoryStatus>(
  (ref) => ProductCategoryStatus.man,
);

final productCategoriesProvider = StateProvider<List<ProductCategoryStatus>>(
  (ref) => ProductCategoryStatus.values.toList(),
);
