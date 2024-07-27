import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ground_b/common/utils/data_utils.dart';
import 'package:ground_b/manufacturing/model/manufacturing_model.dart';
import 'package:ground_b/manufacturing/model/manufacturing_request_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
  final bool isSelected;

  const ManufacturingRequestCard({
    super.key,
    required this.id,
    required this.manufacturing,
    required this.categoryStatus,
    required this.majorMaterials,
    required this.uploadFile,
    required this.requestedTerm,
    required this.createdAt,
    this.isSelected = false,
  });

  factory ManufacturingRequestCard.fromModel({
    required ManufacturingRequestModel model,
    bool isSelected = false,
  }) {
    return ManufacturingRequestCard(
      id: model.id,
      manufacturing: model.manufacturing,
      categoryStatus: model.categoryStatus,
      majorMaterials: model.majorMaterials,
      uploadFile: model.uploadFile,
      requestedTerm: model.requestedTerm,
      createdAt: model.createdAt,
      isSelected: isSelected,
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
                    top: 4.0,
                    right: 16.0,
                    bottom: 16.0,
                    left: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            manufacturing.title,
                            style: MyTextStyle.bodyBold,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: PhosphorIcon(
                              PhosphorIcons.caretCircleDown(),
                              size: 32.0,
                              color: MyColor.text,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "요청일시: ${DataUtils.convertDateTimeToDateString(datetime: createdAt)}",
                        style: MyTextStyle.descriptionMedium.copyWith(
                          color: MyColor.darkGrey,
                        ),
                      ),
                      if (isSelected)
                        _DescriptionContainer(
                          manufacturing: manufacturing,
                          categoryStatus: categoryStatus,
                          majorMaterials: majorMaterials,
                          uploadFile: uploadFile,
                          requestedTerm: requestedTerm,
                          createdAt: createdAt,
                        ),
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

class _DescriptionContainer extends StatelessWidget {
  final ManufacturingModel manufacturing;
  final ManufacturingCategoryStatus categoryStatus;
  final MainMaterialStatus majorMaterials;
  final String uploadFile;
  final String requestedTerm;
  final DateTime createdAt;

  const _DescriptionContainer({
    super.key,
    required this.manufacturing,
    required this.categoryStatus,
    required this.majorMaterials,
    required this.uploadFile,
    required this.requestedTerm,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 24.0),
        _renderTitleAndImage(
          title: '제작사\n레퍼런스 이미지',
          imageUrl: manufacturing.referenceImageUrls.first,
        ),
        _renderTitleAndDescription(
          title: '카테고리',
          description: categoryStatus.label,
        ),
        _renderTitleAndDescription(
          title: '주요소재',
          description: majorMaterials.label,
        ),
        _renderTitleAndImage(
          title: '요청\n레퍼런스 이미지',
          imageUrl: manufacturing.referenceImageUrls.last,
        ),
        _renderTitleAndDescription(
          title: '요청사항',
          description: requestedTerm,
        ),
      ],
    );
  }

  Widget _renderTitleAndDescription({
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140.0,
            child: Text(
              title,
              style: MyTextStyle.bodyBold,
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: MyTextStyle.bodyRegular,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderTitleAndImage({
    required String title,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140.0,
            child: Text(
              title,
              style: MyTextStyle.bodyBold,
            ),
          ),
          Expanded(
            child: Image.asset(imageUrl),
          ),
        ],
      ),
    );
  }
}
