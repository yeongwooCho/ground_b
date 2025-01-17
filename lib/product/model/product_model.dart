import '../../user/model/user_model.dart';
import 'enum/product_category_status.dart';

class ProductModel {
  final String id;
  final String title;
  final int price;
  final int sale;
  final String mainImageUrl;
  final List<String> detailImageUrls;
  final bool isLike;
  final int likes;
  final DateTime createdAt;
  final ProductCategoryStatus categoryStatus;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.sale,
    required this.mainImageUrl,
    required this.detailImageUrls,
    required this.isLike,
    required this.likes,
    required this.createdAt,
    required this.categoryStatus,
  });

  ProductModel copyWith({
    String? id,
    String? title,
    int? price,
    int? sale,
    String? mainImageUrl,
    List<String>? detailImageUrls,
    bool? isLike,
    int? likes,
    DateTime? createdAt,
    ProductCategoryStatus? categoryStatus,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      sale: sale ?? this.sale,
      mainImageUrl: mainImageUrl ?? this.mainImageUrl,
      detailImageUrls: detailImageUrls ?? this.detailImageUrls,
      isLike: isLike ?? this.isLike,
      likes: likes ?? this.likes,
      createdAt: createdAt ?? this.createdAt,
      categoryStatus: categoryStatus ?? this.categoryStatus,
    );
  }
}
