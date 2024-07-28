import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/common/const/image_path.dart';
import 'package:ground_b/product/model/enum/product_category_status.dart';
import 'package:ground_b/product/provider/product_filter_provider.dart';

import '../../common/const/data.dart';
import '../../common/utils/data_utils.dart';
import '../model/product_model.dart';
import 'is_sale_provider.dart';
import 'product_category_provider.dart';

final productByCategoryProvider = Provider<List<ProductModel>>((ref) {
  final products = ref.watch(productProvider);
  final selectedCategory = ref.watch(productCategorySelectedProvider);
  final categoryProducts = products
      .where((element) => element.categoryStatus == selectedCategory)
      .toList();

  final selectedFilter = ref.watch(productFilterSelectedProvider);
  final isSale = ref.watch(isSaleProvider);

  final randomProducts =
      DataUtils.getRandomShuffledList<ProductModel>(categoryProducts);
  return randomProducts;
});

final productPreferProvider = Provider<List<ProductModel>>((ref) {
  final products = ref.watch(productProvider);

  // 카테고리, 필터, 판매구매 상태 변경 시 추천상품 변경
  final selectedCategory = ref.watch(productCategorySelectedProvider);
  final selectedFilter = ref.watch(productFilterSelectedProvider);
  final isSale = ref.watch(isSaleProvider);

  final pairProducts = DataUtils.getRandomShuffledList<ProductModel>(products);
  return pairProducts.take(4).toList();
});

final productDetailProvider = Provider.family<ProductModel, String>((ref, id) {
  final product =
      ref.watch(productProvider).firstWhere((element) => element.id == id);
  return product;
});

final productProvider =
    StateNotifierProvider<ProductStateNotifier, List<ProductModel>>((ref) {
  return ProductStateNotifier();
});

class ProductStateNotifier extends StateNotifier<List<ProductModel>> {
  ProductStateNotifier() : super([]) {
    state = getItems();
  }

  void updateLike({
    required String productId,
    required bool isLike,
  }) {
    state = state.map((element) {
      if (element.id == productId) {
        if (isLike) {
          return element.copyWith(isLike: isLike, likes: element.likes + 1);
        } else {
          return element.copyWith(isLike: isLike, likes: element.likes - 1);
        }
      } else {
        return element;
      }
    }).toList();
  }

  List<ProductModel> getItems() {
    final now = DateTime.now();
    final createdAt = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final products = productItems;

    return List.generate(
      products.length,
      (index) => ProductModel(
        id: index.toString(),
        title: products.keys.toList()[index],
        price: products.values.toList()[index],
        sale: (DataUtils.getRandomInt(dividerNumber: 3) * 5) + 10,
        mainImageUrl: getImageUrl(index: index),
        detailImageUrls: [
          'asset/img/product/0/0.png',
          'asset/img/product/0/1.png',
          'asset/img/product/0/2.png',
        ],
        isLike: false,
        likes: DataUtils.getRandomDouble(min: 243.0, range: 500).toInt(),
        createdAt: createdAt.subtract(Duration(
          days: DataUtils.getRandomDouble(min: 1.0, range: 10).toInt(),
        )),
        categoryStatus: getCategory(index: index),
      ),
    );
  }

  String getImageUrl({
    required int index,
  }) {
    late String returnDirectory;

    switch (index) {
      case < 8:
        returnDirectory = ImagePath.productManDirectory;
      case >= 8 && < 16:
        returnDirectory = ImagePath.productWomanDirectory;
      case >= 16 && < 24:
        returnDirectory = ImagePath.productOuterDirectory;
      case >= 24 && < 32:
        returnDirectory = ImagePath.productMiscellaneousDirectory;
    }

    return '$returnDirectory${index % 8}.png';
  }

  ProductCategoryStatus getCategory({
    required int index,
  }) {
    switch (index) {
      case < 8:
        return ProductCategoryStatus.man;
      case >= 8 && < 16:
        return ProductCategoryStatus.woman;

      case >= 16 && < 24:
        return ProductCategoryStatus.outer;

      case >= 24 && < 32:
        return ProductCategoryStatus.miscellaneous;
      default:
        return ProductCategoryStatus.man;
    }
  }
}
