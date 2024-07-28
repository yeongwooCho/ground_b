import '../../product/model/product_model.dart';

class CartModel {
  final String id;
  final ProductModel product;
  final int amount;
  final bool isSelected;

  CartModel({
    required this.id,
    required this.product,
    required this.amount,
    required this.isSelected,
  });

  CartModel copyWith({
    String? id,
    ProductModel? product,
    int? amount,
    bool? isSelected,
  }) {
    return CartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      amount: amount ?? this.amount,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
