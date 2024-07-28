import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/common/const/image_path.dart';
import 'package:ground_b/product/provider/product_filter_provider.dart';

import '../../common/const/data.dart';
import '../../common/utils/data_utils.dart';
import '../model/product_model.dart';
import 'product_category_provider.dart';

final productRandomProvider = Provider<List<ProductModel>>((ref) {
  final products = ref.watch(productProvider);
  final selectedCategory = ref.watch(productCategorySelectedProvider);
  final selectedFilter = ref.watch(productFilterSelectedProvider);

  final randomProducts =
      DataUtils.getRandomShuffledList<ProductModel>(products);
  return randomProducts;
});

final productPreferProvider = Provider<List<ProductModel>>((ref) {
  final products = ref.watch(productProvider);

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
        sale: index + 10,
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
}
