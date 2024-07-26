import 'enum/manufacturing_category_status.dart';

class ManufacturingModel {
  final String id;
  final String title;
  final String description;
  final String mainImageUrl;
  final int numberOfProgress;
  final List<String> tags;
  final List<String> referenceImageUrls;
  final ManufacturingCategoryStatus categoryStatus;

  ManufacturingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.mainImageUrl,
    required this.numberOfProgress,
    required this.tags,
    required this.referenceImageUrls,
    required this.categoryStatus,
  });

  ManufacturingModel copyWith({
    String? id,
    String? title,
    String? description,
    String? mainImageUrl,
    int? numberOfProgress,
    List<String>? tags,
    List<String>? referenceImageUrls,
    ManufacturingCategoryStatus? categoryStatus,
  }) {
    return ManufacturingModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      mainImageUrl: mainImageUrl ?? this.mainImageUrl,
      numberOfProgress: numberOfProgress ?? this.numberOfProgress,
      tags: tags ?? this.tags,
      referenceImageUrls: referenceImageUrls ?? this.referenceImageUrls,
      categoryStatus: categoryStatus ?? this.categoryStatus,
    );
  }
}
