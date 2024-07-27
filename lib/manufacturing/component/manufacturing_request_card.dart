import 'package:flutter/material.dart';
import 'package:ground_b/common/utils/data_utils.dart';
import 'package:ground_b/manufacturing/model/manufacturing_model.dart';
import 'package:ground_b/manufacturing/model/manufacturing_request_model.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../model/enum/main_material_status.dart';
import '../model/enum/manufacturing_category_status.dart';

class ManufacturingRequestCard extends StatelessWidget {
  final String id;
  final ManufacturingModel manufacturing;
  final ManufacturingCategoryStatus categoryStatus;
  final MainMaterialStatus majorMaterials;
  final String uploadFile;
  final String requestedTerm;
  final DateTime createdAt;

  const ManufacturingRequestCard({
    super.key,
    required this.id,
    required this.manufacturing,
    required this.categoryStatus,
    required this.majorMaterials,
    required this.uploadFile,
    required this.requestedTerm,
    required this.createdAt,
  });

  factory ManufacturingRequestCard.fromModel({
    required ManufacturingRequestModel model,
  }) {
    return ManufacturingRequestCard(
      id: model.id,
      manufacturing: model.manufacturing,
      categoryStatus: model.categoryStatus,
      majorMaterials: model.majorMaterials,
      uploadFile: model.uploadFile,
      requestedTerm: model.requestedTerm,
      createdAt: model.createdAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width - 24;

    return Container(
      decoration: const BoxDecoration(
        color: MyColor.empty,
        boxShadow: [
          BoxShadow(
            color: MyColor.shadow,
            blurRadius: 8.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          color: MyColor.white,
          child: Column(
            children: [
              Image.asset(
                manufacturing.mainImageUrl,
                fit: BoxFit.fill,
                height: 200.0,
                width: cardWidth,
                // height: 200.0,
              ),
              SizedBox(
                width: cardWidth,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                    left: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        manufacturing.title,
                        style: MyTextStyle.bodyBold,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "요청일시: ${DataUtils.convertDateTimeToDateString(datetime: createdAt)}",
                        style: MyTextStyle.bodyRegular.copyWith(
                          color: MyColor.darkGrey,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
