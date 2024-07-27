import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/product/model/enum/product_filter_status.dart';

import '../model/enum/product_category_status.dart';

final productFilterSelectedProvider = StateProvider<ProductFilterStatus>(
      (ref) => ProductFilterStatus.recommend,
);

final productFiltersProvider = StateProvider<List<ProductFilterStatus>>(
      (ref) => ProductFilterStatus.values.toList(),
);
