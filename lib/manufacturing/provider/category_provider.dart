import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/enum/manufacturing_category_status.dart';

final manufacturingCategorySelectedProvider =
    StateProvider<ManufacturingCategoryStatus>(
  (ref) => ManufacturingCategoryStatus.clothing,
);

final manufacturingCategoriesProvider =
    StateProvider<List<ManufacturingCategoryStatus>>(
  (ref) => [
    ManufacturingCategoryStatus.clothing,
    ManufacturingCategoryStatus.childCare,
    ManufacturingCategoryStatus.miscellaneous,
    ManufacturingCategoryStatus.etc,
    ManufacturingCategoryStatus.overseas,
  ],
);
