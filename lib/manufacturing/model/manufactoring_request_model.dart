import 'package:ground_b/manufacturing/model/manufacturing_model.dart';

import 'enum/manufacturing_category_status.dart';

class ManufacturingRequestModel {
  final String id;
  final ManufacturingModel manufacturing;
  final ManufacturingCategoryStatus categoryStatus;
  final String majorMaterials;
  final String uploadFile;
  final String requestedTerm;

  ManufacturingRequestModel({
    required this.id,
    required this.manufacturing,
    required this.categoryStatus,
    required this.majorMaterials,
    required this.uploadFile,
    required this.requestedTerm,
  });

  ManufacturingRequestModel copyWith({
    String? id,
    ManufacturingModel? manufacturing,
    ManufacturingCategoryStatus? categoryStatus,
    String? majorMaterials,
    String? uploadFile,
    String? requestedTerm,
  }) {
    return ManufacturingRequestModel(
      id: id ?? this.id,
      manufacturing: manufacturing ?? this.manufacturing,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      majorMaterials: majorMaterials ?? this.majorMaterials,
      uploadFile: uploadFile ?? this.uploadFile,
      requestedTerm: requestedTerm ?? this.requestedTerm,
    );
  }
}
